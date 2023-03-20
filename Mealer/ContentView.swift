//
//  ContentView.swift
//  Mealer
//
//  Created by Na Tian on 20/3/2023.
//

import SwiftUI
struct Ingredient: Identifiable {
    let name: String
    let id = UUID()
}

struct ContentView: View {
    @State private var showSannerSheet = false
    @State private var texts:[ScanData] = []
    @State private var veges:[Ingredient] = [
        Ingredient(name: "Spinach"),
        Ingredient(name: "Carrot"),
        Ingredient(name: "Broccoli"),
        Ingredient(name: "Cauliflower"),
        Ingredient(name: "Lettuce"),
        Ingredient(name: "Cabbage"),
        Ingredient(name: "Tomato"),
        Ingredient(name: "Pepper"),
        Ingredient(name: "Onion"),
        Ingredient(name: "Garlic"),
        Ingredient(name: "Potato"),
        Ingredient(name: "Sweet potato"),
        Ingredient(name: "Zucchini"),
        Ingredient(name: "Eggplant"),
        Ingredient(name: "Cucumber"),
        Ingredient(name: "Green beans"),
        Ingredient(name: "Peas"),
        Ingredient(name: "Corn")
    ]
    @State private var results:[Ingredient] = []
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    if texts.count > 0 {
                        List{
                            ForEach(texts){text in
                                NavigationLink(destination: ScrollView{Text(text.content)}, label: {
                                    Text(text.content).lineLimit(1)
                                })
                            }
                        }
                    }
//                    if results.count > 0 {
//                        List(results) {
//                            Text($0.name)
//                        }
//                    }
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
                    else{
                        Text("No ingredients yet").font(.title)
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
    private func makeScannerView() -> ScannerView {
        ScannerView(completion: {
            textPerPage in
            if let outputText = textPerPage?.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines) {
                let newScanData = ScanData(content: outputText)
                for vege in veges {
                    if (newScanData.content.contains(vege.name)) {
                        results.append(vege)
                    }
                }
                
                self.texts.append(newScanData)
            }
            self.showSannerSheet = false
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
