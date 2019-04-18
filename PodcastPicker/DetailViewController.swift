//
//  DetailViewController.swift
//  PodcastPicker
//
//  Created by Chelsea Troy on 4/17/19.
//  Copyright © 2019 Chelsea Troy. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    var podcast: Podcast?
    
    @IBOutlet weak var artistNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.artistNameLabel.text = podcast?.artistName
    }
}
