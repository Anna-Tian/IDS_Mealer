//
//  IngredientDetailView.swift
//  Mealer
//
//  Created by Na Tian on 3/4/2023.
//

import SwiftUI

struct IngredientDetailView: View {
    var ingredient: Ingredient
    var body: some View {
        NavigationView {
            Text("Details for \(ingredient.name)")
                .navigationTitle(ingredient.name)
        }
    }
}

struct IngredientDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sample = Ingredient(name: "Spinach", expire: 3, weight: "250 g", image: "Ingredients/Spinach", isSelected: false, isNew: true, category: "Vegetable")
        IngredientDetailView(ingredient: sample)
    }
}
