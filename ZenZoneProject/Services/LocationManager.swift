///
//  LocationManager.swift
//  ZenZoneProject
//
//  Created by Fernanda Battig on 2023-11-26.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var locationStatus: CLAuthorizationStatus?
    @Published var lastLocation: CLLocation?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 50
        locationManager.requestWhenInUseAuthorization() // Request authorization
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        DispatchQueue.main.async {
            self.locationStatus = status
            switch status {
            case .notDetermined:
                // The status is not determined, no need to request again as it's requested in init
                break
            case .authorizedWhenInUse, .authorizedAlways:
                print("Location Authorization Granted.")
                self.locationManager.startUpdatingLocation()
            case .denied, .restricted:
                print("Location Authorization Denied or Restricted.")
            @unknown default:
                print("Unknown Location Authorization Status.")
                
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        DispatchQueue.main.async {
            self.lastLocation = locations.last
            print("Location updated: \(String(describing: self.lastLocation))")
        }
    }

    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
}
