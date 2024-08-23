//
//  TestAiViewController.swift
//  AifulApp-staging
//
//  Created by YabeTatuki on 2024/08/20.
//  Copyright © 2024 アイフル. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // deviceInfoの要素数を返す
        return deviceInfo.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // DeviceInfoCellを取得
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceInfoCell", for: indexPath) as? DeviceInfoCell else {
            return UITableViewCell()
        }
        // deviceInfoのキーを取得
        let key = Array(deviceInfo.keys)[indexPath.row]
        // deviceInfoの値を取得
        let value = Array(deviceInfo.values)[indexPath.row]
        // cellのkeyLabelにキーを設定
        cell.keyLabel.text = key
        // cellのvalueLabelに値を設定
        cell.valueLabel.text = value
        return cell
        
    }
    
    // TableViewのセルの高さを設定
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // deviceTableViewの高さを変数に設定
        let deviceTableViewHeight = deviceTableView.frame.height
        // deviceInfoの要素数を変数に設定
        let deviceInfoCount = deviceInfo.count
        // deviceTableViewの高さをdeviceInfoの要素数で割り、セルの高さを設定
        return deviceTableViewHeight / CGFloat(deviceInfoCount)

    }
    
    @IBOutlet weak var displayText: UILabel!
    @IBOutlet weak var deviceTableView: UITableView!
    
    // deviceInfoをクラスのプロパティとして定義
    var deviceInfo: [String: String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 端末のモデル名を取得
        let modelName = UIDevice.current.modelName
        
        //osのバージョンを取得
        let osVersion = UIDevice.current.systemVersion
        
        // 端末の名前を取得
        let deviceName = UIDevice.current.name
        
        // 端末の容量を取得
        let totalDiskSpace = UIDevice.current.totalDiskSpace
        
        // 端末のモデル名、OSバージョン、名前、容量を取得してリスト化
        deviceInfo = [
            "モデル名": modelName,
            "OSバージョン": osVersion,
            "端末名": deviceName,
            "容量": "\(totalDiskSpace)GB"
        ]
        displayText.text = deviceInfo.map { "\($0.key): \($0.value)" }.joined(separator: "\n")
        
        // displayTextの行数を自動調整
        displayText.numberOfLines = 0
        
        
        //DevecInfoCellを登録
        deviceTableView.register(UINib(nibName: "DeviceInfoCell", bundle: nil), forCellReuseIdentifier: "DeviceInfoCell")
        // デリゲートを設定
        deviceTableView.delegate = self
        deviceTableView.dataSource = self
        
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
        //
        if let secondViewController = viewController as? SecondViewController {
            
        }
        present(viewController, animated: true, completion: nil)
    }
}

// MARK: - UIDevice拡張
// Value of type 'UIDevice' has no member 'modelName'というエラーが出るため、拡張する
extension UIDevice {
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPod9,1":                                 return "iPod Touch 7"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone8,4":                               return "iPhone SE (1st generation)"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
        case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6":                return "iPhone X"
        case "iPhone11,2":                              return "iPhone XS"
        case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
        case "iPhone11,8":                              return "iPhone XR"
        case "iPhone12,1":                              return "iPhone 11"
        case "iPhone12,3":                              return "iPhone 11 Pro"
        case "iPhone12,5":                              return "iPhone 11 Pro Max"
        case "iPhone12,8":                              return "iPhone SE (2nd generation)"
        case "iPhone13,1":                              return "iPhone 12 mini"
        case "iPhone13,2":                              return "iPhone 12"
        case "iPhone13,3":                              return "iPhone 12 Pro"
        case "iPhone13,4":                              return "iPhone 12 Pro Max"
        case "iPhone14,4":                              return "iPhone 13 mini"
        case "iPhone14,5":                              return "iPhone 13"
        case "iPhone14,2":                              return "iPhone 13 Pro"
        case "iPhone14,3":                              return "iPhone 13 Pro Max"
        case "iPhone14,6":                              return "iPhone SE (3rd generation)"
        case "iPhone14,7":                              return "iPhone 14"
        case "iPhone14,8":                              return "iPhone 14 Plus"
        case "iPhone15,2":                              return "iPhone 14 Pro"
        case "iPhone15,3":                              return "iPhone 14 Pro Max"
        case "iPhone15,4":                              return "iPhone 15"
        case "iPhone15,5":                              return "iPhone 15 Plus"
        case "iPhone16,1":                              return "iPhone 15 Pro"
        case "iPhone16,2":                              return "iPhone 15 Pro Max"
        default:                                        return identifier
        }
    }
}
// MARK: - UIDevice拡張
// Value of type 'UIDevice' has no member 'totalDiskSpace'というエラーが出るため、拡張する
extension UIDevice {
    var totalDiskSpace: Int {
        do {
            let systemAttributes = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String)
            if let space = systemAttributes[FileAttributeKey.systemSize] as? Int {
                return space
            }
        } catch {
            print("Error: \(error)")
        }
        return 0
    }
}
