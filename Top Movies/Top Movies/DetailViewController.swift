//
//  DetailViewController.swift
//  Top Movies
//
//  Created by Nathan Ansel on 1/21/16.
//  Copyright © 2016 Nathan Ansel. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
  var movieImage: UIImage? = UIImage()
  @IBOutlet weak var posterView: UIImageView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    posterView.image = movieImage

    // Do any additional setup after loading the view.
  }
  
  
  
  
  
}
