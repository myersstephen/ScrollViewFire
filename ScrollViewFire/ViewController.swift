//
//  ViewController.swift
//  ScrollViewFire
//
//  Created by stephen myers on 12/27/16.
//  Copyright © 2016 Stephen Myers. All rights reserved.
//

import UIKit
import Firebase


class ViewController: UIViewController, UIScrollViewDelegate {
    
    var ref: FIRDatabaseReference!
    //var pos = FIRDataSnapshot()
    @IBOutlet weak var scrollView: UIScrollView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        ref = FIRDatabase.database().reference()
        
        
//        ref.observeSingleEvent(of: .childChanged, with: {data in
//         print("update happened")
//            })
        updateScreenPosition()
        
        }
    
    
    
    //Print the y coordinate of the scrollview
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        print(y)
        
        //set position
        //self.ref.setValue(["position":y])
    }
    
    
    
    @IBAction func BottomTapped(_ sender: Any) {
        //test to see if when bottom button is pressed it should scroll to top
        //setContentOffSet()
    }
    
    
    
    func setContentOffSet(){
        //TODO: Float number for y here should be equal to the number we recive from firebase.
        let offSet = CGPoint(x: 0, y:7.0)
        
        scrollView.setContentOffset(offSet, animated: true)
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

}

