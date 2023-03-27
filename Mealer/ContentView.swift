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
                    Image(systemName: "phone.fill")
                    Text("Recipe")
                }
            ViewFoodStorage()
                .tabItem() {
                    Image(systemName: "phone.fill")
                    Text("Food Storage")
                }
            ViewHealth()
                .tabItem() {
                    Image(systemName: "phone.fill")
                    Text("Health")
                }
            ViewCommunity()
                .tabItem() {
                    Image(systemName: "phone.fill")
                    Text("Community")
                }
            ViewProfile()
                .tabItem() {
                    Image(systemName: "phone.fill")
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

