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
    }
    
    @IBAction func tapButton(_ sender: Any) {
        fetchGithubUserInfo()
    }
    
    func fetchGithubUserInfo() {
        // API通信中にインジケーターを表示する
        let indicator = UIActivityIndicatorView()
        indicator.center = view.center
        // インジケーターを大きくする
        indicator.style = .large
        view.addSubview(indicator)
        indicator.startAnimating()
        
        
        let url = URL(string: "https://api.github.com/users/gen-AI-iOS")
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            // API通信は3秒間で行う
            sleep(3)
            
            if let error = error {
                print(error)
                return
            }
            
            if let data = data {
                let json = try! JSONSerialization.jsonObject(with: data, options: [])
                if let dictionary = json as? [String: Any],
                   let login = dictionary["login"] as? String {
                    DispatchQueue.main.async {
                        self.showGithubUserInfo(login)
                        // インジケーターを隠す
                        indicator.stopAnimating()
                        indicator.removeFromSuperview()
                        indicator.isHidden = true
                        indicator.hidesWhenStopped = true
                    }
                }
            }
        }
        task.resume()
    }
    
    func showGithubUserInfo(_ login: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondViewController = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        secondViewController.login = login
        present(secondViewController, animated: true, completion: nil)
    }
}
