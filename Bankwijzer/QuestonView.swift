//
//  questonView.swift
//  Bankwijzer
//
//  Created by Fhict on 01/05/15.
//  Copyright (c) 2015 Fhict. All rights reserved.
//

import UIKit
import AVFoundation

class QuestonView: UIViewController {

    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var subtext: UILabel!
    @IBOutlet weak var imgBad: UIImageView!
    @IBOutlet weak var imgNeutral: UIImageView!
    @IBOutlet weak var imgGood: UIImageView!
    
    var audioPlayer = AVAudioPlayer()

    var q = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // add tap gesture recognizers to imageviews
        imgBad.userInteractionEnabled = true
        imgBad.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "handleTap:"))
        imgNeutral.userInteractionEnabled = true
        imgNeutral.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "handleTap:"))
        imgGood.userInteractionEnabled = true
        imgGood.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "handleTap:"))
        
        // Set first question
        changeQuestion(q)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // called when image is tapped
    func handleTap(gestureRecognizer: UITapGestureRecognizer){
        q++
        changeQuestion(q)
        println("next")
    }

    func changeQuestion(i : Int) {
        if(i < 20) {
            // JSON Stuff - filling labels
            Data.getDataWithSuccess { (Data) -> Void in
                let json = JSON(data: Data)
                if let subject = json["values"][i]["s"].string {
                    dispatch_async(dispatch_get_main_queue()){
                        self.subject.text = subject
                    }
                }
                if let subtext = json["values"][i]["q"].string {
                    dispatch_async(dispatch_get_main_queue()){
                        self.subtext.text = subtext
                    }
                }
            }
        }
        else {
            dispatch_async(dispatch_get_main_queue()){
                self.subject.text = "Einde"
                self.subtext.text = "Je bent klaar!! Nu moet er nog een resultatenview verschijnen."
                self.imgBad.hidden = true
                self.imgNeutral.hidden = true
                self.imgGood.hidden = true
                
                // Play win sound
                var alertSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("tada", ofType: "wav")!)
                
                AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil)
                AVAudioSession.sharedInstance().setActive(true, error: nil)
                
                var error:NSError?
                self.audioPlayer = AVAudioPlayer(contentsOfURL: alertSound, error: &error)
                self.audioPlayer.prepareToPlay()
                self.audioPlayer.play()
            }
        }
    }
    
}
