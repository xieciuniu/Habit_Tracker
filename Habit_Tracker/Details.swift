//
//  Details.swift
//  Habit_Tracker
//
//  Created by Hubert Wojtowicz on 12/07/2023.
//

import SwiftUI

struct Details: View {
    let activity: Habit
    @StateObject var activit: Activity
    @State private var mark: Int = 5
    @State private var added = false
    let data = Date.now.formatted(date: .long, time: .omitted)
    
    var body: some View {

        //NavigationView{
            VStack{
                Form {
                    
                    Section("Description"){
                        Text(activity.opis)
                    }
                    
                    Section("Number of activity"){
                        Text("\(activity.num)")
                    }
                    
                    if added == false {
                        Section("Mark your activity"){
                            Picker("Mark", selection: $mark){
                                ForEach(0..<11){
                                    Text("\($0)")
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                    }
                    
                    Section("Recent activity"){
                        ForEach(activity.special){special in
                            if special.mark != nil {
                                HStack{
                                    Text(special.data ?? "This shouldn't be seen")
                                    Spacer()
                                    Text(special.mark ?? "It's awesome how much I learnt with this one")
                                }
                            }
                        }
                    }
                    
                }
                
                
                
                if added == false {
                    Button("Add"){
                        added = true
                        
                        let special = SpecialDes(data: "\(data)", mark: "\(mark)")
                        
                        if let i = activit.things.firstIndex(of: activity) {
                            activit.things[i].num += 1
                            activit.things[i].special.append(special)
                        }

                    }
                }
            }
        //}
    }
}

struct Details_Previews: PreviewProvider {
    static let activytys = Habit.init(name: "Dance", opis: "pole")
    
    static var previews: some View {
        Details(activity: activytys, activit: Activity())
    }
}
