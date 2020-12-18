//
//  ToDoCell.swift
//  ToDoList
//
//  Created by Иван Алмазов on 14.12.2020.
//

import UIKit



class ToDoCell: UITableViewCell {


    @IBOutlet weak var isDone: UIImageView!
    
    @IBOutlet weak var nameTask: UILabel!
    @IBOutlet weak var timePicker: UIDatePicker!
    
    var alert: AlertService?
    
    var indexRow: Int! // injected
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var sleepTime = 0.0 {
        didSet {
            print(sleepTime)
        }
    }
    
    var timer: Timer?
    var timerIsRunning = false
    
    func startTimer() {
        print("startTimer")
        sleepTime = timePicker.countDownDuration
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        timerIsRunning = true
    }

    @objc private func updateTimer() {
        print(timePicker.date)
        print("updateTimer")
        if sleepTime != 0.0 {
            sleepTime -= 60
            timePicker.countDownDuration -= 60
        }
        else {
            alert?.finishTimer(for: self)
            timer?.invalidate()
            timerIsRunning = false
        }

    }
}
