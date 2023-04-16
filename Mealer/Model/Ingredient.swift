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

var categories: [Category] = [
    Category(name: "Vegetable", isExpanding: true),
    Category(name: "Bean", isExpanding: true),
    Category(name: "Bread", isExpanding: true),
    Category(name: "Cereal", isExpanding: true),
    Category(name: "Cheese", isExpanding: true),
    Category(name: "Confectionery", isExpanding: true),
    Category(name: "Curd", isExpanding: true),
    Category(name: "Dairy", isExpanding: true),
    Category(name: "Dressing", isExpanding: true),
    Category(name: "Drink", isExpanding: true),
    Category(name: "Fat", isExpanding: true),
    Category(name: "Fish", isExpanding: true),
    Category(name: "Fruit", isExpanding: true),
    Category(name: "Grain", isExpanding: true),
    Category(name: "Juice", isExpanding: true),
    Category(name: "Liqueur", isExpanding: true),
    Category(name: "Liquid", isExpanding: true),
    Category(name: "Meat", isExpanding: true),
    Category(name: "Pantry", isExpanding: true),
    Category(name: "Pastry", isExpanding: true),
    Category(name: "Preserve", isExpanding: true),
    Category(name: "Rice", isExpanding: true),
    Category(name: "Root Vegetable", isExpanding: true),
    Category(name: "Sauce", isExpanding: true),
    Category(name: "Seafood", isExpanding: true),
    Category(name: "Seasoning", isExpanding: true),
    Category(name: "Sedge", isExpanding: true),
    Category(name: "Side", isExpanding: true),
    Category(name: "Spice", isExpanding: true),
    Category(name: "Spirit", isExpanding: true),
    Category(name: "Stock", isExpanding: true),
    Category(name: "Sugar", isExpanding: true),
    Category(name: "Vinegar", isExpanding: true),
    Category(name: "Wine", isExpanding: true)
]

var quantityUnits: [String] = ["kg", "g","L", "ml", "bundle", "bag", "can", "pc", "cup", "bottle"]

struct IngredientData: Decodable {
    let meals: [IngredientLibrary]
}

struct IngredientLibrary: Decodable, Hashable {
    let name: String
    let imageUrlString: String
    let category: String
}

extension IngredientLibrary {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let ingredientDictionary = try container.decode([String: String?].self)
        
        name = ingredientDictionary["strIngredient"] as? String ?? ""
        let imageName = name.replacingOccurrences(of: " ", with: "%20") + ".png"
        imageUrlString = ingredientNetwork.ingredientImagePath + imageName
        category = ingredientDictionary["strType"] as? String ?? ""
    }
}
