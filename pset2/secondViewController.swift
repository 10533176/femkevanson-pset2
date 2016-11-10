//
//  secondVieuwControllerViewController.swift
//  pset2
//
//  Created by Femke van Son on 07-11-16.
//  Copyright © 2016 Femke van Son. All rights reserved.
//

import UIKit

class secondViewController: UIViewController {

    @IBOutlet weak var wordsInput: UITextField!
    @IBOutlet weak var wordCount: UILabel!
    @IBOutlet weak var nextStoryButton: UIButton!
    
    
    
    var words: String?
    var countPlaceholder: Int?
    var placeholder: String?
    var name: String?
    var newStory = Story(stream: "")
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        nextStoryButton.isHidden = true
        let array = ["madlib0_simple", "madlib1_tarzan", "madlib2_university", "madlib3_clothes", "madlib4_dance"]
        let randomIndex = Int(arc4random_uniform(UInt32(array.count)))
        
        // Do any additional setup after loading the view.
        let s = try! String(contentsOfFile: Bundle.main.path(forResource: "\(array[randomIndex])", ofType: "txt")!)
        
        newStory = Story(stream: s)
        
        countPlaceholder = newStory.getPlaceholderRemainingCount()
        wordCount.text = "\(countPlaceholder!) word(s) left"
        placeholder = newStory.getNextPlaceholder()
        wordsInput.placeholder = "fill in a \(placeholder!)"
        
    }
    
    @IBAction func wordButton(_ sender: AnyObject) {
        
        if countPlaceholder == 1 {
            nextStoryButton.isHidden = false
        }
        
        if wordsInput.text!.isEmpty {
            wordsInput.placeholder = "You must fill in a \(placeholder!)!!"
            
            let delayInSeconds = 1.0
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                
                self.wordsInput.text?.removeAll()
            }
        }
        else {
            if countPlaceholder! >= 1 {
                countPlaceholder = countPlaceholder! - 1
                wordCount.text = "\(countPlaceholder!) word(s) left"
                newStory.fillInPlaceholder(word: wordsInput.text!)
                placeholder = newStory.getNextPlaceholder()
                wordsInput.text?.removeAll()
                if countPlaceholder! <= 0 {
                    wordsInput.placeholder = "All the words are filled in!"
                }
                else {
                    wordsInput.placeholder = "fill in a \(placeholder!)"
                }
            }
            else {
                wordsInput.placeholder = "All the words are filled in"

            }

        }

    }


    @IBAction func nextView(_ sender: AnyObject) {

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
        
        if let thirdVC = segue.destination as? thirdViewController{
            thirdVC.words = words
        }
    }

}
