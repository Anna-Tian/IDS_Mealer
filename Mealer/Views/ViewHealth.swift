//
//  ViewHealth.swift
//  Mealer
//
//  Created by Na Tian on 27/3/2023.
//

import SwiftUI

struct Nutrition: Identifiable {
    let id = UUID()
    var name: String
    var protein: Int
    var carbon: Int
    var fat: Int
}

struct ViewHealth: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ViewHealth_Previews: PreviewProvider {
    static var previews: some View {
        ViewHealth()
    }
}
