//
//  Game.swift
//  Hangman
//
//  Created by Link Arneson on 2/19/17.
//  Copyright © 2017 Shawn D'Souza. All rights reserved.
//

import Foundation

class Game {
    var phrase : String
    var guessedLetters : Array<Character>
    let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    
    init(inputPhrase : String) {
        phrase = inputPhrase
        guessedLetters = []
    }
    
    func winCondition() -> Bool {
        for letter in phrase.characters {
            if (!guessedLetters.contains(letter) && letter != " "){
                return false
            }
        }
        return true
    }
    
    func loseCondition() -> Bool {
        return getNumWrong() == 6
    }
    
    func parseGuess(letter : String?) -> Character? {
        if (letter == nil) {
            return nil
        }
        let letter = letter!.uppercased()
        if (letter.characters.count != 1) {
            print("Too Long")
            return nil
        }
        if (guessedLetters.contains(Character(letter))) {
            print("Already in set")
            return nil
        }
        if (!alphabet.contains(letter)) {
            print("not a letter")
            return nil
        }
        return Character(letter)
    }
    
    func addGuess(letter : Character) {
        guessedLetters.append(letter)
        
    }
    
    func getBlanks() -> String {
        var blanks = String()
        for letter in phrase.characters {
            if (guessedLetters.contains(letter)) {
                blanks.append(letter)
            } else if (letter == " ") {
                blanks.append("   ")
            } else {
                blanks.append("_")
            }
            blanks.append(" ")
        }
        return blanks
    }
    
    func getWrongGuessesString() -> String {
        var wrongGuesses = String()
        var anyWrong = false
        for letter in guessedLetters {
            if !phrase.characters.contains(letter) {
                wrongGuesses.append(letter)
                wrongGuesses.append(" ")
                anyWrong = true
            }
        }
        if (!anyWrong){
            wrongGuesses = "No Wrong Guesses"
        }
        return "Wrong Guesses: " + wrongGuesses
        
    }
    
    func getNumWrong() -> Int {
        var numWrong = 0
        for letter in guessedLetters {
            if !phrase.characters.contains(letter) {
                numWrong += 1
            }
        }
        return min(numWrong, 6)
    }
}
