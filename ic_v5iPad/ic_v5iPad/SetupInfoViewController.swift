//
//  SetupInfoViewController.swift
//  ic_v5iPad
//
//  Created by Shabnam Suresh on 2016-05-17.
//  Copyright © 2016 Shabnam Suresh. All rights reserved.
//

import Foundation

import UIKit

class SetupInfoViewController: UIViewController {
    
//labels
    
    @IBOutlet weak var tLeftBtnImagePathlbl: UITextView!
    @IBOutlet weak var tRightBtnImagePathlbl: UITextView!
    
    @IBOutlet weak var fLeftBtnImagePathlbl: UITextView!
    @IBOutlet weak var fRightBtnImagePathlbl: UITextView!
    
// Buttons
    
    @IBOutlet weak var tLeftBtnImagePathbtn: UIButton!
    @IBOutlet weak var tRightBtnImagePathbtn: UIButton!
    
    @IBOutlet weak var fLeftBtnImagePathbtn: UIButton!
    @IBOutlet weak var fRightBtnImagePathbtn: UIButton!
    
    @IBOutlet weak var attnGrabberVideoPathlbl: UITextView!
    @IBOutlet weak var attnGrabberVideoPathbtn: UIButton!
    
    @IBOutlet weak var savebtn: UIButton!
    @IBOutlet weak var cancelbtn: UIButton!
    
    
    @IBAction func tLeftBtnImagePathTapped(sender: AnyObject) {
    }
    
    @IBAction func tRightBtnImagePathTapped(sender: AnyObject) {
    }
    
    @IBAction func fRightBtnImagePathTapped(sender: AnyObject) {
    }
    
    @IBAction func attnGrabberVideoPathTapped(sender: AnyObject) {
    }
    
    @IBAction func saveBtnTapped(sender: AnyObject) {
    }
   
    @IBAction func cancelBtnTapped(sender: AnyObject) {
    }
    
}