//
//  IngredientDetailView.swift
//  Mealer
//
//  Created by Na Tian on 3/4/2023.
//

import SwiftUI

struct IngredientDetailView: View {
    @Binding var ingredient: Ingredient
    @State var manualExpirationDate: Date?
    @State var manualQuantityNumText = "0"
    private var manualQuantityNum: Int {
        return Int(manualQuantityNumText) ?? 0
    }
    @State var manualQuantityUnit: String = "kg"
    
    @State var showPopup: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                VStack {
                    if ingredient.image.contains("https") {
                        Image(uiImage: "\(ingredient.image)".load())
                            .resizable()
                            .frame(height: UIScreen.main.bounds.height * 0.5)
                            .padding()
                    } else {
                        Image(ingredient.image)
                            .resizable()
                            .frame(height: UIScreen.main.bounds.height * 0.5)
                            .padding()
                    }
                    Spacer()
                }
                ZStack(alignment: .topLeading) {
                    RoundedRectangle(cornerRadius: 50)
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height * 0.6)
                    VStack(alignment: .leading, spacing: 15) {
                        Text(ingredient.name)
                            .font(.system(size: 28, weight: .medium))
                        Text("Added on \(ingredient.createdDate.formatted(date: .complete, time: .omitted))")
                            .font(.system(size: 19))
                        
                        Text("Detail")
                            .font(.system(size: 28, weight: .medium))
                        HStack {
                            Image("Icons/fish")
                                .resizable()
                                .frame(width: 34, height: 34)
                            Text("Protein: \(ingredient.nutrition.protein) / 100g")
                                .font(.system(size: 19))
                        }
                        HStack {
                            Image("Icons/carbon")
                                .resizable()
                                .frame(width: 34, height: 34)
                            Text("Carbon: \(ingredient.nutrition.carbon) / 100g")
                                .font(.system(size: 19))
                        }
                        HStack {
                            Image("Icons/fat")
                                .resizable()
                                .frame(width: 34, height: 34)
                            Text("Fat: \(ingredient.nutrition.fat) / 100g")
                                .font(.system(size: 19))
                        }
                        HStack {
                            Image("Icons/symbols")
                                .resizable()
                                .frame(width: 34, height: 34)
                            Text("Category: \(ingredient.category)")
                                .font(.system(size: 19))
                        }
                        HStack {
                            Image("Icons/basket")
                                .resizable()
                                .frame(width: 34, height: 34)
                            HStack {
                                Text("Quantity: ")
                                    .font(.system(size: 19))
                                    .foregroundColor(Color.black)
                                Button(action: {
                                    withAnimation{
                                        showPopup.toggle()
                                    }
                                }) {
                                    Text("\(ingredient.weight)")
                                        .padding(.vertical, 5)
                                        .padding(.horizontal)
                                        .font(.system(size: 19))
                                        .foregroundColor(Color.black)
                                        .background(
                                            RoundedRectangle(cornerRadius: 5)
                                                .fill(Color.gray.opacity(0.2))
                                        )
                                }
                                
                            }
                        }
                        HStack {
                            Image(systemName: "calendar")
                                .resizable()
                                .padding(3)
                                .foregroundColor(Color.accentColor)
                                .frame(width: 34, height: 34)
                            HStack {
                                Text("Expiry Date:")
                                    .font(.system(size: 19))
                                    .foregroundColor(Color.black)
                                DatePicker(
                                    "",
                                    selection: Binding(
                                        get: { manualExpirationDate ?? ingredient.createdDate },
                                        set: { manualExpirationDate = $0 }
                                    ),
                                    displayedComponents: [.date]
                                )
                                .onChange(of: manualExpirationDate) { newDate in
                                    let expireInterval = Calendar.current.dateComponents([.day], from: ingredient.createdDate, to: newDate!).day!
                                    ingredient.expire = expireInterval
                                }
                                .labelsHidden()
                            }
                        }
                    }
                    .padding(40)
                }
            }
            .edgesIgnoringSafeArea(.vertical)
            .onAppear() {
                let weightParts = ingredient.weight.split(separator: " ")
                if let numText = weightParts.first, let unit = weightParts.last {
                    manualQuantityNumText = String(numText)
                    if let lastChar = unit.last, lastChar == "s", let num = Int(numText), num > 1 {
                        // Remove the "s" from the end of the unit string
                        manualQuantityUnit = String(unit.dropLast())
                    } else {
                        manualQuantityUnit = String(unit)
                    }
                }
                calculateManualExperiationDate()
            }
        }
        .popupNavigationView(show: $showPopup, horizontalPadding: 100, heightDouble: 4) {
            VStack {
                Spacer()
                HStack {
                    TextField("Quantity", text: $manualQuantityNumText)
                        .keyboardType(.numberPad)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 100)
                    
                    Picker("", selection: $manualQuantityUnit) {
                        ForEach(quantityUnits, id: \.self) { unit in
                            Text(unit)
                        }
                    }
                    .labelsHidden()
                }
                Spacer()
                Button(action: {
                    if let num = Int(manualQuantityNumText), num > 1,
                       !["kg", "g", "L", "ml"].contains(manualQuantityUnit) {
                        manualQuantityUnit += "s"
                    }
                    let newWeight = "\(manualQuantityNumText) \(manualQuantityUnit)"
                    ingredient.weight = newWeight
                    
                    withAnimation{showPopup.toggle()}
                }, label: {
                    Text("Save")
                })
                Spacer()
            }
            .navigationTitle("Modify Quantity")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { withAnimation{showPopup.toggle()} }) {
                        Image(systemName: "xmark")
                            .padding(5)
                            .background(
                                Circle()
                                    .fill(Color.white)
                                    .shadow(color: .gray, radius: 2, x: 0, y: 0)
                            )
                            .foregroundColor(Color.black)
                    }
                }
            }
        }
    }
    
    private func calculateManualExperiationDate() {
        manualExpirationDate = Calendar.current.date(byAdding: .day, value: ingredient.expire, to: ingredient.createdDate)
    }
}

struct IngredientDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sample = Ingredient(name: "Apples", expire: 10, weight: "1 kg", image: "Ingredients/Apples", isSelected: false, isNew: false, category: "Fruit", nutrition: Nutrition(name: "Apples", protein: 0, carbon: 14, fat: 0), createdDate: DateComponents(calendar: Calendar.current, year: 2023, month: 4, day: 3).date!)
        IngredientDetailView(ingredient: Binding.constant(sample))
    }
}
