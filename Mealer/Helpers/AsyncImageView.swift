//
//  AsyncImageView.swift
//  Mealer
//
//  Created by Na Tian on 7/4/2023.
//

import SwiftUI
import Combine

struct AsyncImageView: View {
    @StateObject private var imageLoader = ImageLoader()
    let urlString: String?
    
    init(urlString: String?) {
        self.urlString = urlString
    }
    
    
    var image: some View {
        Group {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                Text("")
            }
        }
    }
    
    var body: some View {
        image.onAppear {
            if let urlString = urlString, let url = URL(string: urlString) {
                imageLoader.url = url
                imageLoader.load()
            }
        }
    }
}

final class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    var url: URL?
    
    func load() {
        guard let url = url else { return }
        URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: &$image)
    }
}
