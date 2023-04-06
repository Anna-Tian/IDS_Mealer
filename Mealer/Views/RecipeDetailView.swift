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
        NavigationView() {
            VStack() {
                
                AsyncImageView(urlString: $recipeManager.currentImageURLString)
                    .cornerRadius(40)
                if let name = recipeManager.currentRecipe?.name {
                    Text(name)
                }
                Spacer()
            }
            .edgesIgnoringSafeArea(.vertical)
            .onAppear {
                recipeManager.detailRecipeRequest(recipeId: "52913")
            }
        }
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView()
    }
}
