//
//  ViewFoodStorage.swift
//  Mealer
//
//  Created by Na Tian on 27/3/2023.
//

import SwiftUI
struct Ingredient: Identifiable {
    let id = UUID()
    let name: String
    var expire: Int
    var weight: String
    let image: String
    var isSelected: Bool
    var isNew: Bool
    let category: String
}
enum Sort {
    case expireDate, category, nameAscending, nameDescending
}

struct Category: Identifiable {
    let id = UUID()
    let name: String
    var isExpanding: Bool
}

extension View {
    func backgroundCard(isSelected: Bool) -> some View {
        self.background(
            RoundedRectangle(cornerRadius: 5)
                .fill(isSelected ? Color.accentColor.opacity(0.6) : Color.white)
                .shadow(color: .gray, radius: 2, x: 0, y: 0)
        )
    }
}

struct ViewFoodStorage: View {
    @State private var showSannerSheet = false
    @State private var texts:[ScanData] = []
    @State private var categories: [Category] = [
        Category(name: "Vegetable", isExpanding: true),
        Category(name: "Fruit", isExpanding: true),
        Category(name: "Meat", isExpanding: true),
        Category(name: "Dairy", isExpanding: true),
        Category(name: "Pantry", isExpanding: true)
    ]
    @State private var ingredientLibrary: [Ingredient] = [
        Ingredient(name: "Spinach", expire: 3, weight: "250 g", image: "Ingredients/Spinach", isSelected: false, isNew: true, category: "Vegetable"),
        Ingredient(name: "Carrot", expire: 7, weight: "500 g", image: "Ingredients/Carrot", isSelected: false, isNew: true, category: "Vegetable"),
        Ingredient(name: "Broccoli", expire: 5, weight: "500 g", image: "Ingredients/Broccoli", isSelected: false, isNew: true, category: "Vegetable"),
        Ingredient(name: "Cauliflower", expire: 5, weight: "500 g", image: "Ingredients/Cauliflower", isSelected: false, isNew: true, category: "Vegetable"),
        Ingredient(name: "Lettuce", expire: 2, weight: "1 pc", image: "Ingredients/Lettuce", isSelected: false, isNew: true, category: "Vegetable"),
        Ingredient(name: "Cabbage", expire: 7, weight: "1 head", image: "Ingredients/Cabbage", isSelected: false, isNew: true, category: "Vegetable"),
        Ingredient(name: "Tomato", expire: 4, weight: "1 kg", image: "Ingredients/Tomato", isSelected: false, isNew: true, category: "Vegetable"),
        Ingredient(name: "Pepper", expire: 7, weight: "500 g", image: "Ingredients/Pepper", isSelected: false, isNew: true, category: "Vegetable"),
        Ingredient(name: "Onion", expire: 14, weight: "1 kg", image: "Ingredients/Onion", isSelected: false, isNew: true, category: "Vegetable"),
        Ingredient(name: "Garlic", expire: 30, weight: "250 g", image: "Ingredients/Garlic", isSelected: false, isNew: true, category: "Vegetable"),
        Ingredient(name: "Potato", expire: 30, weight: "2 kg", image: "Ingredients/Potato", isSelected: false, isNew: true, category: "Vegetable"),
        Ingredient(name: "Sweet potato", expire: 14, weight: "1 kg", image: "Ingredients/SweetPotato", isSelected: false, isNew: true, category: "Vegetable"),
        Ingredient(name: "Zucchini", expire: 5, weight: "500 g", image: "Ingredients/Zucchini", isSelected: false, isNew: true, category: "Vegetable"),
        Ingredient(name: "Eggplant", expire: 7, weight: "500 g", image: "Ingredients/Eggplant", isSelected: false, isNew: true, category: "Vegetable"),
        Ingredient(name: "Cucumber", expire: 5, weight: "500 g", image: "Ingredients/Cucumber", isSelected: false, isNew: true, category: "Vegetable"),
        Ingredient(name: "Green beans", expire: 3, weight: "250 g", image: "Ingredients/GreenBeans", isSelected: false, isNew: true, category: "Vegetable"),
        Ingredient(name: "Peas", expire: 15, weight: "500 g", image: "Ingredients/Peas", isSelected: false, isNew: true, category: "Vegetable"),
        Ingredient(name: "Corn", expire: 3, weight: "4 ears", image: "Ingredients/Corn", isSelected: false, isNew: true, category: "Vegetable")
    ]
    @State private var existingIngredients: [Ingredient] = [
        Ingredient(name: "Broccoli", expire: -3, weight: "500 g", image: "Ingredients/Broccoli", isSelected: false, isNew: false, category: "Vegetable"),
        Ingredient(name: "Carrot", expire: -5, weight: "1 kg", image: "Ingredients/Carrot", isSelected: false, isNew: false, category: "Vegetable"),
        Ingredient(name: "Tomato", expire: -4, weight: "750 g", image: "Ingredients/Tomato", isSelected: false, isNew: false, category: "Vegetable"),
        Ingredient(name: "Lettuce", expire: 2, weight: "1 pc", image: "Ingredients/Lettuce", isSelected: false, isNew: false, category: "Vegetable"),
        Ingredient(name: "Apples", expire: 10, weight: "1 kg", image: "Ingredients/Apples", isSelected: false, isNew: false, category: "Fruit"),
        Ingredient(name: "Bananas", expire: 5, weight: "1 kg", image: "Ingredients/Bananas", isSelected: false, isNew: false, category: "Fruit"),
        Ingredient(name: "Oranges", expire: 7, weight: "1 kg", image: "Ingredients/Oranges", isSelected: false, isNew: false, category: "Fruit"),
        Ingredient(name: "Beef", expire: 3, weight: "500 g", image: "Ingredients/Beef", isSelected: false, isNew: false, category: "Meat"),
        Ingredient(name: "Chicken breast", expire: 2, weight: "1 kg", image: "Ingredients/ChickenBreast", isSelected: false, isNew: false, category: "Meat"),
        Ingredient(name: "Pork", expire: 4, weight: "1 kg", image: "Ingredients/Pork", isSelected: false, isNew: false, category: "Meat"),
        Ingredient(name: "Egg", expire: 5, weight: "12 pcs", image: "Ingredients/Egg", isSelected: false, isNew: false, category: "Dairy"),
        Ingredient(name: "Milk", expire: 7, weight: "1 liter", image: "Ingredients/Milk", isSelected: false, isNew: false, category: "Dairy"),
        Ingredient(name: "Flour", expire: 365, weight: "2.27 kg", image: "Ingredients/Flour", isSelected: false, isNew: false, category: "Pantry"),
        Ingredient(name: "Tomato sauce", expire: 365, weight: "2.27 kg", image: "Ingredients/TomatoSauce", isSelected: false, isNew: false, category: "Pantry"),
        Ingredient(name: "Sugar", expire: 365, weight: "907 g", image: "Ingredients/Sugar", isSelected: false, isNew: false, category: "Pantry"),
        Ingredient(name: "Salt", expire: 365, weight: "454 g", image: "Ingredients/Salt", isSelected: false, isNew: false, category: "Pantry"),
        Ingredient(name: "Pepper", expire: 365, weight: "113 g", image: "Ingredients/Pepper", isSelected: false, isNew: false, category: "Pantry")
    ]
    
