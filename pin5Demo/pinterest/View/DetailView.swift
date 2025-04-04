//
//  DetailView.swift
//  pin5Demo
//
//  Created by Aisha Suanbekova Bakytjankyzy on 04.04.2025.
//

import UIKit
import SwiftUI

struct DetailView: View {
    let photo: Photo

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: photo.url))
                .scaledToFit()
            Spacer()
        }
        .navigationTitle("Photo #\(photo.id)")
    }
}
