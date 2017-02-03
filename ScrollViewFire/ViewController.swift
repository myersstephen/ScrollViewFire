//
//  ViewController.swift
//  ScrollViewFire
//
//  Created by stephen myers on 12/27/16.
//  Copyright © 2016 Stephen Myers. All rights reserved.
//

import UIKit
import Firebase


class ViewController: UIViewController, UIScrollViewDelegate, UITextViewDelegate {
    
    @IBOutlet weak var textView: UITextView!
    var ref: FIRDatabaseReference!
    @IBOutlet weak var scrollView: UIScrollView!
    
    private var _selectedState: Bool!
    
    var selectedState: Bool
    {
        get{
            return _selectedState
        } set{
            _selectedState = newValue
        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        textView.delegate = self
        ref = FIRDatabase.database().reference()
        
        checkBroadcastState()
        
        textView.isUserInteractionEnabled = false
        
    }
    
    
    
    //Print the y coordinate of the scrollview
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        // print(y)
        
        // set position if selected state is true
        if selectedState == true {
            self.ref.setValue(["position_IS":y])
        }
        
    }

    
    
    @IBAction func BottomTapped(_ sender: Any) {
        //test to see if when bottom button is pressed it should scroll to top
        setContentOffSet()
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    func setContentOffSet(){
        //TODO: Float number for y here should be equal to the number we recive from firebase.
        let offSet = CGPoint(x: 0, y:7.0)
        
        Animations.start(0.3, animations: {
            self.scrollView.setContentOffset(offSet, animated: true)
        })
    }
    
    
    
    
   
    func updateScreenPosition(){
        
        ref.observe(.childChanged, with: {data in
            //self.pos = data.value as! FIRDataSnapshot
            print("\(data.value)")
            
            let offSet = CGPoint(x: 0, y:data.value as! Int)
            
            self.scrollView.setContentOffset(offSet, animated: true)
            
        }, withCancel: {err in
            print(err)
        })
        
        
    }
    
    func checkBroadcastState() {
        if selectedState == true {
            
           ref.removeAllObservers()
            
        } else if selectedState == false {
            updateScreenPosition()
        }
    }

}

