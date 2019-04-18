//
//  PodcastResult.swift
//  PodcastPicker
//
//  Created by Chelsea Troy on 4/17/19.
//  Copyright © 2019 Chelsea Troy. All rights reserved.
//

import Foundation

struct PodcastResult: Codable {
    let resultCount: Int
    let results: [Podcast]
}

struct Podcast: Codable {
    let artistName: String
    let trackName: String
    let genres: [String]
}
