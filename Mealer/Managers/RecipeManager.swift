//
//  RecipeManager.swift
//  Mealer
//
//  Created by Na Tian on 7/4/2023.
//

import Foundation
import Combine

struct mealNetwork {
    
    static let apiKey = "v2/9973533"
    static let randomMealPath = "https://www.themealdb.com/api/json/"
    static let randomMealSecondPath = "/randomselection.php"
    static let mealCategoryUrl = "https://www.themealdb.com/api/json/v1/1/categories.php"
    static let mealsInCategoryPath = "https://www.themealdb.com/api/json/v1/1/filter.php?"
    static let detailMealPath = "https://www.themealdb.com/api/json/v1/1/lookup.php?"
    static let searchIngredientPath = "https://www.themealdb.com/api/json/"
    static let searchIngredientSecondPath = "/filter.php?"
}

final class RecipeManager: ObservableObject {
    @Published var currentRecipe: Recipe?
    private var cancellable: AnyCancellable?
    
    func detailRecipeRequest(recipeId: String) {
        let url = mealNetwork.detailMealPath + "i=\(recipeId)"
        cancellable = URLSession.shared.dataTaskPublisher(for: URL(string: url)!)
            .receive(on: DispatchQueue.main)
            .sink { _ in } receiveValue: { data, _ in
                if let recipeData = try? JSONDecoder().decode(RecipeData.self, from: data) {
                    self.currentRecipe = recipeData.meals.first
                }
            }
    }
}
