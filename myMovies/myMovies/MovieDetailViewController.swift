//
//  MovieDetailViewController.swift
//  myMovies
//
//  Created by John Russel Usi on 01/08/2017.
//  Copyright © 2017 johnrusselusi. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scheduleLabel: UILabel!
    @IBOutlet weak var summaryTextView: UITextView!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() -> Void {
        
        titleLabel.text = movie?.name
        scheduleLabel.text = String(format: "%@ - %@", (movie?.startTime)!, (movie?.endTime)!)
        
        switch movie!.rating {
        case .av:
            ratingImageView.image = UIImage(named: "icon_rating_av")
        case .g:
            ratingImageView.image = UIImage(named: "icon_rating_g")
        case .m:
            ratingImageView.image = UIImage(named: "icon_rating_m")
        case .ma:
            ratingImageView.image = UIImage(named: "icon_rating_ma")
        case .pg:
            ratingImageView.image = UIImage(named: "icon_rating_pg")
        case .nr:
            break
        }

    }
}
