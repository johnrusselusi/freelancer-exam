//
//  MovieCell.swift
//  myMovies
//
//  Created by John Russel Usi on 01/08/2017.
//  Copyright © 2017 johnrusselusi. All rights reserved.
//

import Foundation
import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var channelIconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scheduleLabel: UILabel!
    @IBOutlet weak var ratingIconImageView: UIImageView!
    
    func setupMovieCell(withMovie movie: Movie) -> Void {
        
        nameLabel.text = movie.name
        scheduleLabel.text = String(format: "%@ - %@", movie.startTime!, movie.endTime!)
        
        switch movie.channel {
        case .nine:
            channelIconImageView.image = UIImage(named: "icon_channel_9")
        case .abc1:
            channelIconImageView.image = UIImage(named: "icon_channel_abc1")
        case .eleven:
            channelIconImageView.image = UIImage(named: "icon_channel_eleven")
        case .one:
            channelIconImageView.image = UIImage(named: "icon_channel_one")
        case .sbs1:
            channelIconImageView.image = UIImage(named: "icon_channel_sbs1")
        case .sbs2:
            channelIconImageView.image = UIImage(named: "icon_channel_sbs2")
        case .seven:
            channelIconImageView.image = UIImage(named: "icon_channel_seven")
        case .sevenmate:
            channelIconImageView.image = UIImage(named: "icon_channel_7mate")
        case .seventwo:
            channelIconImageView.image = UIImage(named: "icon_channel_7two")
        case .ten:
            channelIconImageView.image = UIImage(named: "icon_channel_ten")
        }
        
        switch movie.rating {
        case .av:
            ratingIconImageView.image = UIImage(named: "icon_rating_av")
        case .g:
            ratingIconImageView.image = UIImage(named: "icon_rating_g")
        case .m:
            ratingIconImageView.image = UIImage(named: "icon_rating_m")
        case .ma:
            ratingIconImageView.image = UIImage(named: "icon_rating_ma")
        case .pg:
            ratingIconImageView.image = UIImage(named: "icon_rating_pg")
        case .nr:
            break
        }
    }
}
