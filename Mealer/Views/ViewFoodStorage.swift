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
        Ingredient(name: "Spinach", expire: 3, weight: "250 g", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg"),
        Ingredient(name: "Carrot", expire: 7, weight: "500 g", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg"),
        Ingredient(name: "Broccoli", expire: 5, weight: "500 g", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg"),
        Ingredient(name: "Cauliflower", expire: 5, weight: "500 g", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg"),
        Ingredient(name: "Lettuce", expire: 2, weight: "1 piece", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg"),
        Ingredient(name: "Cabbage", expire: 7, weight: "1 head", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg"),
        Ingredient(name: "Tomato", expire: 4, weight: "1 kg", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg"),
        Ingredient(name: "Pepper", expire: 7, weight: "500 g", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg"),
        Ingredient(name: "Onion", expire: 14, weight: "1 kg", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg"),
        Ingredient(name: "Garlic", expire: 30, weight: "250 g", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg"),
        Ingredient(name: "Potato", expire: 30, weight: "2 kg", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg"),
        Ingredient(name: "Sweet potato", expire: 14, weight: "1 kg", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg"),
        Ingredient(name: "Zucchini", expire: 5, weight: "500 g", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg"),
        Ingredient(name: "Eggplant", expire: 7, weight: "500 g", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg"),
        Ingredient(name: "Cucumber", expire: 5, weight: "500 g", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg"),
        Ingredient(name: "Green beans", expire: 3, weight: "250 g", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg"),
        Ingredient(name: "Peas", expire: 3, weight: "250 g", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg"),
        Ingredient(name: "Corn", expire: 3, weight: "4 ears", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg"),
        Ingredient(name: "Corn", expire: 3, weight: "4 ears", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg")
    ]
    @State private var existingIngredients: [Ingredient] = [
        Ingredient(name: "Broccoli", expire: -3, weight: "500 g", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg"),
        Ingredient(name: "Carrots", expire: -5, weight: "1 kg", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg"),
        Ingredient(name: "Tomatoes", expire: -4, weight: "750 g", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg"),
        Ingredient(name: "Lettuce", expire: 2, weight: "1 piece", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg"),
        Ingredient(name: "Apples", expire: 10, weight: "1 kg", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg"),
        Ingredient(name: "Bananas", expire: 5, weight: "1 kg", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg"),
        Ingredient(name: "Oranges", expire: 7, weight: "1 kg", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg"),
        Ingredient(name: "Beef", expire: 3, weight: "500 g", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg"),
        Ingredient(name: "Chicken breast", expire: 2, weight: "1 kg", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg"),
        Ingredient(name: "Pork", expire: 4, weight: "1 kg", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg"),
        Ingredient(name: "Eggs", expire: 5, weight: "12 pieces", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg"),
        Ingredient(name: "Milk", expire: 7, weight: "1 liter", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg"),
        Ingredient(name: "Flour", expire: 365, weight: "2.27 kg", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg"),
        Ingredient(name: "Black paper sauce", expire: 365, weight: "2.27 kg", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg"),
        Ingredient(name: "Sugar", expire: 365, weight: "907 g", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg"),
        Ingredient(name: "Salt", expire: 365, weight: "454 g", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg"),
        Ingredient(name: "Pepper", expire: 365, weight: "113 g", image: "https://healthjade.com/wp-content/uploads/2017/10/apple-fruit.jpg")
    ]
    
    @State private var results:[Ingredient] = []
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    @State private var isSelectionView: Bool = false
    @State private var selectSort: Int = 0
    @State private var switchListView: Bool = false
    
    @State private var countSelected: Int = 0
    
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
                        Button(action: sortIngredients, label: {
                            Image("expire")
                                .resizable()
                                .frame(width: 25, height: 25)
                        })
                        Button(action: switchView, label: {
                            Image("grid-view-rounded")
                                .resizable()
                                .frame(width: 25, height: 25)
                        })
                    }
                    .frame(height: 25, alignment: .trailing)
                    ScrollView {
                        LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                            ForEach(existingIngredients) { existingIngredient in
                                IngredientsGridList(existingIngredient: existingIngredient, isSelectionView: isSelectionView, countSelected: $countSelected)
                            }
                        }
                    }
                    if isSelectionView {
                        Divider()
                        countSelectedIngredients(countIngredients: countSelected)
                    }
                    if results.count > 0 {
                        Text("\(results.count)")
                        ScrollView {
                            LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                                ForEach(results) { result in
                                    ZStack {
                                        Rectangle()
                                            .frame(width: 100, height: 100)
                                            .foregroundColor(.mint)
                                            .cornerRadius(30)
                                        Text("\(result.name)")
                                            .font(.system(size: 16, weight: .medium))
                                    }
                                }
                            }
                        }
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
        
    }
    private func selectionView() {
        self.isSelectionView = !self.isSelectionView
    }
    private func sortIngredients() {
        
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
    var existingIngredient: Ingredient;
    var isSelectionView: Bool;
    @State var viewWidth: CGFloat = 115;
    
    @State var isSelected: Bool = false;
    @Binding var countSelected: Int;
    
    var body: some View {
        VStack(spacing:6) {
            ZStack {
                Rectangle()
//                Image(uiImage: "\(existingIngredient.image)".load())
//                    .resizable()
                    .frame(width: viewWidth, height: 120)
//                    .border(Color.gray, width: 2)
                    .opacity(0.5)
                if existingIngredient.expire > 0 {
                    Text("\(existingIngredient.expire) days")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(
                            Color.black.shadow(
                                .drop(color: .white, radius: 1, x: 1, y: 1)
                            )
                        )
                } else {
                    Text("Expired \(abs(existingIngredient.expire)) days")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(
                            Color.red.shadow(
                                .drop(color: .white, radius: 1, x: 1, y: 1)
                            )
                        )
                }
            }
            Text("\(existingIngredient.name)")
                .font(.system(size: 16, weight: .medium))
                .frame(width: viewWidth, height: 40, alignment: .top)
                .multilineTextAlignment(.center)
                .lineLimit(2)
            //                                        .border(Color.gray, width: 2)
            HStack {
                Text("\(existingIngredient.weight)")
                //                                            .border(Color.gray, width: 2)
                    .frame(height: 20, alignment: .top)
                Spacer()
                if (isSelectionView) {
                    if (isSelected == true) {
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
            if(isSelectionView) {
                isSelected = !isSelected;
                countSelected = isSelected ? countSelected+1 : countSelected-1;
            }
        }
    }
}

struct countSelectedIngredients: View {
    var countIngredients: Int
    @State private var isShowingDialog: Bool = false
    
    var body: some View {
        HStack {
            Spacer()
//            Text("\(countIngredients) select ingredient")
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
}
