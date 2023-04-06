//
//  Recipe.swift
//  Mealer
//
//  Created by Na Tian on 6/4/2023.
//

import Foundation

struct RecipeData: Decodable {
    let meals: [Recipe]
}

struct Recipe: Decodable {
    let id: String
    let name: String
    let imageUrlString: String
    let ingredients: [RecipeIngredient]
    let instructions: String
}

extension Recipe {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let recipeDictionary = try container.decode([String: String?].self)
        
        var index = 1
        var ingredients: [RecipeIngredient] = []
        
        while let ingredient = recipeDictionary["strIngredient\(index)"] as? String,
              let measure = recipeDictionary["strMeasure\(index)"] as? String,
              !ingredient.isEmpty,
              !measure.isEmpty {
            ingredients.append(.init(name: ingredient, measure: measure))
            index += 1
        }
        id = recipeDictionary["idMeal"] as? String ?? ""
        name = recipeDictionary["strMeal"] as? String ?? ""
        imageUrlString = recipeDictionary["strMealThumb"] as? String ?? ""
        self.ingredients = ingredients
        instructions = recipeDictionary["strInstructions"] as? String ?? ""
    }
}

struct RecipeIngredient: Decodable {
    let name: String
    let measure: String
}
