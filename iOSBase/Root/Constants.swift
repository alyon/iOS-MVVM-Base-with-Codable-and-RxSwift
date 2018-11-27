//
//  Constants.swift
//  iOSBase
//
//  Created by ali uzun on 02/10/2018.
//  Copyright © 2018 ali uzun. All rights reserved.
//

import Foundation
import UIKit
import MapKit

struct Api {
  static let baseURL =  URL(string: baseURLString)!
  static let baseURLString = "https://places-dsn.algolia.net/"
  static let placeAPI = "1/places/reverse"
}

struct Map {
  static let regionRadius: CLLocationDistance = 1000
  static let defaultLocation = CLLocation(latitude: 60.1636335, longitude: 24.9252424)
  static let defaultDistance = 50000
}



enum Color {
  static let lightBlue = UIColor(red: 0/255, green: 149/255, blue: 219/255, alpha: 1)
  static let mediumBlue = UIColor(red: 0/255, green: 105/255, blue: 180/255, alpha: 1)
  static let darkBlue = UIColor(red: 11/255, green: 36/255, blue: 66/255, alpha: 1)
  static let scarletRed = UIColor(red: 208/255, green: 2/255, blue: 27/255, alpha: 1)
  static let mediumGrey = UIColor(red: 148/255, green: 148/255, blue: 148/255, alpha: 1)
  static let lightGrey = UIColor(red: 222/255, green: 222/255, blue: 222/255, alpha: 1)
  static let darkGrey = UIColor(red: 117/255, green: 117/255, blue: 117/255, alpha: 1)
}
