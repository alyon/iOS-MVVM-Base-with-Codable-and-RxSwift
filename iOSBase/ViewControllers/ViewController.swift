//
//  ViewController.swift
//  iOSBase
//
//  Created by ali uzun on 02/10/2018.
//  Copyright © 2018 ali uzun. All rights reserved.
//

import UIKit
import MapKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
  
  @IBOutlet weak var placesMapView: MKMapView!
  
  let markerReuseIdentifier = "defaultMarker"
  let clusterReuseIdentifier = "clusterMarker"
  let disposeBag = DisposeBag()
  var viewModel: MapViewModel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel = MapViewModel()
    initMap()
    initData()
  }
  
  fileprivate func initMap() {
    centerMapOnLocation(location: Map.defaultLocation)
    placesMapView.showsUserLocation = true
    placesMapView.showsCompass = false
  }
  
  fileprivate func initData(){
    guard  let places = viewModel?.placesVariable else {return}
    places.asObservable().subscribe({place in
      guard let placeVar = place.element else{return}
      placeVar.hits?.forEach({hit in
        self.placesMapView.addAnnotation(self.getCustomPinAnnotation(hit: hit))
      })
    }).disposed(by: disposeBag)
  }
  
  fileprivate func getCustomPinAnnotation(hit:Hit)->CustomPointAnnotation{
    let hitAnnot = CustomPointAnnotation()
    hitAnnot.pinData = hit
    hitAnnot.coordinate =  CLLocationCoordinate2D(latitude: hit.geoloc.lat, longitude:  hit.geoloc.lng)
    return hitAnnot
  }
  
  fileprivate func centerMapOnLocation(location: CLLocation) {
    let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                              latitudinalMeters: Map.regionRadius, longitudinalMeters: Map.regionRadius)
    placesMapView.setRegion(coordinateRegion, animated: true)
  }
}

extension ViewController: MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    
    switch annotation {
      
    case is MKUserLocation:
      return nil
      
    default:
      if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: markerReuseIdentifier) as? MKMarkerAnnotationView {
        dequeuedView.annotation = annotation
        view = dequeuedView
      } else if annotation .isKind(of: CustomPointAnnotation.self){
        return getDefaultMarker(withColor: Color.lightBlue, annotation: annotation)
      }else {
        var view: MKMarkerAnnotationView
        view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: clusterReuseIdentifier)
        view.markerTintColor = Color.mediumBlue
        return view
      }
    }
    
    return nil
  }
  
  fileprivate func getDefaultMarker(withColor color:UIColor, annotation:MKAnnotation )->MKMarkerAnnotationView{
    let view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: markerReuseIdentifier)
    view.markerTintColor = color
    view.clusteringIdentifier = markerReuseIdentifier
    return view
  }
}

