//
//  PodcastService.swift
//  PodcastPicker
//
//  Created by Chelsea Troy on 4/15/19.
//  Copyright © 2019 Chelsea Troy. All rights reserved.
//

import UIKit

struct PodcastResult: Codable {
    let resultCount: Int
    let results: [Podcast]
}

struct Podcast: Codable {
    let artistName: String
    let trackName: String
    let genres: [String]
}

class PodcastService {
    var dataTask: URLSessionDataTask?
    
    private let urlString = "https://itunes.apple.com/search?country=US&media=podcast&limit=20&term="
    
    func search(for searchTerm: String, completion: @escaping ([Podcast]?, Error?) -> ()) {
        
        guard let url = URL(string: urlString + searchTerm) else {
            print("invalid url: \(urlString + searchTerm)")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                DispatchQueue.main.async { completion(nil, error) }
                return
            }
            
            print("Status code: \(response.statusCode)")
            print(String(data: data, encoding: .utf8) ?? "unable to print data")
            
            do {
                let decoder = JSONDecoder()
                let podcastResult = try decoder.decode(PodcastResult.self, from: data)
                DispatchQueue.main.async { completion(podcastResult.results, nil) }
            } catch (let error) {
                DispatchQueue.main.async { completion(nil, error) }
            }
        }
        task.resume()
    }
}

