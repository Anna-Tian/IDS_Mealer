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
    case expireDate, category, nameAscending, nameDescending
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
        Ingredient(name: "Spinach", expire: 3, weight: "250 g", image: "https://assets.woolworths.com.au/images/1005/194947.jpg?impolicy=wowsmkqiema&w=260&h=260", isSelected: false, isNew: true),
        Ingredient(name: "Carrot", expire: 7, weight: "500 g", image: "https://assets.woolworths.com.au/images/1005/135344.jpg?impolicy=wowsmkqiema&w=260&h=260", isSelected: false, isNew: true),
        Ingredient(name: "Broccoli", expire: 5, weight: "500 g", image: "https://assets.woolworths.com.au/images/1005/134681.jpg?impolicy=wowsmkqiema&w=260&h=260", isSelected: false, isNew: true),
        Ingredient(name: "Cauliflower", expire: 5, weight: "500 g", image: "https://assets.woolworths.com.au/images/1005/135552.jpg?impolicy=wowsmkqiema&w=260&h=260", isSelected: false, isNew: true),
        Ingredient(name: "Lettuce", expire: 2, weight: "1 pc", image: "https://assets.woolworths.com.au/images/1005/154340.jpg?impolicy=wowsmkqiema&w=260&h=260", isSelected: false, isNew: true),
        Ingredient(name: "Cabbage", expire: 7, weight: "1 head", image: "https://assets.woolworths.com.au/images/1005/134923.jpg?impolicy=wowsmkqiema&w=260&h=260", isSelected: false, isNew: true),
        Ingredient(name: "Tomato", expire: 4, weight: "1 kg", image: "https://assets.woolworths.com.au/images/1005/134034.jpg?impolicy=wowsmkqiema&w=260&h=260", isSelected: false, isNew: true),
        Ingredient(name: "Pepper", expire: 7, weight: "500 g", image: "https://assets.woolworths.com.au/images/1005/98800.jpg?impolicy=wowsmkqiema&w=260&h=260", isSelected: false, isNew: true),
        Ingredient(name: "Onion", expire: 14, weight: "1 kg", image: "https://assets.woolworths.com.au/images/1005/144329.jpg?impolicy=wowsmkqiema&w=260&h=260", isSelected: false, isNew: true),
        Ingredient(name: "Garlic", expire: 30, weight: "250 g", image: "https://assets.woolworths.com.au/images/1005/713429.jpg?impolicy=wowsmkqiema&w=260&h=260", isSelected: false, isNew: true),
        Ingredient(name: "Potato", expire: 30, weight: "2 kg", image: "https://assets.woolworths.com.au/images/1005/246566.jpg?impolicy=wowsmkqiema&w=260&h=260", isSelected: false, isNew: true),
        Ingredient(name: "Sweet potato", expire: 14, weight: "1 kg", image: "https://assets.woolworths.com.au/images/1005/147071.jpg?impolicy=wowsmkqiema&w=260&h=260", isSelected: false, isNew: true),
        Ingredient(name: "Zucchini", expire: 5, weight: "500 g", image: "https://assets.woolworths.com.au/images/1005/174172.jpg?impolicy=wowsmkqiema&w=260&h=260", isSelected: false, isNew: true),
        Ingredient(name: "Eggplant", expire: 7, weight: "500 g", image: "https://assets.woolworths.com.au/images/1005/174095.jpg?impolicy=wowsmkqiema&w=260&h=260", isSelected: false, isNew: true),
        Ingredient(name: "Cucumber", expire: 5, weight: "500 g", image: "https://assets.woolworths.com.au/images/1005/137130.jpg?impolicy=wowsmkqiema&w=260&h=260", isSelected: false, isNew: true),
        Ingredient(name: "Green beans", expire: 3, weight: "250 g", image: "https://assets.woolworths.com.au/images/1005/134072.jpg?impolicy=wowsmkqiema&w=260&h=260", isSelected: false, isNew: true),
        Ingredient(name: "Peas", expire: 15, weight: "500 g", image: "https://assets.woolworths.com.au/images/1005/96206.jpg?impolicy=wowsmkqiema&w=260&h=260", isSelected: false, isNew: true),
        Ingredient(name: "Corn", expire: 3, weight: "4 ears", image: "https://cdn0.woolworths.media/content/wowproductimages/large/149374.jpg", isSelected: false, isNew: true)
    ]
    @State private var existingIngredients: [Ingredient] = [
        Ingredient(name: "Broccoli", expire: -3, weight: "500 g", image: "https://assets.woolworths.com.au/images/1005/134681.jpg?impolicy=wowsmkqiema&w=260&h=260", isSelected: false, isNew: false),
        Ingredient(name: "Carrots", expire: -5, weight: "1 kg", image: "https://assets.woolworths.com.au/images/1005/135344.jpg?impolicy=wowsmkqiema&w=260&h=260", isSelected: false, isNew: false),
        Ingredient(name: "Tomatoes", expire: -4, weight: "750 g", image: "https://assets.woolworths.com.au/images/1005/134034.jpg?impolicy=wowsmkqiema&w=260&h=260", isSelected: false, isNew: false),
        Ingredient(name: "Lettuce", expire: 2, weight: "1 pc", image: "https://assets.woolworths.com.au/images/1005/154340.jpg?impolicy=wowsmkqiema&w=260&h=260", isSelected: false, isNew: false),
        Ingredient(name: "Apples", expire: 10, weight: "1 kg", image: "https://assets.woolworths.com.au/images/1005/120044.jpg?impolicy=wowsmkqiema&w=260&h=260", isSelected: false, isNew: false),
        Ingredient(name: "Bananas", expire: 5, weight: "1 kg", image: "https://assets.woolworths.com.au/images/1005/133211.jpg?impolicy=wowsmkqiema&w=260&h=260", isSelected: false, isNew: false),
        Ingredient(name: "Oranges", expire: 7, weight: "1 kg", image: "https://assets.woolworths.com.au/images/1005/259450.jpg?impolicy=wowsmkqiema&w=260&h=260", isSelected: false, isNew: false),
        Ingredient(name: "Beef", expire: 3, weight: "500 g", image: "https://upload.wikimedia.org/wikipedia/commons/6/60/Standing-rib-roast.jpg", isSelected: false, isNew: false),
        Ingredient(name: "Chicken breast", expire: 2, weight: "1 kg", image: "https://assets.woolworths.com.au/images/1005/710953.jpg?impolicy=wowsmkqiema&w=260&h=260", isSelected: false, isNew: false),
        Ingredient(name: "Pork", expire: 4, weight: "1 kg", image: "https://assets.woolworths.com.au/images/1005/675622.jpg?impolicy=wowsmkqiema&w=260&h=260", isSelected: false, isNew: false),
        Ingredient(name: "Eggs", expire: 5, weight: "12 pcs", image: "https://www.asiangroceronline.com.au/img/products/small/2346_egg-600g-dozen~7732.jpg?v=31Db7", isSelected: false, isNew: false),
        Ingredient(name: "Milk", expire: 7, weight: "1 liter", image: "https://cdn0.woolworths.media/content/wowproductimages/large/208064.jpg", isSelected: false, isNew: false),
        Ingredient(name: "Flour", expire: 365, weight: "2.27 kg", image: "https://assets.woolworths.com.au/images/1005/230949.jpg?impolicy=wowsmkqiema&w=260&h=260", isSelected: false, isNew: false),
        Ingredient(name: "Tomato sauce", expire: 365, weight: "2.27 kg", image: "https://assets.woolworths.com.au/images/1005/83563.jpg?impolicy=wowsmkqiema&w=260&h=260", isSelected: false, isNew: false),
        Ingredient(name: "Sugar", expire: 365, weight: "907 g", image: "https://assets.woolworths.com.au/images/1005/33156.jpg?impolicy=wowsmkqiema&w=260&h=260", isSelected: false, isNew: false),
        Ingredient(name: "Salt", expire: 365, weight: "454 g", image: "https://assets.woolworths.com.au/images/1005/111359.jpg?impolicy=wowsmkqiema&w=260&h=260", isSelected: false, isNew: false),
        Ingredient(name: "Pepper", expire: 365, weight: "113 g", image: "https://assets.woolworths.com.au/images/1005/98800.jpg?impolicy=wowsmkqiema&w=260&h=260", isSelected: false, isNew: false)
    ]
    
    @State private var results:[Ingredient] = []
    private let adaptiveColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State private var isSelectionView: Bool = false
    @State private var selectSort: Int = 0
    @State private var switchListView: Bool = false
    
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
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 25, weight: .bold))
                    })
                    Button(action: {
                        self.showSannerSheet = true
                    }, label: {
                        Image(systemName: "plus")
                            .font(.system(size: 28, weight: .bold))
                    })
                }
                VStack {
                    functionKeys(isSelectionView: $isSelectionView, newIngredients: $newIngredients)
                    ScrollView {
                        LazyVGrid(columns: adaptiveColumns, spacing: 8) {
                            IngredientsGridList(newIngredients: $newIngredients, isSelectionView: isSelectionView)
                        }
                    }
                    if isSelectionView {
                        Divider()
                        countSelectedIngredients(newIngredients: $newIngredients)
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


struct IngredientsGridList: View {
    @Binding var newIngredients: [Ingredient]
    var isSelectionView: Bool;
    @State var viewWidth: CGFloat = 110;
    
    var body: some View {
        ForEach(newIngredients, id: \.id) { ingredient in
            VStack(spacing:6) {
                ZStack {
                    VStack {
                        Image(uiImage: "\(ingredient.image)".load())
                            .resizable()
                            .frame(width: viewWidth-20, height: 100)
                            .opacity((ingredient.isSelected && isSelectionView) ? 0.3 : 0.8)
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
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(color: .gray, radius: 2, x: 1, y: 2)
            )
            .frame(width: viewWidth, height: 201, alignment: .top)
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

struct functionKeys: View {
    @Binding var isSelectionView: Bool
    @Binding var newIngredients: [Ingredient]
    var body: some View {
        HStack{
            Spacer()
            Button(action: {
                isSelectionView = !isSelectionView
            }, label: {
                if isSelectionView {
                    Image(systemName: "checkmark.square.fill").imageScale(.large)
                } else {
                    Image(systemName: "checkmark.square").imageScale(.large)
                }
                
            })
            
            Menu{
                Button(action: { sortIngredients(sort: .expireDate) }) {
                    Image(systemName: "photo")
                    Text("Sort by expire date")
                }
                Button(action: { sortIngredients(sort: .category) }) {
                    Image(systemName: "photo")
                    Text("Sort by category")
                }
                Button(action: { sortIngredients(sort: .nameAscending) }) {
                    Image(systemName: "photo")
                    Text("Sort by name A to Z")
                }
                Button(action: { sortIngredients(sort: .nameDescending) }) {
                    Image(systemName: "photo")
                    Text("Sort by name Z to A")
                }
            } label: {
                Image(systemName: "clock").imageScale(.large)
            }
            .disabled(isSelectionView)
            
            Button(action: switchView, label: {
                Image(systemName: "square.grid.2x2.fill").imageScale(.large)
            })
            .disabled(isSelectionView)
        }
        .frame(height: 25, alignment: .trailing)
    }
    
    private func sortIngredients(sort: Sort) {
        switch sort {
        case .expireDate:
            newIngredients = newIngredients.sorted(by: {$0.expire < $1.expire})
        case .category:
            print("")
        case .nameAscending:
            newIngredients = newIngredients.sorted(by: {$0.name < $1.name})
        case .nameDescending:
            newIngredients = newIngredients.sorted(by: {$0.name > $1.name})
        }
        
    }
    private func switchView() {
        
    }
}
