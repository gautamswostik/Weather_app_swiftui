//
//  UserLocation.swift
//  WeatherAppSwiftUi
//
//  Created by swostik gautam on 30/12/2022.
//

import Foundation
import CoreLocation

enum LocationError : Error {
    case locationError
}

class CurrentUserLocation: NSObject, CLLocationManagerDelegate {
    
    var completion: ((Result<CLLocation , Error>) ->Void)?
    var locationManager  = CLLocationManager()
    
    func requestLocationPermission(completion: @escaping(Result<CLLocation , Error> ) ->Void) {
        self.completion = completion
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        completion?(.success(location))
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        completion?(.failure(error))
    }
}
