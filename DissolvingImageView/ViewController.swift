//
//  ViewController.swift
//  Image View
//
//  Created by usagimaru on 2022/02/22.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet var imageView: UIImageView!
	@IBOutlet var reloadButton: UIButton!
	
	private weak var loadingTimer: Timer?
	private var previousImageIndex: Int?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.imageView.layer.cornerRadius = 17
		self.imageView.layer.cornerCurve = .continuous
		self.imageView.layer.borderColor = UIColor.separator.withAlphaComponent(0.15).cgColor
		self.imageView.layer.borderWidth = 1
		self.imageView.clipsToBounds = true
		self.imageView.contentMode = .scaleAspectFill
	}
	
	private func imageIndex() -> Int {
		func rand() -> Int { Int(arc4random() % 4) }
		var imageIndex = rand()
		
		if let previousImageIndex = self.previousImageIndex {
			while previousImageIndex == imageIndex {
				imageIndex = rand()
			}
		}
		
		self.previousImageIndex = imageIndex
		
		return imageIndex
	}
	
	@IBAction func reload(_ sender: Any) {
		print(#function)
				
		let imageIndex = imageIndex()
		
		self.imageView.image = nil
		self.loadingTimer?.invalidate()
		self.loadingTimer = Timer.scheduledTimer(withTimeInterval: 1.0,
												 repeats: false,
												 block: { timer in
			self.reloadButton.configurationUpdateHandler = { button in
				// 完了時の処理
				var config = button.configuration
				config?.showsActivityIndicator = false
				config?.title = "Reload"
				button.configuration = config
				button.isEnabled = true
			}
			
			self.setImage(imageIndex)
		})
		
		// ボタンの見た目を一時的に変更
		self.reloadButton.configurationUpdateHandler = { button in
			var config = button.configuration
			config?.showsActivityIndicator = true
			config?.title = "Loading..."
			button.configuration = config
			button.isEnabled = false
		}
		
		setPreloadImage(imageIndex)
	}
	
	/// プリロードイメージを設定
	private func setPreloadImage(_ index: Int) {
		if let thumbnail = UIImage(named: "thumbnail\(index)") {
			self.imageView.setPreloadImage(thumbnail, targetSize: self.imageView.frame.size)
		}
	}
	
	/// 本イメージを設定
	private func setImage(_ index: Int) {
		if let image = UIImage(named: "sample\(index)") {
			self.imageView.setImageDissolving(image)
		}
	}
	
}

