//
//  ImageService.swift
//  HealthyPet
//
//  Created by Kristina Motte on 25/09/2022.
//

import UIKit

typealias ImageCompletion = ((Result<UIImage, Error>) -> Void)

protocol ImageLoader {
    func loadImage(_ url: URL, _ completion: @escaping ImageCompletion) -> UUID?
    func cancelLoad(_ uuid: UUID)
}

/// Download and cache images
class ImageService: ImageLoader {
    private var loadedImages = [URL: UIImage]()
    private var runningRequests = [UUID: URLSessionDataTask]()
    private let cache = NSCache<NSString, UIImage>()
    
    func loadImage(_ url: URL, _ completion: @escaping ImageCompletion) -> UUID? {
        if let image = cache.object(forKey: url.absoluteString as NSString) {
            completion(.success(image))
            return nil
        }
        
        if let image = loadedImages[url] {
            completion(.success(image))
            return nil
        }
        
        let uuid = UUID()
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            defer { self.runningRequests.removeValue(forKey: uuid) }
            
            if let data = data, let image = UIImage(data: data) {
                self.loadedImages[url] = image
                self.cache.setObject(image, forKey: url.absoluteString as NSString)
                completion(.success(image))
                return
            }
            
            guard let error = error else {
                completion(.failure(error ?? APIError.Code.invalidResponse(description: "Invalid image data")))
                return
            }
            
            guard (error as NSError).code == NSURLErrorCancelled else {
                completion(.failure(error))
                return
            }
        }
        
        task.resume()
        
        runningRequests[uuid] = task
        return uuid
    }
    
    func cancelLoad(_ uuid: UUID) {
      runningRequests[uuid]?.cancel()
      runningRequests.removeValue(forKey: uuid)
    }
}
