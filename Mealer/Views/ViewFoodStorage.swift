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
}
enum Sort {
    case expireDate, createdAscending, createdDescending, nameAscending, nameDescending
}
extension String {
    func load() -> UIImage {
        do {
            // convert string to URL
            guard let url = URL(string: self) else {
                // return empty image if the URL is invalid
                return UIImage()
            }
            //convert URL to data
            let data: Data = try Data(contentsOf: url)
            // create UIImage object from Data and optional value if the image in URL does not exists
            return UIImage(data: data) ?? UIImage()
        } catch {
            
        }
        return UIImage()
    }
}

struct ViewFoodStorage: View {
    @State private var showSannerSheet = false
    @State private var texts:[ScanData] = []
    @State private var ingredientLibrary: [Ingredient] = [
        Ingredient(name: "Spinach", expire: 3, weight: "250 g", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: true),
        Ingredient(name: "Carrot", expire: 7, weight: "500 g", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: true),
        Ingredient(name: "Broccoli", expire: 5, weight: "500 g", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: true),
        Ingredient(name: "Cauliflower", expire: 5, weight: "500 g", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: true),
        Ingredient(name: "Lettuce", expire: 2, weight: "1 piece", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: true),
        Ingredient(name: "Cabbage", expire: 7, weight: "1 head", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: true),
        Ingredient(name: "Tomato", expire: 4, weight: "1 kg", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: true),
        Ingredient(name: "Pepper", expire: 7, weight: "500 g", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: true),
        Ingredient(name: "Onion", expire: 14, weight: "1 kg", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: true),
        Ingredient(name: "Garlic", expire: 30, weight: "250 g", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: true),
        Ingredient(name: "Potato", expire: 30, weight: "2 kg", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: true),
        Ingredient(name: "Sweet potato", expire: 14, weight: "1 kg", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: true),
        Ingredient(name: "Zucchini", expire: 5, weight: "500 g", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: true),
        Ingredient(name: "Eggplant", expire: 7, weight: "500 g", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: true),
        Ingredient(name: "Cucumber", expire: 5, weight: "500 g", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: true),
        Ingredient(name: "Green beans", expire: 3, weight: "250 g", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: true),
        Ingredient(name: "Peas", expire: 3, weight: "250 g", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: true),
        Ingredient(name: "Corn", expire: 3, weight: "4 ears", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: true),
        Ingredient(name: "Corn", expire: 3, weight: "4 ears", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: true)
    ]
    @State private var existingIngredients: [Ingredient] = [
        Ingredient(name: "Broccoli", expire: -3, weight: "500 g", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: false),
        Ingredient(name: "Carrots", expire: -5, weight: "1 kg", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: false),
        Ingredient(name: "Tomatoes", expire: -4, weight: "750 g", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: false),
        Ingredient(name: "Lettuce", expire: 2, weight: "1 piece", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: false),
        Ingredient(name: "Apples", expire: 10, weight: "1 kg", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: false),
        Ingredient(name: "Bananas", expire: 5, weight: "1 kg", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: false),
        Ingredient(name: "Oranges", expire: 7, weight: "1 kg", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: false),
        Ingredient(name: "Beef", expire: 3, weight: "500 g", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: false),
        Ingredient(name: "Chicken breast", expire: 2, weight: "1 kg", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: false),
        Ingredient(name: "Pork", expire: 4, weight: "1 kg", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: false),
        Ingredient(name: "Eggs", expire: 5, weight: "12 pieces", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: false),
        Ingredient(name: "Milk", expire: 7, weight: "1 liter", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: false),
        Ingredient(name: "Flour", expire: 365, weight: "2.27 kg", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: false),
        Ingredient(name: "Black paper sauce", expire: 365, weight: "2.27 kg", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: false),
        Ingredient(name: "Sugar", expire: 365, weight: "907 g", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: false),
        Ingredient(name: "Salt", expire: 365, weight: "454 g", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: false),
        Ingredient(name: "Pepper", expire: 365, weight: "113 g", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: false)
    ]
    
    @State private var results:[Ingredient] = []
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    @State private var isSelectionView: Bool = false
    @State private var selectSort: Int = 0
    @State private var switchListView: Bool = false
    
    @State private var newIngredients:[Ingredient] = []
        
