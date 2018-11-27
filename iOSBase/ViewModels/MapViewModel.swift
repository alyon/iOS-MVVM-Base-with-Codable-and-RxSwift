//
//  MapViewController.swift
//  iOSBase
//
//  Created by ali uzun on 02/10/2018.
//  Copyright © 2018 ali uzun. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol MapViewPresentable {

  var placesVariable : BehaviorRelay<Place>{get set}
  var isLoadingVariable:BehaviorRelay<Bool> {get set}
  var errorSubject :PublishSubject<Error> {get set}
}

struct MapViewModel:MapViewPresentable {
  
  var placesVariable: BehaviorRelay = BehaviorRelay(value: Place())
  var isLoadingVariable: BehaviorRelay<Bool> = BehaviorRelay(value: false)
   var errorSubject: PublishSubject<Error> = PublishSubject<Error>()
   let disposeBag =  DisposeBag()
  
  init(){
    var root  = self
   
    self.fetchUsersObservable()
      .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
      .observeOn(MainScheduler.instance)
      .do(onNext: { _ in root.isLoadingVariable = BehaviorRelay(value: true) })
      .bind(to: root.placesVariable)
      .disposed(by: root.disposeBag)
  }
}

extension MapViewModel {
 
  private func fetchUsersObservable() -> Observable<Place> {
    let client = Client(accessToken: "<access_token>")
    return client
      .request(API.getPlaces())
      .asObservable()
  }
  }

