//
//  secondVieuwControllerViewController.swift
//  pset2
//
//  Created by Femke van Son on 07-11-16.
//  Copyright © 2016 Femke van Son. All rights reserved.
//

import UIKit

class secondViewController: UIViewController {
    
    // all variables for secondview
    @IBOutlet weak var wordsInput: UITextField!
    @IBOutlet weak var wordCount: UILabel!
    @IBOutlet weak var nextStoryButton: UIButton!
    @IBOutlet weak var wordButton: UIButton!
    
    
    var words: String?
    var countPlaceholder: Int?
    var placeholder: String?
    var newStory = Story(stream: "")
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // only appear when all the words are filled in
        nextStoryButton.isHidden = true
        
        // get random story to the stream
        let array = ["madlib0_simple", "madlib1_tarzan", "madlib2_university", "madlib3_clothes", "madlib4_dance"]
        let randomIndex = Int(arc4random_uniform(UInt32(array.count)))
        let s = try! String(contentsOfFile: Bundle.main.path(forResource: "\(array[randomIndex])", ofType: "txt")!)
        newStory = Story(stream: s)
        
        // get the right descriptives for the random chosen story
        countPlaceholder = newStory.getPlaceholderRemainingCount()
        wordCount.text = "\(countPlaceholder!) word(s) left"
        placeholder = newStory.getNextPlaceholder()
        wordsInput.placeholder = "fill in a \(placeholder!)"
        
    }
    
    @IBAction func wordButton(_ sender: AnyObject) {
        
        // appear when all the words are filled in
        if countPlaceholder == 1 {
            nextStoryButton.isHidden = false
        }
        
        // if the input is empty, give an error
        if wordsInput.text!.isEmpty {
            wordsInput.placeholder = "You must fill in a \(placeholder!)!"
        }
        
        else {
            
            // for each word filled in, give it to text
            if countPlaceholder! >= 1 {
                
                // update all variables when new word is filled in and remove when it's done
                countPlaceholder = countPlaceholder! - 1
                wordCount.text = "\(countPlaceholder!) word(s) left"
                newStory.fillInPlaceholder(word: wordsInput.text!)
                placeholder = newStory.getNextPlaceholder()
                wordsInput.text?.removeAll()
                
                // disable ok button when allt he words are filled in
                if countPlaceholder! == 0 {
                    wordsInput.placeholder = "All the words are filled in!"
                    wordButton.isEnabled = false
                }
                
                else {
                    wordsInput.placeholder = "fill in a \(placeholder!)"
                }
            }

        }

    }


    @IBAction func nextView(_ sender: AnyObject) {
        
        // give the story text to variable
        words = newStory.toString()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // give the story text to the next view
        if let thirdVC = segue.destination as? thirdViewController {
            thirdVC.words = words
        }
    }

}
