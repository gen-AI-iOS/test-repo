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
    
    // API通信を行う
    // 画面遷移する
    // 遷移先でAPIのレスポンスを表示する
    @IBAction func didTapButton(_ sender: Any) {
        DispatchQueue.global().async {
            self.fetchGithubUserInfo()
        }
    }
    
    func fetchGithubUserInfo() {
        let url = URL(string: "https://api.github.com/users/gen-AI-iOS")!
        // API通信中はインジケーターを表示する
        // UIActivityIndicatorView.init(style:) must be used from main thread onlyを解決
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.center = self.view.center
        indicator.startAnimating()
        DispatchQueue.main.async {
            self.view.addSubview(indicator)
        }
        // API通信は3秒待つ
        Thread.sleep(forTimeInterval: 3)
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("error: \(error)")
                return
            }
            
            guard let data = data else {
                print("data is nil")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
                let login = json["login"] as! String
                let id = json["id"] as! Int
                let url = json["url"] as! String
                
//                DispatchQueue.main.async {
                    self.showUserInfo(login: login, id: id, url: url)
//                }
            } catch {
                print("error: \(error)")
            }
        }
        task.resume()
        // API通信が終わったらインジケーターを非表示にする
        DispatchQueue.main.async {
            indicator.stopAnimating()
            indicator.removeFromSuperview()
        }
    }
    
    func showUserInfo(login: String, id: Int, url: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        viewController.login = login
        viewController.id = id
        viewController.url = url
        DispatchQueue.main.async {
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
}
