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
  @IBOutlet weak var label: UILabel!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    posterView.image = movieImage
    label.font = UIFont.boldSystemFontOfSize(20)

    // Do any additional setup after loading the view.
  }
  
  
  
  
  
}
