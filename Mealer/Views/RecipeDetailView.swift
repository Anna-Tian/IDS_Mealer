//
//  RecipeDetailView.swift
//  Mealer
//
//  Created by Na Tian on 7/4/2023.
//

import SwiftUI

struct RecipeDetailView: View {
    @StateObject private var recipeManager = RecipeManager()
    var body: some View {
        VStack {
            if let name = recipeManager.currentRecipe?.name {
                Text(name)
            }
        }
        .onAppear {
            recipeManager.detailRecipeRequest(recipeId: "52772")
        }
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView()
    }
}
