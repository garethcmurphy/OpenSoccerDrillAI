import SwiftUI

struct Drill: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let details: String
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
            Text(drill.details)
                .font(.body)
                .padding()
            Spacer()
        }
        .navigationTitle(drill.name)
    }
}

struct ContentView: View {
    let drills = [
        Drill(name: "Passing Drill", description: "Improve your short and long passes with this drill."
             , details: "Passing is a fundamental skill in soccer. This drill will help you improve your short and long passes. Focus on accuracy and power. Use both feet to pass the ball. Keep your body over the ball and follow through with your kicking foot."),
        Drill(name: "Shooting Drill", description: "Enhance accuracy and power with focused shooting practice.",
             details: "Shooting is a key skill for forwards and midfielders. This drill will help you improve your accuracy and power. Focus on technique and placement. Use both feet to shoot"),
        Drill(name: "Dribbling Drill", description: "Work on close ball control and quick direction changes.",
             details: "Dribbling is a key skill for attacking players. This drill will help you improve your close ball control and quick direction changes. Focus on keeping the ball close to your feet and using both feet to dribble. Use cones to practice dribbling around obstacles."),
        Drill(name: "Defensive Drill", description: "Learn positioning and tackle timing.",
              details:  "Defending is a key skill for defenders and midfielders. This drill will help you improve your positioning and tackle timing. Focus on staying goal-side of the attacker and jockeying to force them wide. Time your tackles carefully and use your body to block shots."),
        Drill(name: "Goalkeeping Drill", description: "Focus on saves, positioning, and distribution.",
              details:  "Goalkeeping is a specialized position that requires unique skills. This drill will help you improve your saves, positioning, and distribution. Focus on getting your body behind the ball and using your hands to make saves. Position yourself well to cut down angles and make it difficult for attackers to score. Work on distributing the ball quickly and accurately to start counterattacks.")
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                Text("⚽️ Drills 🏟️")
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
            .navigationTitle("⚽️ Drill")
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
                        Label("Layouts", systemImage: "sportscourt")
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
            // add a gallery of images of soccer drills
            
            
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
        .navigationTitle("Advice")
    }
}

// Dummy Players View
struct PlayersView: View {
    var body: some View {
        VStack {
            Text("Layouts")
                .font(.largeTitle)
                .padding()
            Spacer()
        }
        .navigationTitle("Layouts")
    }
}


#Preview {
    // The view to preview.
    ContentView()
}
