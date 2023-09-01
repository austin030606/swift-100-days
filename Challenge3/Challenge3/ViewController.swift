//
//  ViewController.swift
//  Challenge3
//
//  Created by Austin Chiu on 2023/3/11.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var lettersView: UIView!
    @IBOutlet var questionView: UITextView!
    let letters = "ABCDEFGHIJKLMNOPQRSTU VWXYZ "
    var letterButtons = [UIButton]()
    let words = ["RHYTHM", "BUSINESS"]
    var guessedLetters = Set<String>()
    var question = ""
    var displayedQuestion = ""
    var failCount = 0
    
    
    override func loadView() {
        super.loadView()
        
        // setting up keyboard
        let width = Int(lettersView.frame.width) / 7
        let height = 45
        
        for row in 0..<4 {
            for col in 0..<7 {
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
                letterButton.setTitle("A", for: .normal)
                
                let frame = CGRect(x: col * width, y: row * height, width: width, height: height)
                letterButton.frame = frame
                lettersView.addSubview(letterButton)
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                letterButtons.append(letterButton)
            }
        }
        
        // setting up question view
        questionView.font = UIFont.boldSystemFont(ofSize: 32)
        questionView.textAlignment = .center
        
        question = words.randomElement()!
        updateQuestionView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateButtons()
    }

    @objc func letterTapped(_ sender: UIButton) {
        let curLetter = sender.currentTitle!
        if curLetter == " " {
            return
        }
        //print("\(curLetter) pressed.")
        guessedLetters.insert(curLetter)
        if !question.contains(curLetter) {
            failCount += 1
        }
        updateQuestionView()
        updateButtons()
    }
    
    func updateButtons() {
        for (index, char) in letters.enumerated() {
            if guessedLetters.contains(String(char)) {
                letterButtons[index].setTitle(" ", for: .normal)
            } else {
                letterButtons[index].setTitle(String(char), for: .normal)
            }
        }
    }
    
    func updateQuestionView() {
        var found = true
        displayedQuestion = ""
        for letter in question {
            let strLetter = String(letter)
            
            if guessedLetters.contains(strLetter) {
                displayedQuestion += strLetter
            } else {
                displayedQuestion += " _ "
                found = false
            }
        }
        questionView.text = displayedQuestion
        if found {
            questionView.textColor = UIColor(red: 0.0, green: 0.8, blue: 0.0, alpha: 1.0)
            let ac = UIAlertController(title: "You've won!", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Restart", style: .default){ [weak self] action in
                self?.failCount = 0
                self?.guessedLetters.removeAll()
                self?.question = (self?.words.randomElement())!
                self?.updateQuestionView()
                self?.updateButtons()
            })
            present(ac, animated: true)
        } else {
            questionView.textColor = UIColor(red: 1.0 * (CGFloat(failCount) / 7.0), green: 0.0, blue: 0.0, alpha: 1.0)
            if failCount == 8 {
                let ac = UIAlertController(title: "You've lost!", message: nil, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Restart", style: .default){ [weak self] action in
                    self?.failCount = 0
                    self?.guessedLetters.removeAll()
                    self?.question = (self?.words.randomElement())!
                    self?.updateQuestionView()
                    self?.updateButtons()
                })
                present(ac, animated: true)
            }
        }
    }
}

