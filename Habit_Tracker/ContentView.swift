//
//  ContentView.swift
//  Habit_Tracker
//
//  Created by Hubert Wojtowicz on 12/07/2023.
//

import SwiftUI

class Activity: ObservableObject {
    @Published var things = [Habit]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(things) {
                UserDefaults.standard.set(encoded, forKey: "Things")
            }
        }
    }
    init() {
        if let savedHabit = UserDefaults.standard.data(forKey: "Things") {
            if let decodedItems = try? JSONDecoder().decode([Habit].self, from: savedHabit) {
                things = decodedItems
                return
            }
        }
        
        things = []
    }
}

struct ContentView: View {
    @State private var addingHabit = false
    @StateObject var activity = Activity()
    
    var body: some View {
        NavigationView{
            List{
                ForEach(activity.things) {thing in
                    NavigationLink{
                        Details(activity: thing, activit: activity)
                            .navigationTitle(thing.name)
                    } label: {
                        HStack{
                            Text(thing.name)
                            Spacer()
                            Text(Image(systemName: "\(thing.num).circle"))
                        }
                    }
                    .buttonStyle(.automatic)
                }
                .onDelete(perform: removeHabit)
            }
            .navigationTitle("Habit Tracker")
            .toolbar {
                Button ("Add Hobbit"){
                    addingHabit = true
                }
            }
            
            .sheet(isPresented: $addingHabit){
                NewHabit(activity: activity)
            }
        }
    }
    
    func removeHabit(at offsets: IndexSet) {
        activity.things.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
