//
//  NewHabit.swift
//  Habit_Tracker
//
//  Created by Hubert Wojtowicz on 12/07/2023.
//

import SwiftUI

struct NewHabit: View {
    @State private var habit = ""
    @State private var description = ""
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var activity: Activity
    
    var body: some View {
        NavigationView{
            VStack{
                Form{
                    TextField("Activity", text: $habit)
                    TextField("Description", text: $description)
                }
            }
            .navigationTitle("Add new habit")
            .toolbar {
                Button("Save"){
                    let habit = Habit(name: habit, opis: description)
                    activity.things.append(habit)
                    dismiss()
                }
            }
        }
    }
}

struct NewHabit_Previews: PreviewProvider {
    static var previews: some View {
        NewHabit(activity: Activity())
    }
}
