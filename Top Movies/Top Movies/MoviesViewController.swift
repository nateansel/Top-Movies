//
//  MoviesViewController.swift
//  Top Movies
//
//  Created by Nathan Ansel on 1/7/16.
//  Copyright © 2016 Nathan Ansel. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  @IBOutlet weak var tableView: UITableView!
  
  // MARK: - Properties
  var movies = [NSDictionary]?()
  var filteredMovies = [NSDictionary]?()
  
  var refreshControl: UIRefreshControl!
  var hud: MBProgressHUD!
  
  
  
  
  // MARK: - Methods
  // MARK: View controller overrides
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    tableView.dataSource = self
    tableView.delegate = self
    
    refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: "refreshData", forControlEvents: UIControlEvents.ValueChanged)
    tableView.insertSubview(refreshControl, atIndex: 0)
    
    hud = MBProgressHUD.showHUDAddedTo(tableView, animated: true)
    hud.mode = .Indeterminate
    hud.labelText = "Loading"
    hud.removeFromSuperViewOnHide = true
    refreshData()
  }
  
  
  
  

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  
  
  // MARK: Table view overrides
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("movieCell", forIndexPath: indexPath) as! CustomTableViewCell
    
    let title = filteredMovies![indexPath.row]["title"] as! String
    let overview = filteredMovies![indexPath.row]["overview"] as! String
    let imageUrl = NSURL(string:"https://image.tmdb.org/t/p/w342" + (movies![indexPath.row]["poster_path"] as! String))
    
    cell.titleLabel.text = title
    cell.overviewLabel.text = overview
    cell.posterView.setImageWithURL(imageUrl!)
    return cell
  }
  
  
  
  
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let numRows = filteredMovies?.count {
      return numRows
    }
    return 0
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
              self.filteredMovies = results
              self.tableView.reloadData()
              NSLog("response: \(responseDictionary)")
              self.hud.hide(true)
          }
        }
        else {
          
        }
        self.refreshControl.endRefreshing()
    });
    task.resume()
  }
}
