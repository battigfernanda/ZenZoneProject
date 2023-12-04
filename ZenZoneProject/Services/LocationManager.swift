//
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
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters // More battery-efficient
        self.locationManager.distanceFilter = 50 // Update every 50 meters
        self.checkIfLocationServicesIsEnabled()
    }

    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            DispatchQueue.main.async {
                self.locationManager.requestWhenInUseAuthorization()
            }
        } else {
            print("Location services are not enabled")
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.locationStatus = status
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            print("Location Authorization Granted.")
            self.locationManager.startUpdatingLocation()
        } else {
            DispatchQueue.main.async {
                // Handle other authorization statuses on the main thread
                switch status {
                case .denied, .restricted:
                    print("Location Authorization Denied or Restricted.")
                    // Handle denied/restricted status
                case .notDetermined:
                    print("Location Authorization Not Determined.")
                    // Handle not determined status
                @unknown default:
                    print("Unknown Location Authorization Status.")
                    // Handle future cases
                }
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
