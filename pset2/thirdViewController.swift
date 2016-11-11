//
//  thirdViewController.swift
//  pset2
//
//  Created by Femke van Son on 07-11-16.
//  Copyright © 2016 Femke van Son. All rights reserved.
//

import UIKit

class thirdViewController: UIViewController {
    
    // variables for third view
    var words: String?
    @IBOutlet weak var storyText: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // display story text
        storyText.text = words
    }
    
    
    @IBAction func newStory(_ sender: AnyObject) {
        
        // make words empty
        words = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
