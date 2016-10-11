//
//  ViewController.swift
//  ic_v5iPad
//
//  Created by Shabnam Suresh on 2015-12-23.
//  Copyright © 2015 Shabnam Suresh. All rights reserved.
//

import MultipeerConnectivity
import AVFoundation
import AVKit
import UIKit

//Global Objects
var setupInfoObject = SetupInfo()

class ViewController: UIViewController,  UINavigationControllerDelegate, MCSessionDelegate, MCBrowserViewControllerDelegate, UIImagePickerControllerDelegate {
    
    var playerViewController = AVPlayerViewController()
    var playerView = AVPlayer()
    
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var lblStatus: UILabel!
    
    var imgPicker = UIImagePickerController()
     var tempImage : UIImage!
    
    var messg = String()
    var screenStatus = String()
    
    //peer ID is simply the name of the current device
    var peerID: MCPeerID!
    var mcSession: MCSession!
    var mcAdvertiserAssistant: MCAdvertiserAssistant!

    var resetbtn1Img: UIImage!
    var resetbtn2Img: UIImage!
    var defaultBtnImage: UIImage!
    
    var btn1Img: UIImage! = nil
    var btn2Img: UIImage! = nil
    var loadImg : Int = 0
    
    var listOfImages = [String: UIImage]()
    var imgIndex: String = "XXX"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Trial 1"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(ViewController.showConnectionPrompt))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Compose, target: self, action: #selector(ViewController.showSetupInfo))
        
