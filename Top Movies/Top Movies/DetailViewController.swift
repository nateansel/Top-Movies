//
//  DetailViewController.swift
//  Top Movies
//
//  Created by Nathan Ansel on 1/21/16.
//  Copyright © 2016 Nathan Ansel. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
  @IBOutlet weak var posterView: UIImageView!
  @IBOutlet weak var movieTitle: UILabel!
  @IBOutlet weak var overview: UILabel!
  
  var movie = Movie()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title! = movie.title
    posterView.setImageWithURL(movie.imageURL)
    movieTitle!.text = movie.title
    overview!.text = movie.description
    

    // Do any additional setup after loading the view.
  }
  
  
  
  
  
}
