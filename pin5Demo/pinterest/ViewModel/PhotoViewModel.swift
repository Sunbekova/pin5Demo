import UIKit
import SwiftUI

class PhotoViewModel: ObservableObject {
    @Published var photos: [Photo] = []
    @Published var errorMessage: String? = nil
    private var currentPage = 1
    private var isLoading = false
    private var cache = NSCache<NSNumber, UIImage>()
    private let cacheQueue = DispatchQueue(label: "com.pinterestClone.cacheQueue", attributes: .concurrent)

    func fetchPhotos(reset: Bool = false) {
        guard !isLoading else { return }
        isLoading = true
        if reset { currentPage = 1; photos.removeAll() }

        let group = DispatchGroup()
        var newPhotos: [Photo] = []

        for id in (currentPage * 10 - 9)...(currentPage * 10) {
            group.enter()
            fetchPhoto(id: id) { [weak self] result in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch result {
                    case .success(let photo):
                        newPhotos.append(photo)
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                    }
                    group.leave()
                }
            }
        }

        group.notify(queue: .main) {
            self.photos.append(contentsOf: newPhotos)
            self.currentPage += 1
            self.isLoading = false
        }
    }

    func fetchPhoto(id: Int, completion: @escaping (Result<Photo, Error>) -> Void) {
        let photo = Photo(id: id)
        completion(.success(photo))
    }


    func loadImage(for id: Int, completion: @escaping (UIImage?) -> Void) {
        cacheQueue.sync {
            if let cachedImage = cache.object(forKey: NSNumber(value: id)) {
                DispatchQueue.main.async {
                    completion(cachedImage)
                }
                return
            }
        }

        let urlString = "https://picsum.photos/id/\(id)/300/400"
        guard let url = URL(string: urlString) else { return }

        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                self.cacheQueue.async(flags: .barrier) {
                    self.cache.setObject(image, forKey: NSNumber(value: id))
                }
                DispatchQueue.main.async { completion(image) }
            } else {
                DispatchQueue.main.async { completion(nil) }
            }
        }
    }
}
