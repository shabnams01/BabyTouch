//
//  SetupInfo.swift
//  ic_v5iPad
//
//  Created by Shabnam Suresh on 2016-05-17.
//  Copyright © 2016 Shabnam Suresh. All rights reserved.
//

import Foundation

class SetupInfo: NSObject {
    
    var tLeftBtnImgPath: NSURL! = nil
    var tRightBtnImgPath: NSURL! = nil
    var fLeftBtnImgPath: NSURL! = nil
    var fRightBtnImgPath: NSURL! = nil
    var attnGrabberPath: NSURL! = nil

    
    
    
    func getAttnGrabberFilepath()-> NSURL{
        return attnGrabberPath
    }
    
    func setAttnGrabberFilepath(url : NSURL){
        attnGrabberPath = url
    }
    
    func getTrainingLeftBtnImgPath()-> NSURL{
        return tLeftBtnImgPath
    }
    
    func setTrainingLeftBtnImgPath(url : NSURL){
        tLeftBtnImgPath = url
    }
    
    func getTrainingRightBtnImgPath()-> NSURL{
        return tRightBtnImgPath
    }
    
    func setTrainingRightBtnImgPath(url : NSURL){
        tRightBtnImgPath = url
    }
    
    
    func getFreePlayRightBtnImgPath()-> NSURL{
        return fRightBtnImgPath
    }
    
    func getFreePlayRightBtnImgPath(url : NSURL){
        fRightBtnImgPath = url
    }
    
    func getFreePlayLeftBtnImgPath()-> NSURL{
        return fLeftBtnImgPath
    }
    
    func getFreePlayLeftBtnImgPath(url : NSURL){
        fLeftBtnImgPath = url
    }

}
