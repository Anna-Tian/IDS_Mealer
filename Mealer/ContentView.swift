//
//  ContentView.swift
//  Mealer
//
//  Created by Na Tian on 20/3/2023.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        TabView {
            ViewRecipe()
                .tabItem() {
                    Image(systemName: "book.closed")
                    Text("Recipe")
                }
            ViewFoodStorage()
                .tabItem() {
                    Image(systemName: "basket")
                    Text("Food Storage")
                }
            ViewHealth()
                .tabItem() {
                    Image(systemName: "heart.circle")
                    Text("Health")
                }
            ViewCommunity()
                .tabItem() {
                    Image(systemName: "fork.knife")
                    Text("Community")
                }
            ViewProfile()
                .tabItem() {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

