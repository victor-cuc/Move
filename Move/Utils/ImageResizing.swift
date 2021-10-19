//
//  ImageResizing.swift
//  Move
//
//  Created by Victor Cuc on 18/10/2021.
//

import UIKit

extension UIImage {
    
    func scalePreservingAspectRatio(maxEdgeSize maxSize: CGFloat) -> UIImage {
        if self.size.height > maxSize || self.size.width > maxSize {
            return scalePreservingAspectRatio(targetSize: CGSize(width: maxSize, height: maxSize))
        } else {
            return self
        }
    }
    
    func scalePreservingAspectRatio(targetSize: CGSize) -> UIImage {
        // Determine the scale factor that preserves aspect ratio
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        
        let scaleFactor = min(widthRatio, heightRatio)
        
        // Compute the new image size that preserves aspect ratio
        let scaledImageSize = CGSize(
            width: size.width * scaleFactor,
            height: size.height * scaleFactor
        )

        // Draw and return the resized UIImage
        let renderer = UIGraphicsImageRenderer(
            size: scaledImageSize
        )

        let scaledImage = renderer.image { _ in
            self.draw(in: CGRect(
                origin: .zero,
                size: scaledImageSize
            ))
        }
        
        return scaledImage
    }
}
