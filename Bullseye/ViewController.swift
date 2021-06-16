//
//  ViewController.swift
//  Bullseye
//
//  Created by Lucas Eiki Okada on 14/05/21.
//

import UIKit

class ViewController: UIViewController {

    var targetValue = 0
    var currentValue = 1
    var score = 0
    var round = 0
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        let thumbnailNormal = UIImage(named: "Slider-Thumb-Normal")
        slider.setThumbImage(thumbnailNormal, for: .normal)
        
        let thumbnailHighlighted = UIImage(named: "Slider-Thumb-Highlighted")
        slider.setThumbImage(thumbnailHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = UIImage(named: "Slider-Track-Left")
        let trackLeftResizable = trackLeftImage?.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = UIImage(named: "Slider-Track-Right")
        let trackRightResizable = trackRightImage?.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
        super.viewDidLoad()
        startNewGame()
    }
    
    @IBAction func showAlert() {
        let difference = abs(targetValue - currentValue)
        let points = 100 - difference
        var bonusMessage = ""
        score += points
        
        let title: String
        
        if difference == 0 {
            title = "Perfect!"
            score += 100
            bonusMessage = "Bonus: 100 points"
            
        }else if difference < 5 {
            title = "You almost do it!"
            if difference == 1 {
                score += 50
                bonusMessage = "Bonus: 50 points"
            }
        
        }else if difference < 10 {
            title = "Pretty good!"
        }else {
            title = "Not even close ..."
        }
        
        let message = "You scored \(points) points. You put the slider value \(slider.value).\n" + bonusMessage
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: {_ in self.startNewRound()})
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved() {
        currentValue = lroundf(slider.value)
    }
    
    func startNewRound() {
        targetValue = Int.random(in: 1 ... 100)
        currentValue = 50
        slider.value = Float(currentValue)
        round += 1
        
        updateLabels()
    }
    
    func addHighScore(_ score: Int) {
        guard score > 0 else {
            return
        }
        
        let highScore = HighScoreItem()
        highScore.score = score
        highScore.name = "Unknow"
        
        var highScores = PersistenceHelper.loadHighScores()
        highScores.append(highScore)
        highScores.sort{$0.score > $1.score}
        PersistenceHelper.saveHighScores(highScores)
    }
    
    @IBAction func startNewGame() {
        addHighScore(score)
        score = 0
        round = 0
        startNewRound()
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
}

