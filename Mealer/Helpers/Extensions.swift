//
//  Extensions.swift
//  Mealer
//
//  Created by Na Tian on 4/4/2023.
//

import SwiftUI

extension View {
    func backgroundCard(isSelected: Bool) -> some View {
        self.background(
            RoundedRectangle(cornerRadius: 5)
                .fill(isSelected ? Color.accentColor.opacity(0.6) : Color.white)
                .shadow(color: .gray, radius: 2, x: 0, y: 0)
        )
    }
    
    func popupNavigationView<Content: View>(show: Binding<Bool>, horizontalPadding: CGFloat = 40, heightDouble: Double = 1.7, @ViewBuilder content: @escaping ()->Content)->some View{
        return self
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .overlay {
                if show.wrappedValue{
                    
                    // MARK: Geometry Reader for reading Container Frame
                    GeometryReader{proxy in
                        
                        Color.primary
                            .opacity(0.15)
                            .ignoresSafeArea()
                        
                        let size = proxy.size
                        
                        NavigationView{
                            content()
                        }
                        .frame(width: size.width - horizontalPadding, height: size.height / heightDouble, alignment: .center)
                        // Corner Radius
                        .cornerRadius(30)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    }
                }
            }
    }
}
