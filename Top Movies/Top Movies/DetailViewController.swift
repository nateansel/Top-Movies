//
//  DetailViewController.swift
//  Top Movies
//
//  Created by Nathan Ansel on 1/21/16.
//  Copyright © 2016 Nathan Ansel. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
  @IBOutlet weak var scrollView:  UIScrollView!
  @IBOutlet weak var contentView: UIView!
  @IBOutlet weak var posterView:  UIImageView!
  @IBOutlet weak var movieTitle:  UILabel!
  @IBOutlet weak var overview:    UILabel!
  
  var movie = Movie()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title! = movie.title
    posterView.setImageWithURL(movie.imageURL)
    movieTitle!.text = movie.title
    overview!.text = movie.overview
    

    // Do any additional setup after loading the view.
  }
  
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
//    contentView.frame.size.width = view.frame.size.width
//    scrollView.contentSize = CGSizeMake(view.frame.size.width, contentView.frame.size.height)
  }
  
  
  
  
  
}
