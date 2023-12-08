//
//  MKMapView.swift
//  ZenZoneProject
//
//  Created by Fernanda Battig on 2023-12-08.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    var parks: [Park]
    var userLocation: CLLocationCoordinate2D

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        // Updating the map view with new locations
        updateAnnotations(for: uiView)
    }

    private func updateAnnotations(for mapView: MKMapView) {
        mapView.removeAnnotations(mapView.annotations)

        let annotations = parks.map { park -> MKAnnotation in
            let annotation = MKPointAnnotation()
            annotation.title = park.name
            annotation.coordinate = park.coordinate
            return annotation
        }

        mapView.addAnnotations(annotations)
        if let firstPark = parks.first {
            let region = MKCoordinateRegion(center: firstPark.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
            mapView.setRegion(region, animated: true)
        }
    }
}

