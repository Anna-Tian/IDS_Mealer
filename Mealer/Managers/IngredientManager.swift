//
//  IngredientManager.swift
//  Mealer
//
//  Created by Na Tian on 7/4/2023.
//

import Foundation
import Combine

struct ingredientNetwork {
    static let apiKey = "v2/9973533"
    static let ingredientImagePath = "https://www.themealdb.com/images/ingredients/"
    static let getAllIngredientsPath = "https://www.themealdb.com/api/json/v1/1/list.php?i=list"
}

final class IngredientManager: ObservableObject {
    @Published var ingredients: [IngredientLibrary]?
    private var cancellable: AnyCancellable?
    func allIngredientsRequest() {
        let url = ingredientNetwork.getAllIngredientsPath
        cancellable = URLSession.shared.dataTaskPublisher(for: URL(string: url)!)
            .receive(on: DispatchQueue.main)
            .sink { _ in } receiveValue: { data, _ in
                if let ingredientsData = try? JSONDecoder().decode(IngredientData.self, from: data) {
                    self.ingredients = ingredientsData.meals.filter { !$0.category.isEmpty }
                }
            }
    }
    
}

