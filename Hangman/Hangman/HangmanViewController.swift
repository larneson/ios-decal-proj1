//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController {
    var game : Game?
    @IBOutlet weak var hangmanImage: UIImageView!
    @IBOutlet weak var wrongGuessesLabel: UILabel!
    @IBOutlet weak var blanksLabel: UILabel!
    @IBOutlet weak var userGuessInput: UITextField!
    let hangmanImages = [#imageLiteral(resourceName: "hangman1"), #imageLiteral(resourceName: "hangman2"), #imageLiteral(resourceName: "hangman3"), #imageLiteral(resourceName: "hangman4"), #imageLiteral(resourceName: "hangman5"), #imageLiteral(resourceName: "hangman6"), #imageLiteral(resourceName: "hangman7")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    @IBAction func guessButtonPressed(_ sender: Any) {
        let input = userGuessInput.text
        let guess = game!.parseGuess(letter: input)
        if (guess != nil) {
            game!.addGuess(letter: guess!)
            updateUIElements()
        }
        userGuessInput.text = ""
        checkGameOver()
        
    }

    @IBAction func startOverPressed(_ sender: Any) {
        newGame()
    }
    
    func checkGameOver() {
        if (game!.loseCondition()) {
            makeAlert(text: "You lose")
        } else if (game!.winCondition()) {
            makeAlert(text: "You win")
        }
        

    }
    
    func updateUIElements() {
        wrongGuessesLabel.text = game!.getWrongGuessesString()
        blanksLabel.text = game!.getBlanks()
        hangmanImage.image = hangmanImages[game!.getNumWrong()]
    
    }
    
    func newGame() {
        let hangmanPhrases = HangmanPhrases()
        let phrase: String = hangmanPhrases.getRandomPhrase()
        print(phrase)
        game = Game(inputPhrase: phrase)
        updateUIElements()
    }
    
    func makeAlert(text: String) {
        //NOTE: http://stackoverflow.com/questions/24022479/how-would-i-create-a-uialertview-in-swift
        
        let alert = UIAlertController(title: text, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Play again?", style: UIAlertActionStyle.default, handler: {action in self.newGame()}))
        self.present(alert, animated: true, completion: nil)
    }
}
