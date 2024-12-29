import SwiftUI

struct Drill: Identifiable {
    let id = UUID()
    let name: String
    let description: String
}

// MARK: - Drill Detail View
struct DrillDetailView: View {
    let drill: Drill
    
    var body: some View {
        VStack {
            Text(drill.name)
                .font(.largeTitle)
                .padding()
            Text(drill.description)
                .font(.body)
                .padding()
            Spacer()
        }
        .navigationTitle(drill.name)
    }
}

struct ContentView: View {
    let drills = [
        Drill(name: "Passing Drill", description: "Improve your short and long passes with this drill."),
        Drill(name: "Shooting Drill", description: "Enhance accuracy and power with focused shooting practice."),
        Drill(name: "Dribbling Drill", description: "Work on close ball control and quick direction changes."),
        Drill(name: "Defensive Drill", description: "Learn positioning and tackle timing."),
        Drill(name: "Goalkeeping Drill", description: "Focus on saves, positioning, and distribution.")
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                Text("⚽️ Soccer Drill 🏟️")
                    .font(.largeTitle)
                    .padding()
                
                Spacer()
                List(drills) { drill in
                    NavigationLink(destination: DrillDetailView(drill: drill)) {
                        VStack(alignment: .leading) {
                            Text(drill.name)
                                .font(.headline)
                            Text(drill.description)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .lineLimit(2)
                        }
                    }
                }
            }
            .navigationTitle("⚽️ Home")
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
