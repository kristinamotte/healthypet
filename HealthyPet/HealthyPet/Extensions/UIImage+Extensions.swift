//
//  UIImage+Extensions.swift
//  HealthyPet
//
//  Created by Kristina Motte on 23.06.2022.
//

import UIKit

extension UIImage {
    convenience init?(color: UIColor, size: CGSize) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}

extension UIImageView {
    func loadImage(at url: URL, placeholder: UIImage?, completion: @escaping () -> Void) {
        UIImageLoader.loader.load(url, for: self, placeholder: placeholder, completion: completion)
    }
    
    func cancelImageLoad() {
        UIImageLoader.loader.cancel(for: self)
    }
}
