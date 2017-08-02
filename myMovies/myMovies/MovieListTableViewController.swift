//
//  ViewController.swift
//  myMovies
//
//  Created by John Russel Usi on 31/07/2017.
//  Copyright © 2017 johnrusselusi. All rights reserved.
//

import UIKit

class MovieListTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    var movies: [Movie] = [Movie]()
    var isLoadingData: Bool = false
    var currentPage = 0
    var totalPages = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        requestMovieList()
        loadingIndicator.hidesWhenStopped = true
        tableView.addSubview(loadingIndicator)
    }
    
    func requestMovieList() -> Void {
        
        APIRequestManager.sharedInstance.httpGETRequest(urlString: "https://www.whatsbeef.net/wabz/guide.php?", parameters: ["start": currentPage], successBlock: { (jsonResponse) in
            
            self.totalPages = jsonResponse["count"] as! Int
            let movies = jsonResponse["results"] as! [[String: Any]]
            movies.forEach({ (movie) in
                let newMovie = Movie(json: movie)
                self.movies.append(newMovie)
            })
            
            self.isLoadingData = false
            self.loadingIndicator.stopAnimating()
            self.tableView.reloadData()
            
        }) { (error) in
            let alertController = UIAlertController(title: "Connection Error", message: "Error retrieving data from the server.", preferredStyle: .alert)
            let tryAgainAction = UIAlertAction(title: "Try Again", style: .default, handler: { (action) in
                
                self.requestMovieList()
            })
            self.isLoadingData = false
            self.loadingIndicator.stopAnimating()
            alertController.addAction(tryAgainAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
        let lastIndex = IndexPath(row: movies.count - 1, section: 0)
        let lastCell = tableView.cellForRow(at: lastIndex)
        
        if lastCell == nil {
        
            return
        }
        
        let isLastCellVisible = tableView.visibleCells.contains(lastCell!)
        
        if scrollView.contentOffset.y > 0 && isLoadingData == false && isLastCellVisible == true {
            UIView.animate(withDuration: Double(1), animations: {
                
                scrollView.contentInset = UIEdgeInsetsMake(0, 0, 40, 0)
            }, completion: { (isFinished) in
                
                self.isLoadingData = true
                self.loadingIndicator.frame = CGRect(x: self.view.center.x - 20, y: scrollView.contentSize.height, width: 40, height: 40)
                self.loadingIndicator.startAnimating()
            })
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        UIView.animate(withDuration: 0.2, animations: { 
            scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }, completion: { (isFinished) in
     
            if self.isLoadingData == true {
            
                self.currentPage += 1
                
                if self.currentPage == self.totalPages {
                    
                    return
                }
                
                self.loadingIndicator.stopAnimating()
                self.requestMovieList()
            }
        })
    }
}

extension MovieListTableViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let movie = movies[indexPath.row]
        let movieDetailViewController = storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        movieDetailViewController.movie = movie
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
}

extension MovieListTableViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = movies[indexPath.row]
        cell.setupMovieCell(withMovie: movie)
        return cell
    }
}
