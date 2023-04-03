//
//  IngredientDetailView.swift
//  Mealer
//
//  Created by Na Tian on 3/4/2023.
//

import SwiftUI

struct IngredientDetailView: View {
    var ingredient: Ingredient
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Image(ingredient.image)
                    .resizable()
                    .frame(height: UIScreen.main.bounds.height * 0.5)
                    .padding()
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
                            Button {
                                
                            } label: {
                                Text(ingredient.weight)
                                    .font(.system(size: 19))
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
                            Text("Expiration Date: ")
                                .font(.system(size: 19))
                                .foregroundColor(Color.black)
                            Button {
                                
                            } label: {
                                Text("\(Calendar.current.date(byAdding: .day, value: ingredient.expire, to: ingredient.createdDate)!.formatted(date: .abbreviated, time: .omitted))")
                                    .font(.system(size: 19))
//                                    .background(Color(uiColor: UIColor.lightGray))
                            }
                        }
                    }
                }
                .padding(40)
            }
        }
        .edgesIgnoringSafeArea(.vertical)
    }
}

struct IngredientDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sample = Ingredient(name: "Apples", expire: 10, weight: "1 kg", image: "Ingredients/Apples", isSelected: false, isNew: false, category: "Fruit", nutrition: Nutrition(name: "Apples", protein: 0, carbon: 14, fat: 0), createdDate: DateComponents(calendar: Calendar.current, year: 2023, month: 4, day: 3).date!)
        IngredientDetailView(ingredient: sample)
    }
}
