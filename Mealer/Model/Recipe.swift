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

struct Recipe: Decodable, Hashable {
    let id: String
    let name: String
    let imageUrlString: String
    let ingredients: [RecipeIngredient]
    let instructions: String
    var duration: String
    var nutrition: Nutrition
}

extension Recipe {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let recipeDictionary = try container.decode([String: String?].self)
        
        let randomDuration: Int = Int.random(in: 6...36) * 300 // minimum 0.5h, maximum 3h, changed by 5 minutes
        let durationH = randomDuration / 3600
        let durationM = (randomDuration - (3600 * durationH)) / 60
        
        let randomProtein: Int = Int.random(in: 15...30)
        let randomCarbon: Int = Int.random(in: 30...70)
        let randomFat: Int = Int.random(in: 10...30)
        
        var index = 1
        var ingredients: [RecipeIngredient] = []
        
        while let ingredient = recipeDictionary["strIngredient\(index)"] as? String,
              let measure = recipeDictionary["strMeasure\(index)"] as? String,
              !ingredient.isEmpty,
              !measure.isEmpty {
            
            let imageName = ingredient.replacingOccurrences(of: " ", with: "%20") + ".png"
            
            ingredients.append(.init(name: ingredient, measure: measure, image: ingredientNetwork.ingredientImagePath + imageName))
            index += 1
        }
        id = recipeDictionary["idMeal"] as? String ?? ""
        name = recipeDictionary["strMeal"] as? String ?? ""
        imageUrlString = recipeDictionary["strMealThumb"] as? String ?? ""
        self.ingredients = ingredients
        instructions = recipeDictionary["strInstructions"] as? String ?? ""
        duration = durationH > 0 ? durationM == 0 ? "\(durationH)h" : "\(durationH)h \(durationM)m" : "\(durationM)m"
        nutrition = Nutrition(name: name, protein: randomProtein, carbon: randomCarbon, fat: randomFat)
    }
}

struct RecipeIngredient: Decodable, Hashable {
    let name: String
    let measure: String
    let image: String
}
