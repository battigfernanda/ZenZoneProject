//
//  NearbyMeditationSpotsView.swift
//  ZenZoneProject
//
//  Created by Fernanda Battig on 2023-11-26.
//

import SwiftUI
import CoreLocation


struct NearbyParksView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var parks: [Park] = []

    var body: some View {
        List(parks, id: \.id) { park in
            NavigationLink(destination: ParkDetailView(park: park)) {
                HStack {
                    Image(systemName: "leaf.fill")
                        .foregroundColor(.green)
                    Text(park.name)
                }
            }
        }
        .onAppear {
            locationManager.checkIfLocationServicesIsEnabled()
        }
        .onChange(of: locationManager.lastLocation) { newLocation in
            fetchNearbyParks(location: newLocation)
        }
        .navigationTitle("Nearby Parks")
    }

    func fetchNearbyParks(location: CLLocation?) {
        guard let location = location else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude

        let apiKey = "AIzaSyAd2mxa5rXNcmkjkL16rpeByTTfBjESVYc"
        let radius = 1500
        let type = "park"
        let apiUrl = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(latitude),\(longitude)&radius=\(radius)&type=\(type)&key=\(apiKey)"

        guard let url = URL(string: apiUrl) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                if let response = try? decoder.decode(Response.self, from: data) {
                    DispatchQueue.main.async {
                        self.parks = response.results.map { place in
                            Park(id: place.id, name: place.name, coordinate: CLLocationCoordinate2D(latitude: place.geometry.location.lat, longitude: place.geometry.location.lng))
                        }
                    }
                } else {
                    print("Error: Couldn't decode response")
                }
            } else if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }.resume()
    }
}

struct Park: Identifiable {
    let id: String
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct ParkDetailView: View {
    let park: Park

    var body: some View {
        Text(park.name)
    
    }
}

struct NearbyParksView_Previews: PreviewProvider {
    static var previews: some View {
        NearbyParksView()
    }
}