        peerID = MCPeerID(displayName: UIDevice.currentDevice().name)
        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .Required)
        mcSession.delegate = self
        
         //hideChoiceBtns()
        
        resetbtn1Img = UIImage(named: "Btn1")
        resetbtn2Img = UIImage(named: "Btn2")
        defaultBtnImage = UIImage(named:"defBtnImg")
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    
    
    func hideChoiceBtns()
    {
        self.leftBtn.hidden = true
        self.rightBtn.hidden = true
    }
    
    func showBothBtns()
    {
        print("Inside showBothBtns()")
        self.leftBtn.hidden = false
        self.rightBtn.hidden = false
    }
    
    func showLeftBtn()
    {
        self.leftBtn.hidden = false
        self.rightBtn.hidden = true
    }
    
    func showRightBtn()
    {
        self.leftBtn.hidden = true
        self.rightBtn.hidden = false
    }
    
    func resetBtnImages()
    {
        self.leftBtn.setImage(resetbtn1Img, forState: UIControlState.Normal)
        self.rightBtn.setImage(resetbtn2Img, forState: UIControlState.Normal)
    }
    
    
    @IBAction func rightBtnTapped(sender: UIButton) {
        
        messg = "Right Button"
        sendMesg()
        hideChoiceBtns()
    }
    @IBAction func leftBtnTapped(sender: UIButton) {
        messg = "Left Button"
        sendMesg()
        hideChoiceBtns()
    }
    
    //Function to communicate with MAC
    func sendMesg(){
        //1
        if mcSession.connectedPeers.count > 0 {
            // 2
            if !messg.isEmpty {
                // 3
                do {
                    try mcSession.sendData(messg.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!, toPeers: mcSession.connectedPeers, withMode: MCSessionSendDataMode.Reliable)
                    print("###Message sent = \(messg)")
                } catch let error as NSError {
                    let ac = UIAlertController(title: "Send error", message: error.localizedDescription, preferredStyle: .Alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                    presentViewController(ac, animated: true, completion: nil)
                }
                
            }
        }
        
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func showConnectionPrompt() {
        let ac = UIAlertController(title: "Connect to others", message: nil, preferredStyle: .ActionSheet)
        ac.addAction(UIAlertAction(title: "Host a session", style: .Default, handler: startHosting))
        ac.addAction(UIAlertAction(title: "Join a session", style: .Default, handler: joinSession))
        ac.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        //To create pop up menu else it gives error
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.leftBarButtonItem
        
        
        presentViewController(ac, animated: true, completion: nil)
    }
    
    func showSetupInfo(){
        
    }
    
    func startHosting(action: UIAlertAction!) {
        mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: "ic-v5", discoveryInfo: nil, session: mcSession)
        mcAdvertiserAssistant.start()
    }
    
    func joinSession(action: UIAlertAction!) {
        let mcBrowser = MCBrowserViewController(serviceType: "ic-v5", session: mcSession)
        mcBrowser.delegate = self
        presentViewController(mcBrowser, animated: true, completion: nil)
    }
    
    func session(session: MCSession, didReceiveStream stream: NSInputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, withProgress progress: NSProgress) {
        
        
    }
    
    func session(session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, atURL localURL: NSURL, withError error: NSError?) {
        
        print("Image recieved ")
        
        var image: UIImage? = nil
        if let localData = NSData(contentsOfURL: localURL) {
            image = UIImage(data: localData)
           // imgView.image = UIImage(data: localData)
            //leftBtn.setImage(image, forState: UIControlState.Normal)
            //rightBtn.setImage(image, forState: UIControlState.Normal)
            
        }
    }
    
    func browserViewControllerDidFinish(browserViewController: MCBrowserViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func browserViewControllerWasCancelled(browserViewController: MCBrowserViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //need to do something when clients connect or disconnect
    func session(session: MCSession, peer peerID: MCPeerID, didChangeState state: MCSessionState) {
        switch state {
        case MCSessionState.Connected:
            print("Connected: \(peerID.displayName)")
            
        case MCSessionState.Connecting:
            print("Connecting: \(peerID.displayName)")
            
        case MCSessionState.NotConnected:
            print("Not Connected: \(peerID.displayName)")
        }
    }
    
    
    
    //To receive that on the other side
    func session(session: MCSession, didReceiveData data: NSData, fromPeer peerID: MCPeerID) {
        
        if let image = UIImage(data: data) {
            dispatch_async(dispatch_get_main_queue()) { [unowned self] in
               
                if(self.loadImg == 9 )
                {
                    print("Setting Image for index ; \(self.imgIndex)")
                    self.listOfImages[self.imgIndex] = image
                    //self.leftBtn.setImage(self.listOfImages[self.imgIndex], forState: UIControlState.Normal)
                    
                }
                /*
                if(self.loadImg != 2 )
                {
                    //self.leftBtn.setImage(self.listOfImages[self.imgIndex], forState: UIControlState.Normal)
                    
                }
                
                if(self.loadImg != 1 ){
                    //self.rightBtn.setImage(image, forState: UIControlState.Normal)
                }
                */
                
                self.loadImg = 0
                
                print("Recieved Image here")
                
                
                
            }
        }
        
        if let str = NSString(data: data, encoding: NSUTF8StringEncoding)  {
            dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                self.lblStatus.text = str as String
                self.screenStatus = str as String
                
                //Split the string
                let recvdString = str as String
                print("------------------------")
                print("Recieved String = \(recvdString)")
                print("------------------------")
                
                if(recvdString == "Test" || recvdString == "Reset" || recvdString == "AG" || recvdString == "HB" || recvdString == "SB" || recvdString == "LB" || recvdString == "RB" || recvdString == "Img1" || recvdString == "Swap"){
                    self.setScreen()
                }else{
                    //let strSplit = recvdString.characters.split("-")
                    let strSplit = recvdString.componentsSeparatedByString("-")
                    
                    //Sample command : LOAD-Img1
                    //Make sure to send this command first before sending the image
                    //This will sent from the MAC application when Send Images Button is clicked
                    
                    if(String(strSplit[0]) == "LOAD"){
                        self.listOfImages["\(strSplit[1])"] = self.defaultBtnImage
                        self.loadImg = 9
                        self.imgIndex = strSplit[1]
                        print("array strSplit \(strSplit)")
                    }
                    else if(strSplit[0] == "SET"){
                        //Sample command : SET-LB-Img2
                        //This will set the Left button Image
                        if(strSplit[1] == "LB")
                        {
                                self.leftBtn.hidden = false
                                self.leftBtn.setImage(self.listOfImages["\(strSplit[2])"], forState: UIControlState.Normal)
                            
                        } else if(strSplit[1] == "RB")
                        {
                            //Sample command : SET-RB-Img2
                            //This will set the Right button Image
                                self.rightBtn.hidden = false
                                self.rightBtn.setImage(self.listOfImages["\(strSplit[2])"], forState: UIControlState.Normal)
                        }
                        
                    
                    }
                }

                
                
                
            }
        }
    }
    
    func setScreen(){
        if (screenStatus == "Test")
        {
            messg = "Success"
            sendMesg()
            
        }
        else if (screenStatus == "AG")
        {
            //Play attention grabber on iPad
            let fileURL = NSBundle.mainBundle().URLForResource("iPadAG", withExtension: "mp4")!
            let item = AVPlayerItem(URL: fileURL)
            
            self.playerView = AVPlayer(playerItem: item)
            self.playerViewController.showsPlaybackControls = false
            
            self.playerViewController.player = self.playerView
            
            self.presentViewController(self.playerViewController, animated: true)
            {
                self.playerViewController.player?.play()
            }
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "playerDidFinishPlaying:", name: AVPlayerItemDidPlayToEndTimeNotification, object: item)
            messg = "completed AG"
            sendMesg()
            
        }
        else if (screenStatus == "SB")
        {
            showBothBtns()
            
        }
        else if (screenStatus == "HB")
        {
            hideChoiceBtns()
        }
        else if (screenStatus == "LB")
        {
            showLeftBtn()
        }
        else if (screenStatus == "RB")
        {
            showRightBtn()
        }
        else if (screenStatus == "Reset")
        {
            resetBtnImages()
        }
        /*
        else if (screenStatus == "LB1")
        {
            loadImg = 1
            
        }
        else if (screenStatus == "LB2")
        {
            loadImg = 2
            
        */
        else if (screenStatus == "Img1")
        {
         listOfImages["Img1"] = defaultBtnImage
            shownewButton()
        }
        else if (screenStatus == "Swap")
        {
            print("Swap the images on the left and the right btn")
            
        }

        
    }
    
    func shownewButton()
    {
        self.leftBtn.setImage(listOfImages["Img1"],forState: UIControlState.Normal)
        self.rightBtn.setImage(listOfImages["Img1"], forState: UIControlState.Normal)

    }
    
    func playerDidFinishPlaying(note: NSNotification) {
        messg = "Show Buttons"
        sendMesg()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let point = touch.locationInView(self.view)
            print("**************************")
            print("X = \(point.x)")
            print("Y = \(point.y)")
            print("**************************")
            messg = "iPAD Touch Coordinates: X =\(point.x), Y =\(point.y)"
            sendMesg()
          
        }
        super.touchesBegan(touches, withEvent:event)
    }

}


