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
        // 画面遷移する
        // 遷移先はSecondViewController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        self.present(nextViewController, animated: true, completion: nil)
    }
    
}
