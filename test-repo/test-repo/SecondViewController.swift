//
//  SecondViewController.swift
//  COPILOT
//
//  Created by YabeTatuki on 2024/08/21.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    var login: String?
    var id: Int?
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // ユーザー情報を表示する
        nameLabel.text = login
        
    }
}
