//
//  ViewFoodStorage.swift
//  Mealer
//
//  Created by Na Tian on 27/3/2023.
//

import SwiftUI

struct ViewFoodStorage: View {
    @State private var showSannerSheet = false
    @State private var isAddingIngredient = false
    @State private var texts:[ScanData] = []
    @State private var ingredientLibrary: [Ingredient] = [
        Ingredient(name: "Spinach", expire: 3, weight: "250 g", image: "Ingredients/Spinach", isSelected: false, isNew: true, category: "Vegetable", nutrition: Nutrition(name: "Spinach", protein: 2, carbon: 4, fat: 0), createdDate: Date()),
        Ingredient(name: "Carrot", expire: 20, weight: "10 pcs", image: "Ingredients/Carrot", isSelected: false, isNew: true, category: "Vegetable", nutrition: Nutrition(name: "Carrot", protein: 1, carbon: 10, fat: 0), createdDate: Date()),
        Ingredient(name: "Broccoli", expire: 5, weight: "500 g", image: "Ingredients/Broccoli", isSelected: false, isNew: true, category: "Vegetable", nutrition: Nutrition(name: "Broccoli", protein: 3, carbon: 7, fat: 0), createdDate: Date()),
        Ingredient(name: "Cauliflower", expire: 5, weight: "500 g", image: "Ingredients/Cauliflower", isSelected: false, isNew: true, category: "Vegetable", nutrition: Nutrition(name: "Cauliflower", protein: 2, carbon: 5, fat: 0), createdDate: Date()),
        Ingredient(name: "Lettuce", expire: 2, weight: "1 pc", image: "Ingredients/Lettuce", isSelected: false, isNew: true, category: "Vegetable", nutrition: Nutrition(name: "Lettuce", protein: 1, carbon: 3, fat: 0), createdDate: Date()),
        Ingredient(name: "Cabbage", expire: 7, weight: "1 head", image: "Ingredients/Cabbage", isSelected: false, isNew: true, category: "Vegetable", nutrition: Nutrition(name: "Cabbage", protein: 1, carbon: 6, fat: 0), createdDate: Date()),
        Ingredient(name: "Tomato", expire: 9, weight: "10 pcs", image: "Ingredients/Tomato", isSelected: false, isNew: true, category: "Vegetable", nutrition: Nutrition(name: "Tomato", protein: 1, carbon: 4, fat: 0), createdDate: Date()),
        Ingredient(name: "Pepper", expire: 365, weight: "500 g", image: "Ingredients/Pepper", isSelected: false, isNew: true, category: "Pantry", nutrition: Nutrition(name: "Pepper", protein: 1, carbon: 6, fat: 0), createdDate: Date()),
        Ingredient(name: "Onion", expire: 14, weight: "3 pcs", image: "Ingredients/Onion", isSelected: false, isNew: true, category: "Vegetable", nutrition: Nutrition(name: "Onion", protein: 1, carbon: 9, fat: 0), createdDate: Date()),
        Ingredient(name: "Garlic", expire: 30, weight: "3 heads", image: "Ingredients/Garlic", isSelected: false, isNew: true, category: "Pantry", nutrition: Nutrition(name: "Garlic", protein: 1, carbon: 30, fat: 0), createdDate: Date()),
        Ingredient(name: "Potato", expire: 30, weight: "15 pcs", image: "Ingredients/Potato", isSelected: false, isNew: true, category: "Pantry", nutrition: Nutrition(name: "Potato", protein: 2, carbon: 17, fat: 0), createdDate: Date()),
        Ingredient(name: "Sweet potato", expire: 14, weight: "2 pcs", image: "Ingredients/SweetPotato", isSelected: false, isNew: true, category: "Vegetable", nutrition: Nutrition(name: "Sweet potato", protein: 2, carbon: 20, fat: 0), createdDate: Date()),
        Ingredient(name: "Zucchini", expire: 5, weight: "500 g", image: "Ingredients/Zucchini", isSelected: false, isNew: true, category: "Vegetable", nutrition: Nutrition(name: "Zucchini", protein: 1, carbon: 3, fat: 0), createdDate: Date()),
        Ingredient(name: "Eggplant", expire: 7, weight: "3 pcs", image: "Ingredients/Eggplant", isSelected: false, isNew: true, category: "Vegetable", nutrition: Nutrition(name: "Eggplant", protein: 1, carbon: 6, fat: 0), createdDate: Date()),
        Ingredient(name: "Cucumber", expire: 2, weight: "2 pcs", image: "Ingredients/Cucumber", isSelected: false, isNew: true, category: "Vegetable", nutrition: Nutrition(name: "Cucumber", protein: 1, carbon: 3, fat: 0), createdDate: Date()),
        Ingredient(name: "Green beans", expire: 3, weight: "1 bag", image: "Ingredients/GreenBeans", isSelected: false, isNew: true, category: "Vegetable", nutrition: Nutrition(name: "Green beans", protein: 1, carbon: 7, fat: 0), createdDate: Date()),
        Ingredient(name: "Peas", expire: 15, weight: "1 bag", image: "Ingredients/Peas", isSelected: false, isNew: true, category: "Vegetable", nutrition: Nutrition(name: "Peas", protein: 5, carbon: 14, fat: 0), createdDate: Date()),
        Ingredient(name: "Banana", expire: 5, weight: "3 pcs", image: "Ingredients/Bananas", isSelected: false, isNew: true, category: "Fruit", nutrition: Nutrition(name: "Bananas", protein: 1, carbon: 23, fat: 0), createdDate: Date()),
        Ingredient(name: "Egg", expire: 15, weight: "12 pcs", image: "Ingredients/Egg", isSelected: false, isNew: true, category: "Dairy", nutrition: Nutrition(name: "Egg", protein: 13, carbon: 1, fat: 11), createdDate: Date()),
        Ingredient(name: "Petuna Salmon Portions", expire: 30, weight: "1 bag", image: "Ingredients/PetunaSalmonPortions", isSelected: false, isNew: true, category: "Vegetable", nutrition: Nutrition(name: "Peas", protein: 5, carbon: 14, fat: 0), createdDate: Date()),
        Ingredient(name: "Corn Kernels", expire: 60, weight: "500 g", image: "Ingredients/Corn", isSelected: false, isNew: true, category: "Vegetable", nutrition: Nutrition(name: "Corn", protein: 3, carbon: 19, fat: 1), createdDate: Date())
    ]
    @State private var existingIngredients: [Ingredient] = [
        Ingredient(name: "Broccoli", expire: -3, weight: "500 g", image: "Ingredients/Broccoli", isSelected: false, isNew: false, category: "Vegetable", nutrition: Nutrition(name: "Broccoli", protein: 3, carbon: 7, fat: 0), createdDate: DateComponents(calendar: Calendar.current, year: 2023, month: 4, day: 3).date!),
        Ingredient(name: "Carrot", expire: -5, weight: "3 pcs", image: "Ingredients/Carrot", isSelected: false, isNew: false, category: "Vegetable", nutrition: Nutrition(name: "Carrot", protein: 1, carbon: 10, fat: 0), createdDate: DateComponents(calendar: Calendar.current, year: 2023, month: 4, day: 3).date!),
        Ingredient(name: "Tomato", expire: -4, weight: "2 pcs", image: "Ingredients/Tomato", isSelected: false, isNew: false, category: "Vegetable", nutrition: Nutrition(name: "Tomato", protein: 1, carbon: 4, fat: 0), createdDate: DateComponents(calendar: Calendar.current, year: 2023, month: 4, day: 3).date!),
        Ingredient(name: "Lettuce", expire: 2, weight: "1 head", image: "Ingredients/Lettuce", isSelected: false, isNew: false, category: "Vegetable", nutrition: Nutrition(name: "Lettuce", protein: 1, carbon: 3, fat: 0), createdDate: DateComponents(calendar: Calendar.current, year: 2023, month: 4, day: 3).date!),
        Ingredient(name: "Apples", expire: 10, weight: "12 pcs", image: "Ingredients/Apples", isSelected: false, isNew: false, category: "Fruit", nutrition: Nutrition(name: "Apples", protein: 0, carbon: 14, fat: 0), createdDate: DateComponents(calendar: Calendar.current, year: 2023, month: 4, day: 3).date!),
        Ingredient(name: "Oranges", expire: 7, weight: "5 pcs", image: "Ingredients/Oranges", isSelected: false, isNew: false, category: "Fruit", nutrition: Nutrition(name: "Oranges", protein: 1, carbon: 12, fat: 0), createdDate: DateComponents(calendar: Calendar.current, year: 2023, month: 4, day: 3).date!),
        Ingredient(name: "Beef", expire: 3, weight: "500 g", image: "Ingredients/Beef", isSelected: false, isNew: false, category: "Meat", nutrition: Nutrition(name: "Beef", protein: 26, carbon: 0, fat: 17), createdDate: DateComponents(calendar: Calendar.current, year: 2023, month: 4, day: 3).date!),
        Ingredient(name: "Chicken breast", expire: 2, weight: "1 kg", image: "Ingredients/ChickenBreast", isSelected: false, isNew: false, category: "Meat", nutrition: Nutrition(name: "Chicken breast", protein: 31, carbon: 0, fat: 3), createdDate: DateComponents(calendar: Calendar.current, year: 2023, month: 4, day: 3).date!),
        Ingredient(name: "Pork", expire: 4, weight: "1 kg", image: "Ingredients/Pork", isSelected: false, isNew: false, category: "Meat", nutrition: Nutrition(name: "Pork", protein: 27, carbon: 0, fat: 14), createdDate: DateComponents(calendar: Calendar.current, year: 2023, month: 4, day: 3).date!),
        Ingredient(name: "Milk", expire: 7, weight: "1 L", image: "Ingredients/Milk", isSelected: false, isNew: false, category: "Dairy", nutrition: Nutrition(name: "Milk", protein: 3, carbon: 5, fat: 4), createdDate: DateComponents(calendar: Calendar.current, year: 2023, month: 4, day: 3).date!),
        Ingredient(name: "Flour", expire: 365, weight: "2.27 kg", image: "Ingredients/Flour", isSelected: false, isNew: false, category: "Pantry", nutrition: Nutrition(name: "Flour", protein: 10, carbon: 76, fat: 1), createdDate: DateComponents(calendar: Calendar.current, year: 2023, month: 4, day: 3).date!),
        Ingredient(name: "Tomato sauce", expire: 365, weight: "25 bags", image: "Ingredients/TomatoSauce", isSelected: false, isNew: false, category: "Pantry", nutrition: Nutrition(name: "Tomato sauce", protein: 1, carbon: 10, fat: 0), createdDate: DateComponents(calendar: Calendar.current, year: 2023, month: 4, day: 3).date!),
        Ingredient(name: "Sugar", expire: 365, weight: "907 g", image: "Ingredients/Sugar", isSelected: false, isNew: false, category: "Pantry", nutrition: Nutrition(name: "Sugar", protein: 0, carbon: 100, fat: 0), createdDate: DateComponents(calendar: Calendar.current, year: 2023, month: 4, day: 3).date!),
        Ingredient(name: "Salt", expire: 365, weight: "454 g", image: "Ingredients/Salt", isSelected: false, isNew: false, category: "Pantry", nutrition: Nutrition(name: "Salt", protein: 0, carbon: 0, fat: 0), createdDate: DateComponents(calendar: Calendar.current, year: 2023, month: 4, day: 3).date!),
        Ingredient(name: "Pepper", expire: 365, weight: "113 g", image: "Ingredients/Pepper", isSelected: false, isNew: false, category: "Pantry", nutrition: Nutrition(name: "Pepper", protein: 3, carbon: 64, fat: 3), createdDate: DateComponents(calendar: Calendar.current, year: 2023, month: 4, day: 3).date!)
    ]
    
