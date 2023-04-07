//
//  RecipeDetailView.swift
//  Mealer
//
//  Created by Na Tian on 7/4/2023.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    @State var tabIndex = 0
    var body: some View {
        NavigationView() {
            VStack() {
                if let recipeImage = recipe.imageUrlString {
                    AsyncImageView(urlString: recipeImage)
                        .cornerRadius(40)
                }
                VStack(alignment: .leading, spacing: 15) {
                    Text(recipe.name)
                        .font(.title2)
                    HStack {
                        HStack {
                            Image(systemName: "timer")
                            Text("\(recipe.duration)")
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
                    ZStack(alignment: .bottom) {
                        VStack(spacing: 15) {
                            CustomTabBar(tabIndex: $tabIndex)
                            switch tabIndex {
                            case 1:
                                // Instructions View
                                ScrollView {
                                    VStack {
                                        let instructionsArray = recipe.instructions.components(separatedBy: ". ")
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
                            case 2:
                                NutritionView()
                            default:
                                // Ingredients View
                                ScrollView {
                                    VStack(spacing: 15) {
                                        ForEach(recipe.ingredients, id:\.self) { ingredient in
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
                        Button(action: {
                            
                        }, label: {
                            HStack {
                                Spacer()
                                Text("Cooking")
                                    .foregroundColor(Color.white)
                                Spacer()
                            }
                            .padding(.vertical)
                            .background(
                                RoundedRectangle(cornerRadius: 40)
                                    .fill(Color.accentColor)
                            )
                        })
                    }
                }
                .padding(.horizontal)
                Spacer()
            }
            .edgesIgnoringSafeArea(.vertical)
//            .onAppear {
//                recipeManager.detailRecipeRequest(recipeId: "52913")
////                recipeManager.detailRecipeRequest(recipeId: "52862")
//            }
        }
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleIngredient1 = RecipeIngredient(name: "Roasted Vegetables", measure: "400g", image: ingredientNetwork.ingredientImagePath + "Roasted Vegetables".replacingOccurrences(of: " ", with: "%20") + ".png")
        let sampleIngredient2 = RecipeIngredient(name: "Kidney Beans", measure: "1 can", image: ingredientNetwork.ingredientImagePath + "Kidney Beans".replacingOccurrences(of: " ", with: "%20") + ".png")
        let sampleIngredient3 = RecipeIngredient(name: "Chopped Tomatoes", measure: "1 can", image: ingredientNetwork.ingredientImagePath + "Chopped Tomatoes".replacingOccurrences(of: " ", with: "%20") + ".png")
        let sampleIngredient4 = RecipeIngredient(name: "Mixed Grain", measure: "1 Packet", image: ingredientNetwork.ingredientImagePath + "Mixed Grain".replacingOccurrences(of: " ", with: "%20") + ".png")
        let sample = Recipe(id: "52867", name: "Vegetarian Chilli", imageUrlString: "https://www.themealdb.com/images/media/meals/wqurxy1511453156.jpg", ingredients: [sampleIngredient1, sampleIngredient2, sampleIngredient3, sampleIngredient4], instructions: "Heat oven to 200C/180C fan/ gas 6. Cook the vegetables in a casserole dish for 15 mins. Tip in the beans and tomatoes, season, and cook for another 10-15 mins until piping hot. Heat the pouch in the microwave on High for 1 min and serve with the chilli.", duration: "2h 25m")
        RecipeDetailView(recipe: sample)
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
