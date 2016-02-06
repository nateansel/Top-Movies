//
//  DetailViewController.swift
//  Top Movies
//
//  Created by Nathan Ansel on 1/21/16.
//  Copyright © 2016 Nathan Ansel. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
  @IBOutlet weak var scrollView:       UIScrollView!
  @IBOutlet weak var blurView:         UIVisualEffectView!
  @IBOutlet weak var displacementView: UIView!
  @IBOutlet weak var posterView:       UIImageView!
  @IBOutlet weak var movieTitle:       UILabel!
  @IBOutlet weak var overview:         UILabel!
  @IBOutlet weak var otherInformation: UILabel!
  
  var movie = Movie()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title? = movie.title
    navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    navigationController?.tabBarController?.tabBarItem
    
    posterView.setImageWithURL(movie.imageURL)
    posterView.clipsToBounds = true
    movieTitle?.text = movie.title
    overview?.text = movie.overview
    otherInformation?.text = constructOtherInformationString()
    
    // Set up the displacement view (this pushes down the blur view)
    displacementView.backgroundColor = UIColor.clearColor()
    displacementView.frame.size.height = view.frame.size.height / 2
    if blurView.frame.size.height < view.frame.size.height / 2 {
      displacementView.frame.size.height = view.frame.size.height - blurView.frame.size.height
    }
    print(displacementView.frame.size.height)

    // Do any additional setup after loading the view.
  }
  
  
  func constructOtherInformationString() -> String {
    var toReturn = ""
    let formatter = NSDateFormatter()
    formatter.dateFormat = "m/dd/yyyy"
    toReturn += "Release Date: " + formatter.stringFromDate(movie.releaseDate) + "\n"
    toReturn += "Overall Rating: " + String(movie.rating) + "\n"
    
    return toReturn
  }
}