    @State private var results:[Ingredient] = []
    
    @State private var isSelectionView: Bool = false
    @State private var isSortByCategory: Bool = false
    @State private var isGridView: Bool = false
    
    @State private var newIngredients:[Ingredient] = []
    
    @State private var searchText: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Food Storage")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.accentColor)
                Spacer()
                Menu{
                    Button(action: { self.showSannerSheet = true }) {
                        Text("Scan Receipt")
                            .modifier(TextModifier())
                    }
                    Button(action: { self.isAddingIngredient = true}) {
                        Text("Manual Add")
                            .modifier(TextModifier())
                    }
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 28, weight: .bold))
                }
                .disabled(isSelectionView)
            }
            VStack {
                functionKeys(
                    isSelectionView: $isSelectionView,
                    newIngredients: $newIngredients,
                    isSortByCategory: $isSortByCategory,
                    isGridView: $isGridView
                )
                SearchBarView(searchText: $searchText, newIngredients: $newIngredients)
                ScrollView {
                    if isSortByCategory {
                        ForEach(categories.indices, id: \.self) { index in
                            let category = categories[index]
                            if !newIngredients.filter{$0.category == category.name}.isEmpty {
                                Button(action: {
                                    categories[index].isExpanding.toggle()
                                }, label: {
                                    HStack{
                                        Text(category.name)
                                            .modifier(TextModifier())
                                        Spacer()
                                        categories[index].isExpanding ? Image(systemName: "chevron.down") : Image(systemName: "chevron.forward")
                                    }
                                })
                                if category.isExpanding {
                                    if isGridView {
                                        IngredientsGridView(
                                            newIngredients: $newIngredients,
                                            isSelectionView: isSelectionView,
                                            category: category.name)
                                    } else {
                                        IngredientsListView(
                                            newIngredients: $newIngredients,
                                            isSelectionView: isSelectionView,
                                            category: category.name)
                                    }
                                } else {
                                    Divider()
                                }
                            }
                            
                        }
                    } else {
                        if isGridView {
                            IngredientsGridView(newIngredients: $newIngredients, isSelectionView: isSelectionView)
                                .padding(.vertical, 3)
                        } else {
                            IngredientsListView(newIngredients: $newIngredients, isSelectionView: isSelectionView)
                                .padding(.vertical, 3)
                        }
                    }
                }
                if isSelectionView {
                    Divider()
                    countSelectedIngredients(newIngredients: $newIngredients, isSelectionView: $isSelectionView)
                }
            }
            .sheet(isPresented: $showSannerSheet, content: {
                makeScannerView()
            })
            .sheet(isPresented: $isAddingIngredient, content: {
                SearchIngredientLibraryView(isAddingIngredient: $isAddingIngredient, newIngredients: $newIngredients)
            })
        }
        .padding()
        .onAppear {
            if (newIngredients.isEmpty) {
                newIngredients = existingIngredients + results
                newIngredients = newIngredients.sorted(by: {$0.expire < $1.expire})
            }
        }
    }
    
    private func makeScannerView() -> ScannerView {
        ScannerView(completion: {
            textPerPage in
            if let outputText = textPerPage?.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines) {
                let newScanData = ScanData(content: outputText)
                for ingredient in ingredientLibrary {
                    if (newScanData.content.contains(ingredient.name)) {
                        results.append(ingredient)
                        newIngredients = existingIngredients + results
                    }
                }
                
                self.texts.append(newScanData)
            }
            self.showSannerSheet = false
            newIngredients = newIngredients.sorted(by: {$0.expire < $1.expire})
        })
    }
}

