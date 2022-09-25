//
//  UIImageLoader.swift
//  HealthyPet
//
//  Created by Kristina Motte on 25/09/2022.
//

import UIKit

class UIImageLoader {
    static let loader = UIImageLoader()
    
    private let imageLoader: ImageLoader = ImageService()
    private var uuidMap = [UIImageView: UUID]()
    
    private init() {}
    
    func load(_ url: URL, for imageView: UIImageView, placeholder: UIImage?, completion: @escaping () -> Void) {
        let token = imageLoader.loadImage(url) { result in
            defer { self.uuidMap.removeValue(forKey: imageView) }
            
            do {
                let image = try result.get()
                DispatchQueue.main.async {
                    imageView.image = image
                    completion()
                }
            } catch {
                DispatchQueue.main.async {
                    imageView.image = placeholder
                    completion()
                }
            }
        }
        
        if let token = token {
            uuidMap[imageView] = token
        }
    }
    
    func cancel(for imageView: UIImageView) {
        if let uuid = uuidMap[imageView] {
            imageLoader.cancelLoad(uuid)
            uuidMap.removeValue(forKey: imageView)
        }
    }
}
