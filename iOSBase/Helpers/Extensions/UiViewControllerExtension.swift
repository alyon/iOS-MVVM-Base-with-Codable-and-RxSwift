//
//  UiViewControllerExtension.swift
//  iOSBase
//
//  Created by ali uzun on 05/11/2018.
//  Copyright © 2018 ali uzun. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
  func displayAlert(with title:String, and message:String, onSuccess success: @escaping (_ accepted:Bool) -> Void){
    let defaultAction = UIAlertAction(title: "OK",
                                      style: .default) { (action) in
                                        success(true)
                                        self.dismiss(animated: true, completion: nil)
    }
    
    let alert = UIAlertController(title: title,
                                  message: message,
                                  preferredStyle: .alert)
    alert.addAction(defaultAction)
    self.present(alert, animated: true)
  }
  
  func displayAlertWithOption(with title:String, and message:String, buttonTitleSuccess:String, buttonTitleReject:String, onSuccess success: @escaping () -> Void, onReject reject: @escaping () -> Void){
    let defaultAction = UIAlertAction(title: buttonTitleSuccess,
                                      style: .default) { (action) in
                                        success()
                                        self.dismiss(animated: true, completion: nil)
    }
    
    let cancelAction = UIAlertAction(title: buttonTitleReject,
                                     style: .cancel) { (action) in
                                      reject()
                                      self.dismiss(animated: true, completion:nil)
    }
    
    let alert = UIAlertController(title: title,
                                  message: message,
                                  preferredStyle: .alert)
    alert.addAction(defaultAction)
    alert.addAction(cancelAction)
    
    self.present(alert, animated: true)
  }
  
  func displayNetworkError(){
    displayAlert(with: "Network Error", and: "Cannot connect to server", onSuccess: {_ in})
  }
  func displayLocationError(){
    let viewController = self
    displayAlertWithOption(with: "Location Tracking Off", and: "You need location tracking active to navigate", buttonTitleSuccess: "Turn On", buttonTitleReject: "Cancel",
                           onSuccess: {
                            viewController.navigateToSettings()},
                           onReject: {})
  }
  
  func isSmallScreen()->Bool{
    if UIDevice().userInterfaceIdiom == .phone {
      switch UIScreen.main.nativeBounds.height {
      case 1136, 1334:
        return true
      default:
        return false
      }
    }
    return false
  }
  
  func popToRoot(){
    self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
  }
  
  func navigateToSettings(){
    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
      return
    }
    
    if UIApplication.shared.canOpenURL(settingsUrl) {
      UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
        print("Settings opened: \(success)") // Prints true
      })
    }
  }
  
}

