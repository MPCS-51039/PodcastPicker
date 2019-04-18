//
//  ViewController.swift
//  PodcastPicker
//
//  Created by Chelsea Troy on 4/15/19.
//  Copyright © 2019 Chelsea Troy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var podcasts: [Podcast] = []
    var podcastService: PodcastService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "My Podcasts"
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(
            x: self.view.center.x,
            y: self.view.center.y,
            width: 20,
            height: 20
        ))
        self.view.addSubview(activityIndicator)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        self.podcastService = PodcastService()
        self.podcastService.search(for: "comedy", completion: { podcasts, error in
            guard let podcasts = podcasts, error == nil else {
                print(error ?? "unknown error")
                return
            }
            self.podcasts = podcasts
            self.tableView.reloadData()
            activityIndicator.stopAnimating()
        })
    }
}

extension ViewController: UITableViewDelegate {
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.podcasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let podcast = podcasts[indexPath.row]
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "podcastCell", for: indexPath)
        cell.textLabel?.text = podcast.trackName
        
        return cell
    }
}

