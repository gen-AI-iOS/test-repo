//
//  ViewController.swift
//  COPILOT
//
//  Created by YabeTatuki on 2024/08/21.
//

import UIKit
// 画像認識のためのライブラリ
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var imageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // selectButtonのテキストをSelect Imageにする
        selectButton.setTitle("Select Image", for: .normal)
        // imageLabelを全行表示する
        imageLabel.numberOfLines = 0
    }

    @IBAction func selectButtonAction(_ sender: Any) {
        // 画像選択
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }

    // 画像選択後の処理
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
            imageToString(image: image)
        }
        self.dismiss(animated: true, completion: nil)
    }
    func imageToString(image: UIImage) {
        
        // 画像をCoreMLに渡す
        guard let ciimage = CIImage(image: image) else {
            fatalError("Unable to create ciimage")
        }
        let handler = VNImageRequestHandler(ciImage: ciimage, options: [:])
        
        // テキスト認識リクエストを作成
        let request = VNRecognizeTextRequest { request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation] else {
                fatalError("Unable to get observations from request")
            }
            // 認識された画像の中の全てのテキストを取得
            let recognizedStrings = observations.compactMap({ $0.topCandidates(1).first?.string })
            self.imageLabel.text = recognizedStrings.joined(separator: "\n")
            print(recognizedStrings)
            
        }
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
    }
}
