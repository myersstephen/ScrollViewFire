//
//  LoginVC.swift
//  ScrollViewFire
//
//  Created by stephen myers on 1/29/17.
//  Copyright © 2017 Stephen Myers. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var switchLabel: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func broadcastPressed(_ sender: Any) {
        
        textLabel.text = "\(switchLabel.isOn)"
        
    }
    
    @IBAction func nextPressed(_ sender: Any) {
        let broadcastState = switchLabel.isOn
        
        performSegue(withIdentifier: "ViewController", sender: broadcastState)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ViewController {
            if let state = sender as? Bool {
                destination.selectedState = state
            }
        
        }
    }
}
