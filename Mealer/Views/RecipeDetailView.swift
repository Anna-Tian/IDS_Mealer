//
//  RecipeDetailView.swift
//  Mealer
//
//  Created by Na Tian on 7/4/2023.
//

import SwiftUI

struct RecipeDetailView: View {
    @StateObject private var recipeManager = RecipeManager()
    @State var tabIndex = 0
    var body: some View {
        NavigationView() {
            VStack() {
                AsyncImageView(urlString: $recipeManager.currentImageURLString)
                    .cornerRadius(40)
                VStack(alignment: .leading) {
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
                    VStack {
                        CustomTabBar(tabIndex: $tabIndex)
                        switch tabIndex {
                        case 1:
                            InstructionsView()
                        case 2:
                            NutritionView()
                        default:
                            IngredientsView()
                        }
                    }
                }
                .padding(.horizontal)
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

struct CustomTabBar: View {
    @Binding var tabIndex: Int
    var body: some View {
        HStack(spacing: 20) {
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
            .padding(.bottom,10)
            .border(Color.red)
    }
}

struct IngredientsView: View{
    var body: some View{
        ZStack{
            Rectangle()
                .foregroundColor(.blue)
            Text("IngredientsView")
        }
    }
}

struct InstructionsView: View{
    var body: some View{
        ZStack{
            Rectangle()
                .foregroundColor(.orange)
            Text("InstructionsView")
        }
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
