//
//  ViewController.swift
//  COPILOT
//
//  Created by YabeTatuki on 2024/08/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapButton(_ sender: Any) {
         // Buttonタップ時にダイアログを表示する処理
        let alert = UIAlertController(title: "タイトル", message: "メッセージ", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
    
}
