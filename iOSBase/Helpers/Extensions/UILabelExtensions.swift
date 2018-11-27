//
//  UILabelExtensions.swift
//  iOSBase
//
//  Created by ali uzun on 05/11/2018.
//  Copyright © 2018 ali uzun. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
  func enableAccessibility() -> Void{
    
    self.isAccessibilityElement = true
    self.accessibilityTraits = UIAccessibilityTraits.staticText
    self.accessibilityValue = self.text
    
    let userFont = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body)
    let size  = userFont.pointSize > 25 ? 25 : userFont.pointSize
    
    let font =  self.font.withSize(size)
    self.font = font
    self.adjustsFontForContentSizeCategory = true
  }
}
