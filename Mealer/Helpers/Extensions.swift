//
//  Extensions.swift
//  Mealer
//
//  Created by Na Tian on 4/4/2023.
//

import SwiftUI

extension View {
    func backgroundCard(isSelected: Bool, expireDay: Int) -> some View {
        self.background(
            RoundedRectangle(cornerRadius: 5)
                .fill(isSelected ? Color.accentColor : Color.white)
                .shadow(color: expireDay > 0 ? expireDay < 3 ? Color.yellow : Color.gray : Color.red, radius: 2, x: 0, y: 0)
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

extension String {
    func load() -> UIImage {
        do {
            // convert string to URL
            guard let url = URL(string: self) else {
                // return empty image if the URL is invalid
                return UIImage()
            }
            //convert URL to data
            let data: Data = try Data(contentsOf: url)
            // create UIImage object from Data and optional value if the image in URL does not exists
            return UIImage(data: data) ?? UIImage()
        } catch {
            
        }
        return UIImage()
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
