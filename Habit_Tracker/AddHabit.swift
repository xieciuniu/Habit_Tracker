//
//  AddHabit.swift
//  Habit_Tracker
//
//  Created by Hubert Wojtowicz on 12/07/2023.
//

import Foundation

struct Habit:Identifiable, Codable, Equatable {
    static func == (lhs: Habit, rhs: Habit) -> Bool {
        return lhs.name == rhs.name && lhs.id == rhs.id
    }
    
    
    var id = UUID()
    let name: String
    let opis: String
    var num: Int = 0
    var special: [SpecialDes] = [SpecialDes()]
    
}

struct SpecialDes: Codable, Identifiable {
    var id = UUID()
    var data: String?
    var mark: String?
}
