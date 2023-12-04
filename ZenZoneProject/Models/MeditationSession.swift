//
//  MeditationSession.swift
//  ZenZoneProject
//
//  Created by Fernanda Battig on 2023-11-25.
//

struct MeditationSession: Identifiable, Codable {
    var id: String
    var title: String
    var description: String
    var duration: Double // Duration in minutes
    var category: String
    var audioFileName: String
    var imageName: String
}

struct Response: Codable {
    let results: [Place]
}

struct Place: Codable {
    let id: String
    let name: String
    let geometry: Geometry
}

struct Geometry: Codable {
    let location: Location
}

struct Location: Codable {
    let lat: Double
    let lng: Double
}