struct ViewFoodStorage_Previews: PreviewProvider {
    static var previews: some View {
        ViewFoodStorage()
    }
}


struct IngredientsGridView: View {
    @Binding var newIngredients: [Ingredient]
    var isSelectionView: Bool;
    var category: String?
    @State var viewWidth: CGFloat = 81;
    private let adaptiveColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: adaptiveColumns, spacing: 10) {
            ForEach(category != nil ? newIngredients.filter{$0.category == category} : newIngredients, id: \.id) { ingredient in
                let index = newIngredients.firstIndex(where: {$0.id == ingredient.id})!
                if !isSelectionView {
                    NavigationLink(destination: IngredientDetailView(ingredient: $newIngredients[index])) {
                        ingredientGridView(for: ingredient)
                    }
                } else {
                    ingredientGridView(for: ingredient)
                        .onTapGesture {
                            if let index = newIngredients.firstIndex(where: { $0.id == ingredient.id }) {
                                newIngredients[index].isSelected.toggle()
                            }
                        }
                        .multilineTextAlignment(.center)
                }
            }
        }
    }
    
    func ingredientGridView(for ingredient: Ingredient) -> some View {
        VStack(spacing:5) {
            ZStack {
                VStack {
                    if ingredient.image.contains("https") {
                        Image(uiImage: "\(ingredient.image)".load())
                            .resizable()
                            .frame(width: viewWidth-20, height: viewWidth-10)
                            .opacity(isSelectionView ? 0.3 : 0.8)
                    } else {
                        Image(ingredient.image)
                            .resizable()
                            .frame(width: viewWidth-20, height: viewWidth-10)
                            .opacity(isSelectionView ? 0.3 : 0.8)
                    }
                }
                .frame(width: viewWidth, height: viewWidth+10)
                
                if ingredient.expire > 0 {
                    Text("\(ingredient.expire) days")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(
                            ingredient.expire < 3 ?
                            Color.yellow.shadow(
                                .drop(color: .black, radius: 1, x: 1, y: 1)
                            ) : Color("TextColor").shadow(
                                    .drop(color: .white, radius: 1, x: 1, y: 1)
                                )
                        )
                } else {
                    Text("Expired \(abs(ingredient.expire)) days")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(
                            Color.red.shadow(
                                .drop(color: .white, radius: 1, x: 1, y: 1)
                            )
                        )
                }
                if ingredient.isNew {
                    Text("New*")
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color.accentColor)
                        .offset(x: viewWidth / 5, y: -30)
                }
            }
            Text("\(ingredient.name)")
                .font(.system(size: 16, weight: .medium))
                .modifier(TextModifier())
                .frame(width: viewWidth, height: 40, alignment: .top)
                .multilineTextAlignment(.center)
                .lineLimit(2)
            HStack {
                Text("\(ingredient.weight)")
                    .modifier(TextModifier())
                    .frame(height: 20, alignment: .top)
                Spacer()
                if (isSelectionView) {
                    if (ingredient.isSelected == true) {
                        Image(systemName: "checkmark.circle.fill");
                    } else {
                        Image(systemName: "circle")
                    }
                }
            }
            .padding(.horizontal, 5)
        }
        .frame(width: viewWidth, height: viewWidth+91, alignment: .top)
        .foregroundColor(Color.black)
        .backgroundCard(isSelected: ingredient.isSelected, expireDay: ingredient.expire)
    }
}