    var body: some View {
        VStack {
            NavigationStack {
                VStack {
                    HStack{
                        Spacer()
                        Button(action: selectionView, label: {
                            if isSelectionView {
                                Image(systemName: "checkmark.square.fill")
                                    .font(.system(size: 25))
                            } else {
                                Image(systemName: "checkmark.square")
                                    .font(.system(size: 25))
                            }
                            
                        })
                        Menu{
                            Button(action: { sortIngredients(sort: .expireDate) }) {
                                Image(systemName: "photo")
                                Text("Sort by expire date")
                            }
                            Button(action: { sortIngredients(sort: .createdAscending) }) {
                                Image(systemName: "photo")
                                Text("Sort by added date ascending")
                            }
                            Button(action: { sortIngredients(sort: .createdDescending) }) {
                                Image(systemName: "photo")
                                Text("Sort by added date descending")
                            }
                            Button(action: { sortIngredients(sort: .nameAscending) }) {
                                Image(systemName: "photo")
                                Text("Sort by name ascending")
                            }
                            Button(action: { sortIngredients(sort: .nameDescending) }) {
                                Image(systemName: "photo")
                                Text("Sort by name descending")
                            }
                        } label: {
                            Image("expire")
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
                        Button(action: switchView, label: {
                            Image("grid-view-rounded")
                                .resizable()
                                .frame(width: 25, height: 25)
                        })
                    }
                    .frame(height: 25, alignment: .trailing)
                    ScrollView {
                        LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                            IngredientsGridList(newIngredients: $newIngredients, isSelectionView: isSelectionView)
                        }
                    }
                    if isSelectionView {
                        Divider()
                        countSelectedIngredients(newIngredients: $newIngredients)
                    }
                }
                .navigationBarItems(
                    leading: HStack {
                        Spacer()
                        Text("Food Storage")
                            .font(.system(size: 28, weight: .bold))
                            .multilineTextAlignment(.center)
                        Spacer()
                    },
                    trailing: HStack {
                        Button(action: {
                            texts = []
                            results = []
                            existingIngredients = [
                                Ingredient(name: "Broccoli", expire: -3, weight: "500 g", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: false),
                                Ingredient(name: "Carrots", expire: -5, weight: "1 kg", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: false),
                                Ingredient(name: "Tomatoes", expire: -4, weight: "750 g", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: false),
                                Ingredient(name: "Lettuce", expire: 2, weight: "1 piece", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: false),
                                Ingredient(name: "Apples", expire: 10, weight: "1 kg", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: false),
                                Ingredient(name: "Bananas", expire: 5, weight: "1 kg", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: false),
                                Ingredient(name: "Oranges", expire: 7, weight: "1 kg", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: false),
                                Ingredient(name: "Beef", expire: 3, weight: "500 g", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: false),
                                Ingredient(name: "Chicken breast", expire: 2, weight: "1 kg", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: false),
                                Ingredient(name: "Pork", expire: 4, weight: "1 kg", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: false),
                                Ingredient(name: "Eggs", expire: 5, weight: "12 pieces", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: false),
                                Ingredient(name: "Milk", expire: 7, weight: "1 liter", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: false),
                                Ingredient(name: "Flour", expire: 365, weight: "2.27 kg", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: false),
                                Ingredient(name: "Black paper sauce", expire: 365, weight: "2.27 kg", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: false),
                                Ingredient(name: "Sugar", expire: 365, weight: "907 g", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: false),
                                Ingredient(name: "Salt", expire: 365, weight: "454 g", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: false),
                                Ingredient(name: "Pepper", expire: 365, weight: "113 g", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg", isSelected: false, isNew: false)
                            ]
                            newIngredients = existingIngredients + results
                        }, label: {
                            Text("Clear")
                        })
                        Button(action: {
                            self.showSannerSheet = true
                        }, label: {
                            Image(systemName: "plus")
                                .font(.system(size: 28, weight: .bold))
                        })
                    }
                )
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
    private func selectionView() {
        self.isSelectionView = !self.isSelectionView
    }
    private func sortIngredients(sort: Sort) {
        switch sort {
        case .expireDate:
            newIngredients = newIngredients.sorted(by: {$0.expire < $1.expire})
        case .createdAscending:
            print("")
        case .createdDescending:
            print("")
        case .nameAscending:
            newIngredients = newIngredients.sorted(by: {$0.name < $1.name})
        case .nameDescending:
            newIngredients = newIngredients.sorted(by: {$0.name > $1.name})
        }
        
    }
    private func switchView() {
        
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


struct IngredientsGridList: View {
    @Binding var newIngredients: [Ingredient]
    var isSelectionView: Bool;
    @State var viewWidth: CGFloat = 115;
    
    var body: some View {
        ForEach(newIngredients, id: \.id) { ingredient in
            VStack(spacing:6) {
                ZStack {
                    if ingredient.isSelected && isSelectionView {
                        Rectangle()
        //                Image(uiImage: "\(existingIngredient.image)".load())
        //                    .resizable()
                            .frame(width: viewWidth, height: 120)
        //                    .border(Color.gray, width: 2)
                            .opacity(0.3)
                    } else {
                        Rectangle()
        //                Image(uiImage: "\(existingIngredient.image)".load())
        //                    .resizable()
                            .frame(width: viewWidth, height: 120)
        //                    .border(Color.gray, width: 2)
                            .opacity(0.5)
                    }
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
            .border(Color.gray, width: 2)
            .cornerRadius(5)
            .contentShape(Rectangle())
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

struct countSelectedIngredients: View {
    @Binding var newIngredients: [Ingredient]
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
    }
}
