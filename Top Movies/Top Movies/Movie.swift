//
//  Movie.swift
//  Top Movies
//
//  Created by Nathan Ansel on 1/21/16.
//  Copyright © 2016 Nathan Ansel. All rights reserved.
//

import Foundation

class Movie {
  var title: String
  var description: String
  var posterPath: String
  var releaseDate: NSDate
  
  init(title: String, description: String, posterPath: String, releaseDateString: String) {
    self.title       = title
    self.description = description
    self.posterPath  = posterPath
    
    let formatter = NSDateFormatter()
    formatter.dateFormat = "yyyy-m-dd"
    if let date = formatter.dateFromString(releaseDateString) {
      self.releaseDate = date
    }
    else {
      self.releaseDate = NSDate()
    }
  }
  
  convenience init() {
    self.init(title: "", description: "", posterPath: "", releaseDateString: "")
  }
  
  
  
  
  func getPosterImage() {
    return
  }
}