struct IngredientsListView: View {
    @Binding var newIngredients: [Ingredient]
    var isSelectionView: Bool;
    var category: String?
    
    var body: some View {
        ForEach(category != nil ? newIngredients.filter{$0.category == category} : newIngredients, id: \.id) { ingredient in
            let index = newIngredients.firstIndex(where: {$0.id == ingredient.id})!
            if !isSelectionView {
                NavigationLink(destination: IngredientDetailView(ingredient: $newIngredients[index])) {
                    ingredientListView(for: ingredient)
                }
            } else {
                ingredientListView(for: ingredient)
                    .onTapGesture {
                        if isSelectionView {
                            if let index = newIngredients.firstIndex(where: { $0.id == ingredient.id }) {
                                newIngredients[index].isSelected.toggle()
                            }
                        }
                    }
            }
        }
    }
    
    func ingredientListView(for ingredient: Ingredient) -> some View {
        HStack {
            ZStack {
                if ingredient.image.contains("https") {
                    Image(uiImage: "\(ingredient.image)".load())
                        .resizable()
                        .frame(width: 50, height: 50)
                        .opacity(isSelectionView ? 0.3 : 0.8)
                } else {
                    Image(ingredient.image)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .opacity(isSelectionView ? 0.3 : 0.8)
                }
                
                if (isSelectionView) {
                    if (ingredient.isSelected == true) {
                        Image(systemName: "checkmark.circle.fill");
                    } else {
                        Image(systemName: "circle")
                    }
                }
                if ingredient.isNew {
                    Text("New*")
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color.accentColor)
                        .offset(x: 50 / 3.5, y: -20)
                }
            }
            .frame(width: 70, height: 70)
            VStack(alignment: .leading) {
                Text(ingredient.name)
                    .font(.system(size: 18, weight: .medium))
                    .multilineTextAlignment(.leading)
                Text(ingredient.weight)
                    .font(.system(size: 14))
            }
            Spacer()
            VStack{
                if ingredient.expire > 0 {
                    Text("\(ingredient.expire) days")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(ingredient.expire < 3 ? Color.yellow : Color.black)
                        .padding(.trailing)
                } else {
                    Text("Expired \(abs(ingredient.expire)) days")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color.red)
                        .padding(.trailing)
                }
            }
        }
        .foregroundColor(Color.black)
        .backgroundCard(isSelected: ingredient.isSelected, expireDay: ingredient.expire)
        .padding(.horizontal, 2)
    }
}


