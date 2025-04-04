//
//  GridView.swift
//  pin5Demo
//
//  Created by Aisha Suanbekova Bakytjankyzy on 04.04.2025.
//

import SwiftUI

struct GridView: View {
    @ObservedObject var viewModel: PhotoViewModel

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 10) {
                ForEach(viewModel.photos) { photo in
                    AsyncImageView(photoID: photo.id, viewModel: viewModel)
                        .frame(height: 200)
                        .clipped()
                        .onAppear {
                            if photo.id == viewModel.photos.last?.id { // Fix for infinite scroll check
                                viewModel.fetchPhotos()
                            }
                        }
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.fetchPhotos()
        }
    }
}
