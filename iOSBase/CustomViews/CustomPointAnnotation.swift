//
//  CustomPointAnnotation.swift
//  iOSBase
//
//  Created by ali uzun on 02/10/2018.
//  Copyright © 2018 ali uzun. All rights reserved.
//

import UIKit
import MapKit

class CustomPointAnnotation: MKPointAnnotation {
  var pinCustomImageName:String!
  var pinData:Hit?
  var containedAnnotations: NSArray?
  var clusterAnnotation: CustomPointAnnotation?
}
