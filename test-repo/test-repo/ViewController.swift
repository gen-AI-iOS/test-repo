//
//  TestAiViewController.swift
//  AifulApp-staging
//
//  Created by YabeTatuki on 2024/08/20.
//  Copyright © 2024 アイフル. All rights reserved.
//

import UIKit
// 画像識別のためのライブラリ
import Vision
import CoreML

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var imageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // buttonのテキストをSelect Imageにする
        button.setTitle("Select Image", for: .normal)
        // imageLAbelの行数を無限にする
        imageLabel.numberOfLines = 0
        
    }
    
    @IBAction func selectImage(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    // 画像選択後の処理
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imageView.image = selectedImage
        
        recognizeText(from: selectedImage)
        picker.dismiss(animated: true, completion: nil)
    }
    func recognizeText(from image: UIImage) {
        // 画像からCIImageを生成
        guard let ciImage = CIImage(image: image) else {
            fatalError("Failed to convert UIImage to CIImage")
        }
        
        // 画像からVNImageRequestHandlerを生成
        let handler = VNImageRequestHandler(ciImage: ciImage)
        
        // テキスト認識リクエストを生成
        let request = VNRecognizeTextRequest { (request, error) in
            guard let observations = request.results as? [VNRecognizedTextObservation] else {
                fatalError("Failed to get result")
            }
            
            // 認識されたテキストを取得
            var recognizedText = ""
            for observation in observations {
                guard let topCandidate = observation.topCandidates(1).first else {
                    print("No candidate")
                    continue
                }
                recognizedText += topCandidate.string + "\n"
            }
            
            // 認識されたテキストをラベルに表示
            DispatchQueue.main.async {
                self.imageLabel.text = recognizedText
            }
        }
        
        // テキスト認識リクエストを実行
        do {
            try handler.perform([request])
        } catch {
            print("Failed to perform request")
        }
    }
}
