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
    
        .onChange(of: locationManager.lastLocation) { newLocation in
            fetchNearbyParks(location: newLocation)
        }
        .navigationTitle("Nearby Parks")
    }

    func fetchNearbyParks(location: CLLocation?) {
        guard let location = location else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        let apiKey = "AIzaSyCa1XMpQBz9aSzpz-FZVygRfUw6H9h9tNU"
        let radius = 1500
        let type = "park"
        let apiUrl = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(latitude),\(longitude)&radius=\(radius)&type=\(type)&key=\(apiKey)"
        
        guard let url = URL(string: apiUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("Error: No data received")
                return
            }

            // Loging the raw JSON string for debugging
            let jsonString = String(data: data, encoding: .utf8) ?? "Invalid JSON string"
            print("Received JSON: \(jsonString)")

            let decoder = JSONDecoder()
            do {
                let decodedResponse = try decoder.decode(Response.self, from: data)
                DispatchQueue.main.async {
                    self.parks = decodedResponse.results
                }
            } catch {
                print("Error: Couldn't decode response - \(error.localizedDescription)")
            }
        }.resume()
    }

}



struct ParkDetailView: View {
    let park: Park

    var body: some View {
        Text(park.name)
    }
}

struct Response: Codable {
    let results: [Park]
    let status: String
   
}

struct Park: Codable, Identifiable {
    let id: String
    let name: String
    let geometry: Geometry
   

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: geometry.location.lat, longitude: geometry.location.lng)
    }
}


struct NearbyParksView_Previews: PreviewProvider {
    static var previews: some View {
        NearbyParksView()
    }
}
