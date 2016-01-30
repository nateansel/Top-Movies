//
//  TopMoviesAsCollectionViewController.swift
//  Top Movies
//
//  Created by Nathan Ansel on 1/24/16.
//  Copyright © 2016 Nathan Ansel. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class TopMoviesAsCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

  
  // MARK: - Properties
  @IBOutlet weak var collectionView: UICollectionView!
  var searchBar: UISearchBar!
  
  var movies = [NSDictionary]?()
  var filteredMovies = [Movie]?()
  var refreshControl: UIRefreshControl!
  var hud:            MBProgressHUD!
  
  
  // MARK: - Methods
  // MARK: View controller overrides
  override func viewDidLoad() {
    super.viewDidLoad()
    
    searchBar = UISearchBar()
    searchBar.showsCancelButton = false
    searchBar.barStyle = .BlackTranslucent
    navigationItem.titleView = searchBar
    
    
    collectionView.dataSource = self
    collectionView.delegate   = self
    searchBar.delegate        = self
    
    refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: "refreshData", forControlEvents: UIControlEvents.ValueChanged)
    refreshControl.layer.zPosition = -1
    collectionView.insertSubview(refreshControl, atIndex: 0)
    
    hud           = MBProgressHUD.showHUDAddedTo(collectionView, animated: true)
    hud.mode      = .Indeterminate
    hud.labelText = "Loading"
    hud.removeFromSuperViewOnHide = true
    refreshData()
  }
  
  
  
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  
  
  // MARK: Table view overrides
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MovieCollectionViewCell", forIndexPath: indexPath) as! MovieCollectionViewCell
    
    let imageUrl = NSURL(string:"https://image.tmdb.org/t/p/w342" + filteredMovies![indexPath.row].posterPath)
    cell.posterView.setImageWithURL(imageUrl!)
    return cell
  }
  
  
  
  
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if let numRows = filteredMovies?.count {
      return numRows
    }
    return 0
  }
  
  
  
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    let aspectRatio = CGFloat(300) / CGFloat(444)
    let width = view.frame.size.width / 3
    let height = width / aspectRatio
    return CGSizeMake(width, height)
  }
  
  
  
  // MARK: Reloading data
  
  /// Refreshes the movie data held in the app.
  ///
  /// - author: Nathan Ansel
  ///
  func refreshData() {
    let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    let url = NSURL(string:"https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
    let request = NSURLRequest(URL: url!)
    let session = NSURLSession(
      configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
      delegate:nil,
      delegateQueue:NSOperationQueue.mainQueue()
    )
    
    let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
      completionHandler: { (dataOrNil, response, error) in
        if let data = dataOrNil {
          if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
            data, options:[]) as? NSDictionary {
              let results = responseDictionary["results"] as! [NSDictionary]
              self.movies = results
              self.makeMovieList(self.movies!)
              self.collectionView.reloadData()
              NSLog("response: \(responseDictionary)")
              self.hud.hide(true)
          }
        }
        else {
          print("failed response")
        }
        self.refreshControl.endRefreshing()
    });
    task.resume()
  }
  
  
  
  
  
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    searchBar.endEditing(true)
    if segue.identifier == "toDetailView" {
      let destinationViewController = segue.destinationViewController as! DetailViewController
      let cell = sender as! MovieCollectionViewCell
      let indexPath = collectionView.indexPathForCell(cell)
      destinationViewController.movie = filteredMovies![indexPath!.row]
    }
  }
  
  
  
  
  
  func makeMovieList(dictionaryList: [NSDictionary]) {
    filteredMovies = [Movie]()
    for dict in dictionaryList {
      filteredMovies?.append(Movie(
        title:             dict["title"] as? String,
        overview:          dict["overview"] as? String,
        rating:            dict["vote_average"] as? Double,
        posterPath:        dict["poster_path"] as? String,
        releaseDateString: dict["release_date"] as? String))
    }
  }
  
  
  
  
  
  
  // MARK: - Search Bar Delegate
  func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    makeMovieList(movies!)
    if searchText != "" {
      filteredMovies = filteredMovies!.filter({(movie: Movie) -> Bool in
        (movie.title).lowercaseString.containsString(searchText.lowercaseString)
        || (movie.overview).lowercaseString.containsString(searchText.lowercaseString)
      })
    }
    collectionView.reloadData()
  }
}
