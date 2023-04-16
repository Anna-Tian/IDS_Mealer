//
//  AddIngredientView.swift
//  Mealer
//
//  Created by Na Tian on 16/4/2023.
//

import SwiftUI

struct SearchIngredientLibraryView: View {
    @StateObject private var ingredientManager = IngredientManager()
    @State private var searchText = ""
    @Binding var isAddingIngredient: Bool
    @State private var manualAddIngredient = false
    @Binding var newIngredients: [Ingredient]
    var body: some View {
        VStack {
            VStack{
                
            }
            if let ingredientsLibrary = ingredientManager.ingredients {
                let searchResults: [IngredientLibrary] = searchText.isEmpty ?
                                    ingredientsLibrary :
                                    ingredientsLibrary.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
                NavigationView{
                    List(searchResults, id:\.self) { ingredient in
                        Button(action: {
                            newIngredients.append(.init(
                                name: ingredient.name,
                                expire: Int.random(in: 5...30),
                                weight: "500g",
                                image: ingredient.imageUrlString,
                                isSelected: false,
                                isNew: true,
                                category: ingredient.category,
                                nutrition: Nutrition(
                                    name: ingredient.name,
                                    protein: Int.random(in: 0...10),
                                    carbon: Int.random(in: 10...25),
                                    fat: Int.random(in: 0...10)),
                                createdDate: Date()
                            ))
                            newIngredients = newIngredients.sorted(by: {$0.expire < $1.expire})
                            isAddingIngredient = false
                        }) {
                            HStack {
                                if let ingredientImage = ingredient.imageUrlString {
                                    AsyncImageView(urlString: ingredientImage)
                                        .frame(width: 50, height: 50)
                                }
                                Text(ingredient.name)
                                    .foregroundColor(Color.black)
                                Spacer()
                            }
                        }
                    }
                    .searchable(text: $searchText, prompt: "Search ingredients")
                }
            }
            VStack {
                Button(action: { self.manualAddIngredient = true }) {
                    Text("Create")
                        .frame(width: 150)
                        .font(.system(size: 22, weight: .medium))
                        .foregroundColor(Color.white)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 50)
                                .fill(Color.accentColor)
                                .shadow(color: Color.gray, radius: 2, x: 1, y: 1)
                        )
                }
            }
            .sheet(isPresented: $manualAddIngredient, content: {
                AddIngredientView()
            })
            
            
        }
        .onAppear {
            ingredientManager.allIngredientsRequest()
        }
    }
}

struct AddIngredientView: View {
    @State private var name = ""
    @State private var quantity = ""
    @State private var protein = ""
    @State private var carbon = ""
    @State private var fat = ""
    var body: some View {
        VStack {
            Text("Add Ingredient")
                .padding()
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.accentColor)
            ScrollView {
                VStack(spacing: 20) {
                    VStack(alignment: .leading) {
                        Text("Ingredient Name").font(.system(size: 22, weight: .medium))
                        TextField("", text:$name)
                            .padding()
                            .backgroundTextField()
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Quantity").font(.system(size: 22, weight: .medium))
                        HStack {
                            TextField("", text: $quantity)
                                .padding()
                                .keyboardType(.numberPad)
                                .backgroundTextField()
                                .frame(width: 100)
                            
                            Picker("", selection: $quantity) {
                                ForEach(quantityUnits, id: \.self) { unit in
                                    Text(unit)
                                }
                            }
                            .labelsHidden()
                            Spacer()
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Upload Image").font(.system(size: 22, weight: .medium))
                            Spacer()
                        }
                        Image(systemName: "camera.fill")
                            .resizable()
                            .foregroundColor(Color.accentColor)
                            .frame(width: 60, height: 50)
                            .padding(40)
                            .backgroundTextField()
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Nutritional Information").font(.system(size: 22, weight: .medium))
                        HStack {
                            Text("Protein: ")
                            TextField("", text: $protein)
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                                .keyboardType(.numberPad)
                                .backgroundTextField()
                                .frame(width: 100)
                            Text(" / 100g")
                            Spacer()
                        }
                        HStack {
                            Text("Carbon: ")
                            TextField("", text: $carbon)
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                                .keyboardType(.numberPad)
                                .backgroundTextField()
                                .frame(width: 100)
                            Text(" / 100g")
                            Spacer()
                        }
                        HStack {
                            Text("Fat: ")
                            TextField("", text: $fat)
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                                .keyboardType(.numberPad)
                                .backgroundTextField()
                                .frame(width: 100)
                            Text(" / 100g")
                            Spacer()
                        }
                    }
                }
                .padding(.horizontal, 5)
                
            }
            .padding()
            
            Button(action: {}, label: {
                Text("Save")
                    .frame(width: 150)
                    .font(.system(size: 22, weight: .medium))
                    .foregroundColor(Color.white)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 50)
                            .fill(Color.accentColor)
                            .shadow(color: Color.gray, radius: 2, x: 1, y: 1)
                    )
            })
        }
        
    }
}

struct AddIngredientView_Previews: PreviewProvider {
    static var previews: some View {
        SearchIngredientLibraryView(isAddingIngredient: Binding.constant(false), newIngredients: Binding.constant([]))
    }
}
