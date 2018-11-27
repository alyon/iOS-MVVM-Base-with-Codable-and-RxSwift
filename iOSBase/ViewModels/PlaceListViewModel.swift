//
//  PlaceListViewModel.swift
//  iOSBase
//
//  Created by ali uzun on 02/10/2018.
//  Copyright © 2018 ali uzun. All rights reserved.
//

import Foundation
import RxSwift


protocol PlaceListViewPresentable {
  var isLoadingVariable:Variable<Bool> {get set}
}
class PlaceListViewModel: PlaceListViewPresentable {
  var placeHitVariable: Variable<[PlaceItemPresentable]> = Variable([])

  internal var isLoadingVariable: Variable<Bool> = Variable(false)
  internal let disposeBag =  DisposeBag()
  
  init(){

    self.fetchUsersObservable()
      .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
      .observeOn(MainScheduler.instance)
      .subscribe({place in
        guard let hits = place.element?.hits else{return}
        hits.forEach({hit in
          self.placeHitVariable.value.append(PlaceTableCellViewModel(hit: hit))
        })
      }).disposed(by: disposeBag)
    
  }
  
  func fetchUsersObservable() -> Observable<Place> {
    let client = Client(accessToken: "<access_token>")
    return client
      .request(API.getPlaces())
      .asObservable()
  }
}
