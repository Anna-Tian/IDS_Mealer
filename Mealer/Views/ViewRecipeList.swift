//
//  ViewRecipeList.swift
//  Mealer
//
//  Created by Na Tian on 27/3/2023.
//

import SwiftUI

struct ViewRecipeList: View {
    @StateObject private var recipeManager = RecipeManager()
    var body: some View {
        VStack {
            Text("Recipe List")
            if let recipes = recipeManager.recipes {
                List(recipes, id:\.self) { recipe in
                    NavigationLink(destination: RecipeDetailView(recipe: recipe), label: {
                        Text(recipe.name)
                    })
                }
            }
        }
        .onAppear {
            recipeManager.randomRecipeRequest()
        }
    }
}

struct ViewRecipeList_Previews: PreviewProvider {
    static var previews: some View {
        ViewRecipeList()
    }
}
