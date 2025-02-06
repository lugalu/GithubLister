//Created by Lugalu on 05/02/25.

import UIKit

protocol SearchControllerDelegate {
	func showAlert(withMessage: String)
	func showLoading()
	func dismissLoading()
	func displayList(user: User)
}

class SearchController: UIViewController, SearchControllerDelegate {
	
	private var model: SearchModel
	
	lazy var textField: UITextField = {
		let text = UITextField()
		text.placeholder = "Username"
		text.translatesAutoresizingMaskIntoConstraints = false
		text.delegate = self
		text.returnKeyType = .done
		text.borderStyle = .roundedRect
		text.backgroundColor = .secondarySystemBackground
		
		return text
	}()
	
	lazy var submitButton: UIButton = {
		let action = UIAction { [weak self] _ in
			//			model
			
		}
		
		var configuration: UIButton.Configuration = .bordered()
		configuration.title = "Search"
		
		let btn = UIButton(configuration: configuration, primaryAction: action)
		btn.translatesAutoresizingMaskIntoConstraints = false
		
		return btn
	}()
	
	init(model: SearchModel) {
		self.model = model
		super.init(nibName: nil, bundle: nil)
		model.assign(delegate: self)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "Github Viewer"
		view.backgroundColor = .systemBackground
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		setupUI()
	}
	
	func showAlert(withMessage message: String) {
		let alert = UIAlertController(
			title: "Error",
			message: message,
			preferredStyle: .alert
		)
		
		let action = UIAlertAction(title: "Ok", style: .default)
		
		alert.addAction(action)
		self.present(alert, animated: true)
	}
	
	func showLoading() {
		submitButton.isEnabled = false
	}
	
	func dismissLoading() {
		submitButton.isEnabled = true
	}
	
	func displayList(user: User) {
		
	}
}

extension SearchController {
	
	func setupUI() {
		let gesture = UITapGestureRecognizer(target: self, action: #selector(onTap))
		gesture.isEnabled = true
		view.addSubview(textField)
		view.addSubview(submitButton)
		view.addGestureRecognizer(gesture)
		
		makeTextfieldConstraints()
		makeButtonConstraints()
	}
	
	func makeTextfieldConstraints() {
		let constraints = [
			textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
			textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
		]
		
		NSLayoutConstraint.activate(constraints)
	}
	
	func makeButtonConstraints() {
		let constraints = [
			submitButton.topAnchor
				.constraint(equalTo: textField.bottomAnchor, constant: 16),
			submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
		]
		
		NSLayoutConstraint.activate(constraints)
	}
}

extension SearchController: UITextFieldDelegate {
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return false
	}
	
	@objc
	func onTap() {
		textField.resignFirstResponder()
	}
	
}


