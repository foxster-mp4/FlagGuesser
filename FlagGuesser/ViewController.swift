//
//  ViewController.swift
//  FlagGuesser
//
//  Created by Huy Bui on 2021-09-03.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var countries: [String] = []
    var score = 0
    var correctAnswer = 0
    var questionsAnswered = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "uk", "us"]
        
        setFlags()
        
        let buttons = [button1, button2, button3]
        for button in buttons {
            button!.layer.borderWidth = 1 // 1 pt
            button!.layer.borderColor = UIColor.lightGray.cgColor // lightGray must be converted to CGColor before borderColor can use it, since borderColor exist on layer (type CALayer) which is beneath UIView and UIButton and doens't recognize UIColor
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score", style: .done, target: self, action: #selector(showScore))
    }

    func setFlags(action: UIAlertAction! = nil) { // action is needed since a function/closure with UIAlertAction param is required for alertController.addAction() in buttonTapped(_ :); if notthing is passed in, action defaults to nil
        countries.shuffle()
        
        let buttons = [button1, button2, button3]
        for i in 0...2 {
            buttons[i]!.setImage(UIImage(named: countries[i]), for: .normal)
        }
        
        correctAnswer = Int.random(in: 0...2)
        var correctCountry = countries[correctAnswer]
        if correctCountry == "us" || correctCountry == "uk" {
            correctCountry = correctCountry.uppercased()
        } else {
            correctCountry = correctCountry.capitalized
        }
        
        title = "Choose the flag of \(correctCountry)"
        
    }
    
    // buttonTapped(_:) is connected to all three buttons
    @IBAction func buttonTapped(_ sender: UIButton) {
        questionsAnswered += 1
        
        var alertTitle: String
        if sender.tag == correctAnswer {
            alertTitle = "Correct answer!"
            score += 1
        } else {
            alertTitle = "Wrong answer!\n That's the flag of \(countries[sender.tag] == "us" || countries[sender.tag] == "uk" ? countries[sender.tag].uppercased() : countries[sender.tag].capitalized)."
            score -= 1
        }
        
        if score < 0 {
            score = 0
        }
        
        // MARK: Alerts
        var alertMessage: String
        var alertAction: String
        if questionsAnswered != 10 {
            alertMessage = "Your score is \(score)"
            alertAction = "Continue"
        } else {
            alertMessage = "You completed 10 questions.\n Your final score is \(score)."
            alertAction = "Restart"
            
            score = 0
            questionsAnswered = 0
        }
        
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: alertAction, style: .default, handler: setFlags))
        present(alertController, animated: true)
        
    }
    
    @objc func showScore() {
        let alert = UIAlertController(title: nil, message: "Your score is \(score)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
}
