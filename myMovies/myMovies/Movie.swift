//
//  Movie.swift
//  myMovies
//
//  Created by John Russel Usi on 01/08/2017.
//  Copyright © 2017 johnrusselusi. All rights reserved.
//

import Foundation

public enum Rating: String {

    case g = "G"
    case m = "M"
    case av = "AV"
    case ma = "MA"
    case pg = "PG"
    case nr = ""
}

public enum Channel: String {
    
    case nine = "Nine"
    case ten = "TEN"
    case one = "ONE"
    case abc1 = "ABC1"
    case sbs1 = "SBS One"
    case sbs2 = "SBS 2"
    case seventwo = "7TWO"
    case sevenmate = "7Mate"
    case seven = "Seven"
    case eleven = "ELEVEN"
}

class Movie: NSObject {

    var name: String?
    var startTime: String?
    var endTime: String?
    var channel: Channel
    var rating: Rating
    
    init(json: [String: Any]) {
        
        name = json["name"] as? String
        startTime = json["start_time"] as? String
        endTime = json["end_time"] as? String
        channel = Channel(rawValue: json["channel"] as! String)!
        rating = Rating(rawValue: json["rating"] as! String)!
    }
}
