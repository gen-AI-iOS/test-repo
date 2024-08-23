//
//  TestAiViewController.swift
//  AifulApp-staging
//
//  Created by YabeTatuki on 2024/08/20.
//  Copyright © 2024 アイフル. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Actions
    // ボタンのタップ時の処理を追加
    // メソッド名はdidTapButton
    // randomメソッドを呼び出し、返却値が１０以上だったら「10以上です」とアラートを表示する
    // それ以外は「10未満です」とアラートを表示する
    // do-catchを使用してエラーハンドリングを行う
    @IBAction func didTapButton(_ sender: Any) {
        let number = random()
        do {
            if number >= 10 {
                showAlert(message: "10以上です")
            } else {
                showAlert(message: "10未満です")
            }
        } catch {
            showAlert(message: "エラーが発生しました")
        }
    }
    
    // ランダムで１から１０の整数を返却する
    // メソッド名はramdom
    // 引数はなし
    // 戻り値はInt型
    func random() -> Int {
        return Int.random(in: 1...10)
    }
    
    // アラートを表示する
    // メソッド名はshowAlert
    // 引数はmessage:String型
    // 「Cannot find 'showAlert' in scop」のエラーを解決するようなメソッド
    func showAlert(message: String) {
        let alert = UIAlertController(title: "結果", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
