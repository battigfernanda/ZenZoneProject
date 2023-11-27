//
//  HomePage.swift
//  ZenZoneProject
//
//  Created by Fernanda Battig on 2023-11-25.
//


import SwiftUI

struct HomePageView: View {
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    // Header with Welcome Message
                    HeaderView()
                    
                    // Link to Meditation Session List View
                    SectionView(title: "Meditation Sessions") {
                        NavigationLink(destination: MeditationSessionListView()) {
                            HStack {
                                Text("View All Meditation Sessions")
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                                Spacer()
                                Image(systemName: "arrow.right.circle")
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        }
                    }

                    // Wellness Tracking
                    SectionView(title: "Your Wellness Stats") {
                        WellnessTrackingCard()
                    }

                    // Community Spotlight
                    SectionView(title: "Community Spotlight") {
                        CommunitySpotlightCard()
                    }

                    // Explore Serene Spots
                    SectionView(title: "Explore Serene Spots") {
                        ExploreSpotsCard()
                    }
                }
                .padding(.horizontal)
            }
            .navigationBarTitle("ZenZone", displayMode: .inline)
            .navigationBarItems(trailing: ProfileButton())
        }
    }
}

struct ProfileButton: View {
    var body: some View {
        Button(action: {
            // action for profile button
        }) {
            Image(systemName: "person.crop.circle")
                .imageScale(.large)
                .foregroundColor(.blue)
        }
    }
}

struct HeaderView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Welcome to ZenZone")
                .font(.largeTitle)
                .fontWeight(.bold)
            Text("Find your inner peace and connect with others.")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding(.top)
    }
}

struct SectionView<Content: View>: View {
    let title: String
    let content: Content

    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.vertical)
            content
        }
    }
}

struct MeditationSessionCard: View {
    var body: some View {
        VStack {
            Image("meditation")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .cornerRadius(10)
            Text("Session Title")
                .fontWeight(.medium)
        }
        .frame(width: 150)
        .padding(.bottom, 10)
    }
}

struct WellnessTrackingCard: View {
    var body: some View {
        // Add content for Wellness Tracking
        Text("Wellness Tracking Content")
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
    }
}

struct CommunitySpotlightCard: View {
    var body: some View {
        // Add content for Community Spotlight
        Text("Community Spotlight Content")
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
    }
}

struct ExploreSpotsCard: View {
    var body: some View {
        // Add content for Explore Spots
        Text("Explore Spots Content")
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}



