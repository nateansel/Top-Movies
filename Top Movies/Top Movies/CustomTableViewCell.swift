//
//  CustomTableViewCell.swift
//  Top Movies
//
//  Created by Nathan Ansel on 1/7/16.
//  Copyright © 2016 Nathan Ansel. All rights reserved.
//

import UIKit

/// test
class CustomTableViewCell: UITableViewCell {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var overviewLabel: UILabel!
  @IBOutlet weak var posterView: UIImageView!
  
  

  override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
  }

  override func setSelected(selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)

      // Configure the view for the selected state
  }

}
