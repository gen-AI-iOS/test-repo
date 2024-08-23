//
//  ViewController.swift
//  COPILOT
//
//  Created by YabeTatuki on 2024/08/21.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // cameraButtonのテキストをOpen Cameraに設定
        cameraButton.setTitle("Open Camera", for: .normal)
    }
    
    // cameraButtonが押された時の処理
    @IBAction func cameraButtonTapped(_ sender: UIButton) {
        // UIImagePickerControllerのインスタンスを作成
        let picker = UIImagePickerController()
        // カメラを起動
        picker.sourceType = .camera
        // デリゲートを設定
        picker.delegate = self
        // UIImagePickerControllerを表示
        present(picker, animated: true, completion: nil)
    }
    // Delegate method after capturing image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = pickedImage
        }
        // UIImagePickerControllerを閉じる
        picker.dismiss(animated: true, completion: nil)
    }
    
    // Delegate method for cancelling the image picker
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
