//
//  ScanData.swift
//  Mealer
//
//  Created by Na Tian on 20/3/2023.
//

import Foundation


struct ScanData:Identifiable {
    var id = UUID()
    let content: String
    
    init(content: String) {
        self.content = content
    }
}
