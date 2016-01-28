//
//  Movie.swift
//  Top Movies
//
//  Created by Nathan Ansel on 1/21/16.
//  Copyright © 2016 Nathan Ansel. All rights reserved.
//

import Foundation

class Movie {
  var title:       String
  var description: String
  var posterPath:  String
  var releaseDate: NSDate
  var imageURL:    NSURL
  
  init(title: String?, description: String?, posterPath: String?, releaseDateString: String?) {
    self.title       = title ?? ""
    self.description = description ?? ""
    self.posterPath  = posterPath ?? ""
    imageURL         = NSURL(string:"https://image.tmdb.org/t/p/w342" + self.posterPath) ?? NSURL()
    self.releaseDate = NSDate()
    if let s = releaseDateString {
      let formatter = NSDateFormatter()
      formatter.dateFormat = "yyyy-m-dd"
      if let date = formatter.dateFromString(s) {
        self.releaseDate = date
      }
    }
  }
  
  convenience init() {
    self.init(title: nil, description: nil, posterPath: nil, releaseDateString: nil)
  }
}
