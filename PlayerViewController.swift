//
//  PlayerViewController.swift
//  MusicPlayerApp
//
//  Created by Frezy Stone Mboumba on 7/16/16.
//  Copyright © 2016 Frezy Stone Mboumba. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var shuffle: UISwitch!
    
    var trackId: Int = 0
    var library = MusicLibrary().library
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let coverImage = library[trackId]["coverImage"]{
        coverImageView.image = UIImage(named: "\(coverImage).jpg")
        }
        
        songTitleLabel.text = library[trackId]["title"]
        artistLabel.text = library[trackId]["artist"]
        
        let path = NSBundle.mainBundle().pathForResource("\(trackId)", ofType: "mp3")
        
        if let path = path {
            let mp3URL = NSURL(fileURLWithPath: path)
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOfURL: mp3URL)
                audioPlayer.play()
                
                NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(PlayerViewController.updateProgressView), userInfo: nil, repeats: true)
                progressView.setProgress(Float(audioPlayer.currentTime/audioPlayer.duration), animated: false)
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
        
    }

    override func viewWillDisappear(animated: Bool) {
        audioPlayer.stop()
    }
    
    func updateProgressView(){
        
        if audioPlayer.playing {
            
            progressView.setProgress(Float(audioPlayer.currentTime/audioPlayer.duration), animated: true)
        }
        
    }
    
    
    @IBAction func playAction(sender: AnyObject) {
        if !audioPlayer.playing {
            audioPlayer.play()
        }
        
    }

    @IBAction func stopAction(sender: AnyObject) {
    
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        progressView.progress = 0
    }
    
    
    @IBAction func pauseAction(sender: AnyObject) {
    audioPlayer.pause()
    }
    
    @IBAction func fastForwardAction(sender: AnyObject) {
        var time: NSTimeInterval = audioPlayer.currentTime
        time += 5.0
        
        if time > audioPlayer.duration {
            stopAction(self)
        }else {
            audioPlayer.currentTime = time
        }
        
    }
    
    @IBAction func rewindAction(sender: AnyObject) {
        var time: NSTimeInterval = audioPlayer.currentTime
        time -= 5.0
        
        if time < 0 {
            stopAction(self)
        }else {
            audioPlayer.currentTime = time
        }
    }
    
   
    @IBAction func previousAction(sender: AnyObject) {
        if trackId != 0 || trackId > 0 {
            if shuffle.on {
                trackId = Int(arc4random_uniform(UInt32(library.count)))
            }else {
                trackId -= 1
            }
            
            if let coverImage = library[trackId]["coverImage"]{
                coverImageView.image = UIImage(named: "\(coverImage).jpg")
            }
            
            songTitleLabel.text = library[trackId]["title"]
            artistLabel.text = library[trackId]["artist"]
            
            audioPlayer.currentTime = 0
            progressView.progress = 0
            
            let path = NSBundle.mainBundle().pathForResource("\(trackId)", ofType: "mp3")
            
            if let path = path {
                let mp3URL = NSURL(fileURLWithPath: path)
                
                do {
                    audioPlayer = try AVAudioPlayer(contentsOfURL: mp3URL)
                    audioPlayer.play()
                    
                    NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(PlayerViewController.updateProgressView), userInfo: nil, repeats: true)
                    progressView.setProgress(Float(audioPlayer.currentTime/audioPlayer.duration), animated: false)
                    
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        }
        
    
        
    
    }
    
    @IBAction func nextAction(sender: AnyObject) {
   
        if trackId == 0 || trackId < 4 {
            if shuffle.on {
                trackId = Int(arc4random_uniform(UInt32(library.count)))
            }else {
                trackId += 1
            }
            
            if let coverImage = library[trackId]["coverImage"]{
                coverImageView.image = UIImage(named: "\(coverImage).jpg")
            }
            
            songTitleLabel.text = library[trackId]["title"]
            artistLabel.text = library[trackId]["artist"]
            
            audioPlayer.currentTime = 0
            progressView.progress = 0
            
            let path = NSBundle.mainBundle().pathForResource("\(trackId)", ofType: "mp3")
            
            if let path = path {
                let mp3URL = NSURL(fileURLWithPath: path)
                
                do {
                    audioPlayer = try AVAudioPlayer(contentsOfURL: mp3URL)
                    audioPlayer.play()
                    
                    NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(PlayerViewController.updateProgressView), userInfo: nil, repeats: true)
                    progressView.setProgress(Float(audioPlayer.currentTime/audioPlayer.duration), animated: false)
                    
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        }
       
    }
    
    
    
    
}
