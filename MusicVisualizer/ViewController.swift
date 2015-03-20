//
//  ViewController.swift
//  MusicVisualizer
//
//  Created by Kangsoo Jung on 2014. 12. 29..
//  Copyright (c) 2014년 Jung. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer!;
    var visualizer: VisulizerView!;
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureAudioSession();
        
        visualizer = VisulizerView(frame: self.view.frame);
        visualizer.autoresizingMask = .FlexibleHeight | .FlexibleWidth;
        view.addSubview(visualizer);
        configureAudioPlayer();
    }

    func configureAudioPlayer(){
        var url = NSBundle.mainBundle().URLForResource("Let It Go", withExtension: "m4a")!;
        NSLog("url:%@", url);
        
        audioPlayer = AVAudioPlayer(contentsOfURL: url, error: nil);
        
        audioPlayer.meteringEnabled = true;
        visualizer.audioPlayer = audioPlayer;
        
        audioPlayer.numberOfLoops = -1;
        audioPlayer.play();
    }
    
    func configureAudioSession() {
    
        AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil);
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

