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
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    // タイマーの変数
    var timer = Timer()
    // タイマーのTimeInterval（変数名はstartTime）
    var startTime = TimeInterval()
    // ストップ時点での経過時間を保持するための変数
    var elapsedTime = TimeInterval()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        // startButtonのテキストをstartに設定
        startButton.setTitle("start", for: .normal)
        // stopButtonのテキストをstopに設定
        stopButton.setTitle("stop", for: .normal) // 修正: stopLabel -> stopButton
        // resetButtonのテキストをresetに設定
        resetButton.setTitle("reset", for: .normal)
        // timerLabelのテキストを00:00:00に設定
        timerLabel.text = "00:00:00"
        // timerLabelのテキストの太さをBoldにする
        timerLabel.font = UIFont.boldSystemFont(ofSize: 24)
        // timerLabelのテキストの色を赤にする
        timerLabel.textColor = .red
    }
    
    // タイマーをスタートさせるメソッド
    @IBAction func startTapped(_ sender: Any) {
        // タイマーをスタートさせる
        // タイマーがStopの状態で再度Startを押した時は、経過時間から再スタートする
        // タイマーがStopの状態で再度Startを押した時に経過時間を初期化しない
        if !timer.isValid {
            // startTimeに現在時刻を設定
            startTime = Date.timeIntervalSinceReferenceDate - elapsedTime
            // タイマーを回す
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        }
    }
    
    // updateTimeをつかってタイマーを更新するメソッド
    // elapsedTimeを使用して経過時間を計算する
    @objc func updateTime() {
        // 現在の時間を取得
        let currentTime = Date.timeIntervalSinceReferenceDate
        // 経過時間を計算
        elapsedTime = currentTime - startTime
        // 時、分、秒を計算
        let hours = UInt8(elapsedTime / 3600.0)
        elapsedTime -= (TimeInterval(hours) * 3600)
        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (TimeInterval(minutes) * 60)
        let seconds = UInt8(elapsedTime)
        elapsedTime -= TimeInterval(seconds)
        let fraction = UInt8(elapsedTime * 100)
        // 時、分、秒を文字列にしてtimerLabelに表示
        let strHours = String(format: "%02d", hours)
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        let strFraction = String(format: "%02d", fraction)
        timerLabel.text = "\(strHours):\(strMinutes):\(strSeconds)"
    }
    
    
    // タイマーをストップさせるメソッド
    @IBAction func stopTapped(_ sender: Any) {
        // タイマーをストップさせる
        timer.invalidate()
        // elapsedTimeを保持する
        elapsedTime = Date.timeIntervalSinceReferenceDate - startTime
        
    }
    
    // タイマーをリセットさせるメソッド
    @IBAction func resetTapped(_ sender: Any) {
        // タイマーをリセットさせる
        timer.invalidate()
        // startTimeを0にする
        startTime = 0
        // elapsedTimeを0にする
        elapsedTime = 0
        // timerLabelのテキストを00:00:00に設定
        timerLabel.text = "00:00:00"
    }
}