struct countSelectedIngredients: View {
    @Binding var newIngredients: [Ingredient]
    @Binding var isSelectionView: Bool;
    @State private var isShowingDialog: Bool = false
    
    var body: some View {
        HStack {
            let countIngredients = newIngredients.filter{$0.isSelected}.count;
            Spacer()
            Text(countIngredients > 0 ?
                 countIngredients == 1 ?
                 "1 Ingredient Selected" : "\(countIngredients) Ingredients Selected"
                 : "Select Ingredients")
            .modifier(TextModifier())
            Spacer()
            Button{
                isShowingDialog = true
            } label: {
                Image(systemName: "trash")
                    .resizable()
                    .frame(width: 25, height: 25)
            }
            .disabled(countIngredients == 0)
            .confirmationDialog(
                "Are you sure?",
                isPresented: $isShowingDialog
            ) {
                Button("Delete", role: .destructive) {
                    deleteIngredients()
                }
                Button("Cancel", role: .cancel) {
                    isShowingDialog = false
                }
            } message: {
                Text(countIngredients == 1 ? "Delete 1 Ingredient?" : "Delete \(countIngredients) Ingredients?")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 50)
    }
    
    private func deleteIngredients() {
        newIngredients.removeAll(where: {$0.isSelected})
        isSelectionView = false
    }
}

struct functionKeys: View {
    @Binding var isSelectionView: Bool
    @Binding var newIngredients: [Ingredient]
    @Binding var isSortByCategory: Bool
    @Binding var isGridView: Bool
    var body: some View {
        HStack{
            Spacer()
            
            // select
            Button(action: {
                isSelectionView = !isSelectionView
                if !isSelectionView {
                    newIngredients.indices.forEach { index in
                        newIngredients[index].isSelected = false
                    }
                }
            }, label: {
                if isSelectionView {
                    Image(systemName: "checkmark.square.fill").imageScale(.large)
                } else {
                    Image(systemName: "checkmark.square").imageScale(.large)
                }
                
            })
            
            // sort
            Menu{
                Button(action: { sortIngredients(sort: .expireDate) }) {
                    Text("Sort by expire date")
                        .modifier(TextModifier())
                }
                Button(action: { sortIngredients(sort: .category) }) {
                    Text("Sort by category")
                        .modifier(TextModifier())
                }
            } label: {
                Image(systemName: "arrow.up.arrow.down").imageScale(.large)
            }
            .disabled(isSelectionView)
            
            // view
            Button(action: {
                isGridView = !isGridView
            }, label: {
                isGridView ? Image(systemName: "square.grid.2x2.fill").imageScale(.large) : Image(systemName: "square.fill.text.grid.1x2").imageScale(.large)
            })
            .disabled(isSelectionView)
        }
        .frame(height: 25, alignment: .trailing)
    }
    
    private func sortIngredients(sort: Sort) {
        switch sort {
        case .expireDate:
            newIngredients = newIngredients.sorted(by: {$0.expire < $1.expire})
            isSortByCategory = false
        case .category:
            isSortByCategory = true
        }
    }
}

struct SearchBarView: View {
    @Binding var searchText: String
    @Binding var newIngredients: [Ingredient]
    @State private var allIngredients: [Ingredient] = []
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color.gray)
            TextField("Search by name...", text: $searchText)
                .disableAutocorrection(true)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundColor(Color.accentColor.opacity(0.8))
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                            newIngredients = allIngredients
                        }
                    ,alignment: .trailing
                )
                .onChange(of: searchText) {newSearch in
                    newIngredients = newSearch.isEmpty ? allIngredients : allIngredients.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
                }
                .onAppear {
                    allIngredients = newIngredients
                }
        }
        .padding(10)
        .backgroundTextField()
    }
}

