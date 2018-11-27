//
//  PlacesStore.swift
//  iOSBase
//
//  Created by ali uzun on 02/10/2018.
//  Copyright © 2018 ali uzun. All rights reserved.
//

enum API {}

extension API {
  static func getPlaces() -> Endpoint<Place> {
    return Endpoint(path: Api.placeAPI,
                    parameters: ["aroundLatLng" : "60.1636335,24.9252424", "hitsPerPage":"20", "language":"en"]
    )
  }
}

