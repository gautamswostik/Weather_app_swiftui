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
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocationPermission(completion: @escaping(Result<CLLocation , Error> ) ->Void) {
        self.completion = completion
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            completion?(.failure(LocationError.locationError))
            return
        }
        completion?(.success(location))
        locationManager.stopUpdatingLocation()
        locationManager.delegate = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        completion?(.failure(error))
        locationManager.delegate = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .denied || status == .restricted {
            completion?(.failure(LocationError.locationError))
            locationManager.delegate = nil
        }
    }
}



