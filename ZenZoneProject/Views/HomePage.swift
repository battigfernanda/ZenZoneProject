//
//  HomePage.swift
//  ZenZoneProject
//
//  Created by Fernanda Battig on 2023-11-25.
//

import SwiftUI

struct HomePageView: View {
    @EnvironmentObject var user: FireDBHelper

    var body: some View {
        
            NavigationView {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading) {
                        // Header with Welcome Message
                        HeaderView()
                        
                        // Meditation Session List View
                        SectionLink(title: "Meditation Sessions", destination: MeditationSessionListView(), buttonText: "View All Meditation Sessions")
                        
                        // Wellness Tracking
                        SectionLink(title: "Your Wellness Stats", destination: WellnessTrackingView(), buttonText: "Track Your Wellness")
                        
                        // Community Spotlight
                        SectionLink(title: "Community Spotlight", destination: CommunitySpotlightView(), buttonText: "Join the Community")
                        
                        // Explore Serene Spots

                        SectionLink(title: "Explore Serene Spots", destination: NearbyParksView(), buttonText: "Explore Serene Spots")

                    }
                    .padding(.horizontal)
                    
                    
                }
                .navigationBarTitle("ZenZone", displayMode: .inline)
                .navigationBarItems(trailing: ProfileButton())
                //            .navigationBarItems(trailing: SignOutButton())
                
                
                
            }
            
            
        
    }
    
}

// Reusable Section Link View
struct SectionLink<Destination: View>: View {
    @EnvironmentObject var user: FireDBHelper

    var title: String
    var destination: Destination
    var buttonText: String


    var body: some View {
        SectionView(title: title) {
            NavigationLink(destination: destination) {
                HStack {
                    Text(buttonText)
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
        
    }
    
}
struct ProfileButton: View {
    @EnvironmentObject var user: FireDBHelper

    var body: some View {
        NavigationLink(destination: ProfilePage()) {
                    Image(systemName: "person.crop.circle")
                        .imageScale(.large)
                        .foregroundColor(.blue)
                }
            }
    
    }


//struct SignOutButton: View {
//    var body: some View {
//        Button(
//            action: {
//
//        }) {
//            Image(systemName: "door.right.hand.open")
//                .imageScale(.large)
//                .foregroundColor(.blue)
//        }
//    }
//}

struct HeaderView: View {
    @EnvironmentObject var user: FireDBHelper

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
    @EnvironmentObject var user: FireDBHelper

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
    @EnvironmentObject var user: FireDBHelper

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

// Dummy views to view preview
struct WellnessTrackingView: View {
    @EnvironmentObject var user: FireDBHelper

    var body: some View {
        Text("Wellness Tracking View")
    }
}

struct CommunitySpotlightView: View {
    @EnvironmentObject var user: FireDBHelper

    var body: some View {
        Text("Community Spotlight View")
    }
}

struct ExploreSpotsView: View {
    @EnvironmentObject var user: FireDBHelper

    var body: some View {
        Text("Explore Spots View")
    }
}

//struct HomePageView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomePageView()
//    }
//}
