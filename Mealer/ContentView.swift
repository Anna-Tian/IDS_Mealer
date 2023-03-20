//
//  ContentView.swift
//  Mealer
//
//  Created by Na Tian on 20/3/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showSannerSheet = false
    @State private var texts:[ScanData] = []
    var body: some View {
        VStack {
            NavigationView{
                VStack{
                    if texts.count > 0 {
                        List{
                            ForEach(texts){text in
                                NavigationLink(destination: ScrollView{Text(text.content)}, label: {
                                    Text(text.content).lineLimit(1)
                                })
                            }
                        }
                    }
                    else{
                        Text("No ingredients yet").font(.title)
                    }
                }
                    .navigationTitle("Food Storage")
                    .navigationBarItems(trailing:
                        Button(action: {
                        self.showSannerSheet = true
                    }, label: {
                        Image(systemName:
                            "plus")
                        .font(.title)
                    }))
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
