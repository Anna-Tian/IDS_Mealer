//
//  Ingredient.swift
//  Mealer
//
//  Created by Na Tian on 6/4/2023.
//

import Foundation

struct Ingredient: Identifiable {
    let id = UUID()
    var name: String
    var expire: Int
    var weight: String
    var image: String
    var isSelected: Bool
    var isNew: Bool
    var category: String
    var nutrition: Nutrition
    var createdDate: Date
}

enum Sort {
    case expireDate, category
}

struct Category: Identifiable {
    let id = UUID()
    let name: String
    var isExpanding: Bool
}
