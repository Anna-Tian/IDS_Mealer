//
//  Nutrition.swift
//  Mealer
//
//  Created by Na Tian on 7/4/2023.
//

import Foundation

struct Nutrition: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var protein: Int
    var carbon: Int
    var fat: Int
}
