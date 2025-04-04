//
//  pictureModel.swift
//  pin5Demo
//
//  Created by Aisha Suanbekova Bakytjankyzy on 04.04.2025.
//

import Foundation

struct Photo: Codable, Identifiable {
    let id: Int
    var url: String { "https://picsum.photos/id/\(id)/400/600" }
}
