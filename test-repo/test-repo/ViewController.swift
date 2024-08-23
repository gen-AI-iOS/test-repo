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
    // ボタンが押下されたら画面を遷移する
    // StoryboardでStorybordIDを設定していることを前提とする
    // 遷移方法はpresentを使用する
    @IBAction func didTapButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SecondViewController")
        present(viewController, animated: true, completion: nil)
    }
}
