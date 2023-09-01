//
//  ViewController.swift
//  Project2
//
//  Created by Austin Chiu on 2023/1/30.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        askQuestion()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .pause, target: self, action: #selector(pauseTapped))
    }

    func askQuestion(action: UIAlertAction! = nil) {
        questionCount += 1
        countries.shuffle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        correctAnswer = Int.random(in: 0...2)
        title = "Q\(questionCount): \(countries[correctAnswer].uppercased())"
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var message: String

        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            message = "Your \(questionCount == 10 ? "final " : "")score is \(score)"
        } else {
            title = "Wrong"
            score -= score > 0 ? 1 : 0
            message = "That's the flag of \(countries[sender.tag].uppercased()).\nYour \(questionCount == 10 ? "final " : "")score is \(score)"
        }
        
        if questionCount == 10 {
            questionCount = 0
            score = 0
            let ac = UIAlertController(title: title, message: "Game ended.\n" + message, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Restart", style: .default, handler: askQuestion))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        }
    }
    
    @objc func pauseTapped() {
        let ac = UIAlertController(title: "Pause", message: "Your current score is \(score).", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Resume", style: .default, handler: {_ in}))
        present(ac, animated: true)
    }
}

