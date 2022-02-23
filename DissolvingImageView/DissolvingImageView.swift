//
//  DissolvingImageView.swift
//  DissolvingImageView
//
//  Created by usagimaru on 2022/02/22.
//

import UIKit
import CoreImage.CIFilterBuiltins

extension UIImageView {
	
	private func resizedImage(_ sourceImage: CIImage, targetSize: CGSize) -> CIImage {
		var scale: CGFloat {
			if targetSize.width < targetSize.height {
				return targetSize.width / sourceImage.extent.width
			}
			else {
				return targetSize.height / sourceImage.extent.height
			}
		}
		
		//let aspectRatio = targetSize.width / (sourceImage.extent.width * scale)
		let filteredImage = sourceImage.applyingFilter("CILanczosScaleTransform",
													   parameters: [
														kCIInputScaleKey : scale,
														//kCIInputAspectRatioKey : aspectRatio
													   ])
		return filteredImage
	}
	
	private func bluredImage(_ sourceImage: CIImage, blurRadius: Double = 5.0) -> CIImage {
		let filteredImage = sourceImage
			.clampedToExtent()
			.applyingGaussianBlur(sigma: blurRadius)
			.cropped(to: sourceImage.extent)
			//.insertingIntermediate()
		return filteredImage
	}
	
	func setPreloadImage(_ image: UIImage, targetSize: CGSize? = nil) {
		guard var inputImage = CIImage(image: image) else
		{ return }
		
		if let targetSize = targetSize {
			inputImage = resizedImage(inputImage, targetSize: targetSize)
		}
		let bluredImage = bluredImage(inputImage)
		let resultImage = UIImage(ciImage: bluredImage)
		
		self.image = nil
		setImageDissolving(resultImage)
	}
	
	func setImageDissolving(_ image: UIImage, duration: TimeInterval = 0.25) {
		let anim = CATransition()
		anim.type = .fade
		anim.duration = duration
		self.layer.add(anim, forKey: "Dissolve")
		self.image = image
	}

}
