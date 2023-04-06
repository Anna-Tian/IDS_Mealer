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
            NavigationLink(destination: RecipeDetailView(), label: {
                if let name = recipeManager.currentRecipe?.name {
                    Text(name)
                }
            })
        }
        .onAppear {
            recipeManager.detailRecipeRequest(recipeId: "52913")
        }
    }
}

struct ViewRecipeList_Previews: PreviewProvider {
    static var previews: some View {
        ViewRecipeList()
    }
}
