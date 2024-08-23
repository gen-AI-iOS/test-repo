//
//  ViewController.swift
//  COPILOT
//
//  Created by YabeTatuki on 2024/08/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    // タイマーの変数
    var timer: Timer?
    // ストップ時点での経過時点を保持するtimeInterval
    var stopTime = TimeInterval()
    // ストップ前のtimeInterval
    var startTime = TimeInterval()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // startButtonのラベルをStartのする
        startButton.setTitle("Start", for: .normal)
        // resetButtonのラベルをResetのする
        resetButton.setTitle("Reset", for: .normal)
        // timerLabelのラベルを00:00:00にする
        self.timerLabel.text = "00:00:00"
        // timerLabelの色を赤色にする
        // timerLabelの太さをBoldにする
        self.timerLabel.textColor = UIColor.red
        self.timerLabel.font = UIFont.boldSystemFont(ofSize: 50)
        // timerLAbelを中央に配置する
        self.timerLabel.textAlignment = NSTextAlignment.center
    }

    @IBAction func startTapped(_ sender: Any) {
        // タイマーをスタートする
        if self.timer == nil {
            self.timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.timerUpdate), userInfo: nil, repeats: true)
            // startButtonのラベルをStopのする
            startButton.setTitle("Stop", for: .normal)
        } else {
            // タイマーをストップする
            self.timer?.invalidate()
            self.timer = nil
            // startButtonのラベルをStartのする
            startButton.setTitle("Start", for: .normal)
        }
    }
    
    @IBAction func resetTapped(_ sender: Any) {
        // タイマーをリセットする
        self.timer?.invalidate()
        self.timer = nil
        // timeIntervalの値を0にする
        self.stopTime = 0
        self.startTime = 0
        // timerLabelのラベルを00:00:00にする
        self.timerLabel.text = "00:00:00"
        // startButtonのラベルをStartのする
        startButton.setTitle("Start", for: .normal)
    }
    
    // タイマーの更新
    @objc func timerUpdate() {
        // timeIntervalの値を1秒進める
        self.stopTime = self.stopTime + 0.01
        // timerLabelのラベルを更新する
        self.timerLabel.text = String(format: "%02d:%02d:%02d", Int(self.stopTime) / 3600, (Int(self.stopTime) % 3600) / 60, Int(self.stopTime) % 60)
    }
    
}