    @State private var results:[Ingredient] = []
    private let adaptiveColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State private var isSelectionView: Bool = false
    @State private var switchListView: Bool = false
    @State private var isSortByCategory: Bool = true
    @State private var isGridView: Bool = true
    
    @State private var newIngredients:[Ingredient] = []
        
    var body: some View {
        VStack {
            NavigationStack {
                HStack {
                    Spacer()
                    Text("Food Storage")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.accentColor)
                        .multilineTextAlignment(.center)
                    Spacer()
//                    Button(action: {
//
//                    }, label: {
//                        Image(systemName: "magnifyingglass")
//                            .font(.system(size: 25, weight: .bold))
//                    })
                    Button(action: {
                        self.showSannerSheet = true
                    }, label: {
                        Image(systemName: "plus")
                            .font(.system(size: 28, weight: .bold))
                    })
                    .disabled(isSelectionView)
                }
                VStack {
                    functionKeys(
                        isSelectionView: $isSelectionView,
                        newIngredients: $newIngredients,
                        isSortByCategory: $isSortByCategory,
                        isGridView: $isGridView
                    )
                    ScrollView {
                        if isSortByCategory {
                            ForEach(categories.indices, id: \.self) { index in
                                let category = categories[index]
                                Button(action: {
                                    categories[index].isExpanding.toggle()
                                }, label: {
                                    HStack{
                                        Text(category.name)
                                        Spacer()
                                        categories[index].isExpanding ? Image(systemName: "chevron.down") : Image(systemName: "chevron.forward")
                                    }
                                })
                                if category.isExpanding {
                                    if isGridView {
                                        LazyVGrid(columns: adaptiveColumns, spacing: 8) {
                                            IngredientsGridView(newIngredients: $newIngredients, isSelectionView: isSelectionView, category: category.name)
                                        }
                                    } else {
                                        IngredientsListView(newIngredients: $newIngredients, isSelectionView: isSelectionView, category: category.name)
                                    }
                                } else {
                                    Divider()
                                }
                            }
                        } else {
                            if isGridView {
                                LazyVGrid(columns: adaptiveColumns, spacing: 8) {
                                    IngredientsGridView(newIngredients: $newIngredients, isSelectionView: isSelectionView)
                                }
                                .padding(.top, 3)
                            } else {
                                IngredientsListView(newIngredients: $newIngredients, isSelectionView: isSelectionView)
                                    .padding(.top, 3)
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
            }
        }
        .padding()
        .onAppear {
            if (newIngredients.isEmpty) {
                newIngredients = existingIngredients + results
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
                        newIngredients.append(ingredient)
                    }
                }
                
                self.texts.append(newScanData)
            }
            self.showSannerSheet = false
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
    @State var viewWidth: CGFloat = 110;
    
    var body: some View {
        ForEach(category != nil ? newIngredients.filter{$0.category == category} : newIngredients, id: \.id) { ingredient in
            VStack(spacing:6) {
                ZStack {
                    VStack {
                        Image(ingredient.image)
                            .resizable()
                            .frame(width: viewWidth-20, height: 100)
                            .opacity(isSelectionView ? 0.3 : 0.8)
                    }
                    .frame(width: viewWidth, height: 120)
                    
                    if ingredient.expire > 0 {
                        Text("\(ingredient.expire) days")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(
                                Color.black.shadow(
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
                            .offset(x: viewWidth / 3.5, y: -50)
                    }
                }
                Text("\(ingredient.name)")
                    .font(.system(size: 16, weight: .medium))
                    .frame(width: viewWidth, height: 40, alignment: .top)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                HStack {
                    Text("\(ingredient.weight)")
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
            .frame(width: viewWidth, height: 201, alignment: .top)
            .onTapGesture {
                if isSelectionView {
                    if let index = newIngredients.firstIndex(where: { $0.id == ingredient.id }) {
                        newIngredients[index].isSelected.toggle()
                    }
                }
            }
            .backgroundCard(isSelected: ingredient.isSelected)
        }
        
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
                }
                Button(action: { sortIngredients(sort: .category) }) {
                    Text("Sort by category")
                }
                Button(action: { sortIngredients(sort: .nameAscending) }) {
                    Text("Sort by name A to Z")
                }
                Button(action: { sortIngredients(sort: .nameDescending) }) {
                    Text("Sort by name Z to A")
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
        case .nameAscending:
            newIngredients = newIngredients.sorted(by: {$0.name < $1.name})
            isSortByCategory = false
        case .nameDescending:
            newIngredients = newIngredients.sorted(by: {$0.name > $1.name})
            isSortByCategory = false
        }
        
    }
    private func switchView() {
        
    }
}

struct IngredientsListView: View {
    @Binding var newIngredients: [Ingredient]
    var isSelectionView: Bool;
    var category: String?
    
    var body: some View {
        ForEach(category != nil ? newIngredients.filter{$0.category == category} : newIngredients, id: \.id) { ingredient in
            HStack {
                ZStack {
                    Image(ingredient.image)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .opacity(isSelectionView ? 0.3 : 0.8)
                    
                    if (isSelectionView) {
                        if (ingredient.isSelected == true) {
                            Image(systemName: "checkmark.circle.fill");
                        } else {
                            Image(systemName: "circle")
                        }
                    }
                }
                .frame(width: 70, height: 70)
                VStack(alignment: .leading) {
                    Text(ingredient.name)
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(ingredient.isNew ? Color.accentColor : Color.black)
                    Text(ingredient.weight)
                        .font(.system(size: 14))
                }
                Spacer()
                VStack{
                    if ingredient.expire > 0 {
                        Text("\(ingredient.expire) days")
                            .font(.system(size: 20, weight: .bold))
                            .padding(.trailing)
                    } else {
                        Text("Expired \(abs(ingredient.expire)) days")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color.red)
                            .padding(.trailing)
                    }
                }
            }
            .backgroundCard(isSelected: ingredient.isSelected)
            .padding(.horizontal, 2)
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
