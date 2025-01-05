import SwiftUI

struct Drill: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let details: String
    let image: String
    let calories: Int
    let time: Int
}

// MARK: - Drill Detail View
struct DrillDetailView: View {
    let drill: Drill
    
    var body: some View {
        VStack (alignment: .leading, spacing: 8){
            HStack {
                Text("Calories Burned:")
                    .bold()
                Spacer()
                Text("\(drill.calories) calories")
            }
            HStack {
                Text("Time:")
                    .bold()
                Spacer()
                Text("\(drill.time) minutes")
            }
            HStack {
                Text("Description:")
                    .bold()
                Spacer()
                Text("\(drill.description)")
            }

    
            Text(drill.details)
                .font(.body)
                .padding()
            

            Image(drill.image)
                .resizable() // Makes the image resizable
                .scaledToFit() // Scales it to fit within the frame
 
                
            Spacer()
        }
        .navigationTitle(drill.name)
        .padding()
    }
}

struct ContentView: View {
    let drills = [
        Drill(name: "Passing Drill", description: "Improve your short and long passes with this drill."
             , details: "Passing is a fundamental skill in soccer. \nThis drill will help you improve your short and long passes. \nFocus on accuracy and power. \nUse both feet to pass the ball. \nKeep your body over the ball and follow through with your kicking foot.",
              image: "zigzag_layout",
              calories: 100,
                time: 10
             ),
        Drill(name: "Shooting Drill", description: "Enhance accuracy and power with focused shooting practice.",
             details: "Shooting is a key skill for forwards and midfielders. This drill will help you improve your accuracy and power. Focus on technique and placement. Use both feet to shoot",
              image: "hollow_square_layout",
              calories: 100,
                time: 10
             ),
        Drill(name: "Dribbling Drill", description: "Work on close ball control and quick direction changes.",
             details: "Dribbling is a key skill for attacking players. This drill will help you improve your close ball control and quick direction changes. Focus on keeping the ball close to your feet and using both feet to dribble. Use cones to practice dribbling around obstacles.",
              image: "diagonal_layout",
              calories: 100,
                time: 10),
        Drill(name: "Defensive Drill", description: "Learn positioning and tackle timing.",
              details:  "Defending is a key skill for defenders and midfielders. This drill will help you improve your positioning and tackle timing. Focus on staying goal-side of the attacker and jockeying to force them wide. Time your tackles carefully and use your body to block shots.",
              image: "row_layout",
              calories: 100,
                time: 10),
        Drill(name: "Goalkeeping Drill", description: "Focus on saves, positioning, and distribution.",
              details:  "Goalkeeping is a specialized position that requires unique skills. This drill will help you improve your saves, positioning, and distribution. Focus on getting your body behind the ball and using your hands to make saves. Position yourself well to cut down angles and make it difficult for attackers to score. Work on distributing the ball quickly and accurately to start counterattacks.",
              image: "zigzag_layout",
              calories: 100,
                time: 10
             )
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                
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
            .navigationTitle("⚽️ Drills")
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    NavigationLink(destination: HomeView()) {
                        Label("Home", systemImage: "house")
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: TeamsView()) {
                        Label("Teams", systemImage: "soccerball")
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
            Text("Welcome to the Soccer Drill App!")
                .font(.title)
                .padding()
            Spacer()
            
            // show images of soccer drills
            Image("image")
                .resizable() // Makes the image resizable
                .scaledToFit() // Scales it to fit within the frame
            
            
        }
        .navigationTitle("⚽️ Home ")
    }
}

// Dummy Teams View
struct TeamsView: View {
    let tips = [
        "Warm-Up is Key: Spend at least 10 minutes warming up to prevent injuries. Include dynamic stretches and light jogging.",
        "Focus on Technique: Prioritize proper form over speed. For shooting drills, practice placement over power.",
        "Use Both Feet: Alternate between your dominant and non-dominant foot to improve versatility.",
        "Set Clear Goals: Define objectives for each drill, such as improving accuracy or speed. Track your progress over time.",
        "Small Steps for Big Results: Break complex drills into smaller parts to master the fundamentals. Gradually increase difficulty as skills improve.",
        "Dribble with Control: Keep the ball close to your feet during dribbling drills. Use cones or markers to simulate defenders.",
        "Short and Intense Sessions: Focused 20–30 minute sessions are better than long, unfocused practices.",
        "Work on Passing Precision: Practice one-touch and two-touch passing drills with a partner or rebounder. Aim for consistent accuracy over varying distances.",
        "Master Ball Control: Include juggling and trapping drills to improve touch. Practice receiving passes under pressure.",
        "Improve Shooting Accuracy: Use targets (cones, corners) for shooting drills. Focus on hitting specific parts of the goal during each attempt.",
        "Communication is Key: Practice drills that require coordination with teammates. Call out movements or passes during team drills.",
        "Cool Down and Recover: Spend 5–10 minutes cooling down with static stretches. Hydrate and rest to let your muscles recover.",
        "Simulate Match Scenarios: Include situational drills like penalty kicks, corner setups, or breakaways.",
        "Stay Consistent: Regular practice is essential for long-term improvement. Stick to a schedule and revisit challenging drills.",
        "Make it Fun!: Rotate drills to keep practice engaging and exciting. Challenge yourself with fun variations or friendly competitions."
    ]
    var body: some View {
        
        NavigationView {
            List {
                ForEach(tips.indices, id: \.self) { index in
                    HStack(alignment: .top) {
                        Image(systemName: "soccerball")
                            .foregroundColor(.blue)
                        Text(tips[index])
                            .font(.body)
                            .padding(.leading, 5)
                    }
                    .padding(.vertical, 5)
                }
            }
            .navigationTitle("Soccer Drill Tips")
        }

          
        }
    
}

// Dummy Players View
struct PlayersView: View {
    var body: some View {
        VStack {
   

            Image("zigzag_layout")
                .resizable() // Makes the image resizable
                .scaledToFit()
            Image("column_layout")
                .resizable() // Makes the image resizable
                .scaledToFit()
            Image("row_layout")
                .resizable() // Makes the image resizable
                .scaledToFit()// Scales it to fit within the frame
                
        }
        .navigationTitle("Layouts")
    }
}


#Preview {
    // The view to preview.
    ContentView()
}
