//
//  ViewController.swift
//  COPILOT
//
//  Created by YabeTatuki on 2024/08/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // deviceInfoを変数に設定
    // キーバリューで実装
    var deviceInfo: [String: String] = [:]
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // deviceInfoの要素数を返す
        return deviceInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // DeviceInfoCellを生成
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceInfoCell", for: indexPath) as! DeviceInfoCell
        // cellにdeviceInfoのキーを設定
        cell.keyLabel.text = deviceInfo.keys.sorted()[indexPath.row]
        // cellにdeviceInfoの値を設定
        cell.valueLabel.text = deviceInfo.values.sorted()[indexPath.row]
        
        return cell
    }
    
    // tableViewのセルの高さを設定
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // tableViewの高さを変数で設定
        let tableViewHeight = displayTableView.frame.height
        // セルの高さを設定
        let cellHeight = tableViewHeight / CGFloat(deviceInfo.count)
        // セルの高さを返す
        return cellHeight
    }
    

    @IBOutlet weak var displayTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 端末のモデル名を取得
//        let modelName = UIDevice.current.modelName
        
        // OSバージョンを取得
        let osVersion = UIDevice.current.systemVersion
        
        // 端末の名前を取得
        let deviceName = UIDevice.current.name
        
        // 端末の容量を取得
//        let deviceCapacity = UIDevice.current.totalDiskSpace
        
        // deviceInfoにOSバージョン、名前をリスト化
        // deviceInfo = ["OSバージョン": osVersion, "名前": deviceName, "容量": deviceCapacity]
        deviceInfo = ["OSバージョン": osVersion, "名前": deviceName]
        
        
        // DeviceInfoCellに登録する
        displayTableView.register(UINib(nibName: "DeviceInfoCell", bundle: nil), forCellReuseIdentifier: "DeviceInfoCell")
        
        // DeviceInfoCellに値を登録
        displayTableView.reloadData()
        
        // デリゲートを設定
        displayTableView.delegate = self
        displayTableView.dataSource = self
        
    }
    
    @IBAction func tapButton(_ sender: Any) {
    }
    
}
