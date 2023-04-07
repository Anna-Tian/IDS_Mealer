//
//  RecipeManager.swift
//  Mealer
//
//  Created by Na Tian on 7/4/2023.
//

import Foundation
import Combine

struct recipeNetwork {
    static let apiKey = "v2/9973533"
    static let randomRecipePath = "https://www.themealdb.com/api/json/"
    static let randomRecipeSecondPath = "/randomselection.php"
    static let recipeCategoryUrl = "https://www.themealdb.com/api/json/v1/1/categories.php"
    static let recipesInCategoryPath = "https://www.themealdb.com/api/json/v1/1/filter.php?"
    static let detailRecipePath = "https://www.themealdb.com/api/json/v1/1/lookup.php?"
    static let searchIngredientPath = "https://www.themealdb.com/api/json/"
    static let searchIngredientSecondPath = "/filter.php?"
}

final class RecipeManager: ObservableObject {
    @Published var currentRecipe: Recipe?
    @Published var currentImageURLString: String?
    private var cancellable: AnyCancellable?
    
    func detailRecipeRequest(recipeId: String) {
        let url = recipeNetwork.detailRecipePath + "i=\(recipeId)"
        cancellable = URLSession.shared.dataTaskPublisher(for: URL(string: url)!)
            .receive(on: DispatchQueue.main)
            .sink { _ in } receiveValue: { data, _ in
                if let recipeData = try? JSONDecoder().decode(RecipeData.self, from: data) {
                    self.currentRecipe = recipeData.meals.first
                    self.currentImageURLString = recipeData.meals.first?.imageUrlString
                }
            }
    }
}
