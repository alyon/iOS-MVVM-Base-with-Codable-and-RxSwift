//
//  MapHelper.swift
//  iOSBase
//
//  Created by ali uzun on 27/11/2018.
//  Copyright © 2018 ali uzun. All rights reserved.
//

import Foundation
import MapKit

class MapHelper {
  
  static func hasLocationPermission()-> Bool {
    if CLLocationManager.locationServicesEnabled() {
      switch CLLocationManager.authorizationStatus() {
      case .notDetermined, .restricted, .denied:
        print("No access")
        return false
      case .authorizedAlways, .authorizedWhenInUse:
        print("Access")
        return true
      }
    } else {
      print("Location services are not enabled")
      return false
    }
  }
  
  static func getDirections(selectedPin: MKPlacemark){
    let mapItem = MKMapItem(placemark: selectedPin)
    let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
    mapItem.openInMaps(launchOptions: launchOptions)
  }
  
  static func getRoute(with lat:Double, lon:Double, address:String){
    let coords = CLLocationCoordinate2DMake(lat, lon)
    let mapItem = MKMapItem(placemark: MKPlacemark(coordinate:coords))
    mapItem.name = address
    let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
    mapItem.openInMaps(launchOptions: launchOptions)
  }
  
  static func getClosestPlace(currentCoordintes:CLLocationCoordinate2D, annotations:[MKAnnotation]) -> MKAnnotation?{
    
    let nearestPin: MKAnnotation? = annotations.reduce((CLLocationDistanceMax, nil)) { (nearest, pin) in
      let coord = pin.coordinate
      let loc = CLLocation(latitude: coord.latitude, longitude: coord.longitude)
      let currentLocation = CLLocation(latitude: currentCoordintes.latitude, longitude: currentCoordintes.longitude)
      let distance = currentLocation.distance(from: loc)
      return distance < nearest.0 ? (distance, pin) : nearest
      }.1
    
    return nearestPin
  }
  
  static func getDistance(from currentLocation:CLLocationCoordinate2D? , to destination:CLLocationCoordinate2D) -> Double{
    if currentLocation == nil {
      return 1.0
    }
    let base = CLLocation(latitude: currentLocation!.latitude, longitude: currentLocation!.longitude)
    let destination = CLLocation(latitude: destination.latitude, longitude: destination.longitude)
    return base.distance(from: destination)
  }
  
  static func getFormattedDistanceTitle(distance: Double)-> String{
    if distance > 10000 {
      let dis = distance/1000
      return "\(Int(dis)) km"
    }
    if distance > 1000 {
      let dis = distance/1000
      return String(format: "%.2f km", dis)
    }
    return "\(Int(distance)) m"
  }
  
  static func getDirectionsToPlace(currentCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D) -> MKDirections? {
    
    let sourcePlacemark = MKPlacemark(coordinate: currentCoordinate, addressDictionary: nil)
    let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate, addressDictionary: nil)
    
    let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
    let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
    
    let sourceAnnotation = MKPointAnnotation()
    
    if let location = sourcePlacemark.location {
      sourceAnnotation.coordinate = location.coordinate
    }
    
    let destinationAnnotation = MKPointAnnotation()
    
    if let location = destinationPlacemark.location {
      destinationAnnotation.coordinate = location.coordinate
    }
    
    let directionRequest = MKDirections.Request()
    directionRequest.source = sourceMapItem
    directionRequest.destination = destinationMapItem
    directionRequest.transportType = .walking
    
    
    // Calculate the direction
    return MKDirections(request: directionRequest)
  }
  
  
}
