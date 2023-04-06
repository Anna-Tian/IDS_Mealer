//
//  ContentView.swift
//  Mealer
//
//  Created by Na Tian on 20/3/2023.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        NavigationView {
            TabView {
                ViewRecipeList()
                    .tabItem() {
                        Image(systemName: "text.book.closed.fill")
                        Text("Recipe")
                    }
                ViewFoodStorage()
                    .tabItem() {
                        Image(systemName: "basket")
                        Text("Food Storage")
                    }
                ViewHealth()
                    .tabItem() {
                        Image(systemName: "chart.xyaxis.line")
                        Text("Health")
                    }
                ViewProfile()
                    .tabItem() {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

