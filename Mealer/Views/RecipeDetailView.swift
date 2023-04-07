//
//  RecipeDetailView.swift
//  Mealer
//
//  Created by Na Tian on 7/4/2023.
//

import SwiftUI

struct RecipeDetailView: View {
    @StateObject private var recipeManager = RecipeManager()
    @State var tabIndex = 1
    var body: some View {
        NavigationView() {
            VStack() {
                if let recipeImage = recipeManager.currentImageURLString {
                    AsyncImageView(urlString: recipeImage)
                        .cornerRadius(40)
                }
                VStack(alignment: .leading, spacing: 15) {
                    if let name = recipeManager.currentRecipe?.name {
                        Text(name)
                            .font(.title2)
                    }
                    HStack {
                        HStack {
                            Image(systemName: "timer")
                            if let duration = recipeManager.currentRecipe?.duration {
                                Text("\(duration)")
                            }
                        }
                        Spacer()
                        HStack(spacing: -15) {
                            Image("Avatar/baby")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .clipShape(Circle())
                            Image("Avatar/child")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .clipShape(Circle())
                        }
                        Spacer()
                        HStack {
                            Image("Icons/cookware")
                                .resizable()
                                .frame(width: 35, height: 35)
                            Text("Cookware")
                        }
                    }
                    VStack(spacing: 15) {
                        CustomTabBar(tabIndex: $tabIndex)
                        switch tabIndex {
                        case 1:
                            // Instructions View
                            ScrollView {
                                VStack {
                                    if let instructions = recipeManager.currentRecipe?.instructions {
                                        let instructionsArray = instructions.components(separatedBy: ". ")
                                        ForEach(0..<instructionsArray.count, id: \.self) { index in
                                            HStack(alignment: .top) {
                                                Text("\(index + 1) ")
                                                    .font(.title2)
                                                HStack {
                                                    Text(instructionsArray[index])
                                                    Spacer()
                                                }
                                            }
                                        }
                                        .padding(.horizontal)
                                        .padding(.vertical, 10)
                                        .background(
                                            RoundedRectangle(cornerRadius: 15)
                                                .fill(Color.gray.opacity(0.2))
                                        )
                                    }
                                }
                            }
                        case 2:
                            NutritionView()
                        default:
                            // Ingredients View
                            ScrollView {
                                VStack(spacing: 15) {
                                    if let ingredients = recipeManager.currentRecipe?.ingredients {
                                        ForEach(ingredients, id:\.self) { ingredient in
                                            HStack {
                                                HStack {
                                                    if let imageURL = ingredient.image {
                                                        AsyncImageView(urlString: imageURL)
                                                            .frame(width: 50, height: 50)
                                                    }
                                                    Text(ingredient.name)
                                                }
                                                Spacer()
                                                Text(ingredient.measure)
                                            }
                                        }
                                        .padding(.horizontal)
                                        .padding(.vertical, 10)
                                        .background(
                                            RoundedRectangle(cornerRadius: 15)
                                                .fill(Color.gray.opacity(0.2))
                                        )
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)
                Spacer()
            }
            .edgesIgnoringSafeArea(.vertical)
            .onAppear {
                recipeManager.detailRecipeRequest(recipeId: "52913")
//                recipeManager.detailRecipeRequest(recipeId: "52862")
            }
        }
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView()
    }
}

struct CustomTabBar: View {
    @Binding var tabIndex: Int
    var body: some View {
        HStack {
            TabBarButton(text: "Ingredients", isSelected: .constant(tabIndex == 0))
                .onTapGesture { onButtonTapped(index: 0) }
            TabBarButton(text: "Instructions", isSelected: .constant(tabIndex == 1))
                .onTapGesture { onButtonTapped(index: 1) }
            TabBarButton(text: "Nutrition", isSelected: .constant(tabIndex == 2))
                .onTapGesture { onButtonTapped(index: 2) }
        }
    }
    
    private func onButtonTapped(index: Int) {
        withAnimation { tabIndex = index}
    }
}

struct TabBarButton: View {
    let text: String
    @Binding var isSelected: Bool
    var body: some View {
        Text(text)
            .fontWeight(isSelected ? .heavy : .regular)
            .foregroundColor(isSelected ? .white : .black)
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
            .background(
                isSelected ?
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.accentColor) :
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.gray.opacity(0.2))
            )
    }
}

struct NutritionView: View{
    var body: some View{
        ZStack{
            Rectangle()
                .foregroundColor(.yellow)
            Text("NutritionView")
        }
    }
}
