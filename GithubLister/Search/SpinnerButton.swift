//Created by Lugalu on 07/02/25.

import UIKit

class SpinnerButton: UIButton {
	
	var spinner = {
		let spinner = UIActivityIndicatorView()
		spinner.translatesAutoresizingMaskIntoConstraints = false
		spinner.hidesWhenStopped = true
		spinner.color = .tintColor
		spinner.style = .medium
		return spinner
	}()
	var isLoading = false {
		didSet {
			updateView()
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		makeUI()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		makeUI()
	}
	
	func makeUI() {
		addSubview(spinner)
		spinner.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor)
		])
	}
	
	func updateView() {
		if isLoading {
			spinner.startAnimating()
			titleLabel?.alpha = 0
			imageView?.alpha = 0
			isEnabled = false
			return
		}
		
		spinner.stopAnimating()
		titleLabel?.alpha = 1
		imageView?.alpha = 0
		isEnabled = true
	}
}
