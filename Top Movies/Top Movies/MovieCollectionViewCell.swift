//
//  MovieCollectionViewCell.swift
//  Top Movies
//
//  Created by Nathan Ansel on 1/24/16.
//  Copyright © 2016 Nathan Ansel. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var posterView: UIImageView!
  
  override var selected: Bool {
    didSet {
      if selected {
        layer.borderColor = UIColor.whiteColor().CGColor
        layer.borderWidth = 2.0
        layer.cornerRadius = 3.0
        layer.masksToBounds = true
      }
      else {
        layer.borderColor = .None
        layer.borderWidth = 0.0
        layer.cornerRadius = 0.0
        layer.masksToBounds = true
      }
    }
  }
}
