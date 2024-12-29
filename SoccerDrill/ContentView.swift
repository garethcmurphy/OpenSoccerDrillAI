import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("⚽️ Soccer Drill 🏟️")
                    .font(.largeTitle)
                    .padding()
                
                Spacer()
            }
            .navigationTitle("Home")
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    NavigationLink(destination: HomeView()) {
                        Label("Home", systemImage: "house")
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: TeamsView()) {
                        Label("Teams", systemImage: "person.3")
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: PlayersView()) {
                        Label("Players", systemImage: "sportscourt")
                    }
                }
            }
        }
    }
}

// Dummy Home View
struct HomeView: View {
    var body: some View {
        VStack {
            Text("⚽️Home View")
                .font(.largeTitle)
                .padding()
            Spacer()
            
        }
        .navigationTitle("⚽️ Home ")
    }
}

// Dummy Teams View
struct TeamsView: View {
    var body: some View {
        VStack {
            Text("Teams View")
                .font(.largeTitle)
                .padding()
            Spacer()
        }
        .navigationTitle("Teams")
    }
}

// Dummy Players View
struct PlayersView: View {
    var body: some View {
        VStack {
            Text("Players View")
                .font(.largeTitle)
                .padding()
            Spacer()
        }
        .navigationTitle("Players")
    }
}


#Preview {
    // The view to preview.
    ContentView()
}
