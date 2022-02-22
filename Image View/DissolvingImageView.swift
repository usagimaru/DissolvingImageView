//
//  DissolvingImageView.swift
//  Image View
//
//  Created by usagimaru on 2022/02/22.
//

import UIKit
import CoreImage.CIFilterBuiltins

class DissolvingImageView: UIImageView {
	
	private func bluredImage(_ source: UIImage, blurRadius: Double = 5.0) -> UIImage {
		let radius = blurRadius
		guard let sourceImage = CIImage(image: source) else
		{ return source }
		
		let filteredImage = sourceImage
			.clampedToExtent()
			.applyingGaussianBlur(sigma: radius)
			.cropped(to: sourceImage.extent)
			//.insertingIntermediate()
		
		return UIImage(ciImage: filteredImage)
	}
	
	func setPreloadImage(_ baseImage: UIImage) {
		let bluredImage = bluredImage(baseImage)
		self.image = nil
		setImageDissolving(bluredImage)
	}
	
	func setImageDissolving(_ image: UIImage, duration: TimeInterval = 0.25) {
		let anim = CATransition()
		anim.type = .fade
		anim.duration = duration
		self.layer.add(anim, forKey: "Dissolve")
		self.image = image
	}

}
