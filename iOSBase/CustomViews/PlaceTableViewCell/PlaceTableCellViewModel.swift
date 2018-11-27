//
//  PlaceTableCellViewModel.swift
//  iOSBase
//
//  Created by ali uzun on 02/10/2018.
//  Copyright © 2018 ali uzun. All rights reserved.
//

import RxSwift

protocol PlaceItemPresentable {
  var hit:Hit?{get}
}

class PlaceTableCellViewModel: PlaceItemPresentable{
  var hit: Hit?
  
  init( hit:Hit) {
    self.hit = hit
  }
}
