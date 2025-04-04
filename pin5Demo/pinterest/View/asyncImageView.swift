//
//  AsyncImageView.swift
//  pin5Demo
//
//  Created by Aisha Suanbekova Bakytjankyzy on 04.04.2025.
//
import UIKit
import SwiftUI

struct AsyncImageView: View {
    let photoID: Int
    @ObservedObject var viewModel: PhotoViewModel
    @State private var image: UIImage?

    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                Color.gray.opacity(0.3)
                    .onAppear {
                        viewModel.loadImage(for: photoID) { loadedImage in
                            self.image = loadedImage
                        }
                    }
            }
        }
        .frame(width: 150, height: 200)
        .cornerRadius(10)
        .shadow(radius: 3)
    }
}
