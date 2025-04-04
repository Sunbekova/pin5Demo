//
//  ViewController.swift
//  pin5Demo
//
//  Created by Aisha Suanbekova Bakytjankyzy on 04.04.2025.
//

import UIKit
import SwiftUI

class PinterestViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pinterest Clone"

        let viewModel = PhotoViewModel()
        let swiftUIView = GridView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: swiftUIView)

        addChild(hostingController)
        hostingController.view.frame = view.bounds
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
    }
}

// UIKit-SwiftUI Wrapper
struct PinterestViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> PinterestViewController {
        PinterestViewController()
    }

    func updateUIViewController(_ uiViewController: PinterestViewController, context: Context) {}
}
