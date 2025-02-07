//Created by Lugalu on 05/02/25.

import UIKit

protocol SearchViewControllerDelegate {
	func showAlert(withMessage: String)
	func isLoading() -> Bool
	func showLoading()
	func dismissLoading()
	func displayList(user: User)
}

class SearchViewController: UIViewController, SearchViewControllerDelegate {
	
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
	
	lazy var submitButton: SpinnerButton = {
		let action = UIAction { [weak self] _ in
			guard let name = self?.textField.text, !name.isEmpty else {
				return
			}
			self?.model.fetchUser(withName: name)
		}
		
		var configuration: UIButton.Configuration = .plain()
		configuration.title = "Search"
		
		let btn = SpinnerButton(
			configuration: configuration,
			primaryAction: action
		)
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
		self.navigationItem.backButtonTitle = "Back"
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
	
	func isLoading() -> Bool {
		return submitButton.isLoading
	}
	
	func showLoading() {
		submitButton.isLoading = true
		textField.isEnabled = false
	}
	
	func dismissLoading() {
		submitButton.isLoading = false
		textField.isEnabled = true
	}
	
	func displayList(user: User) {
		let listVC = ListViewController(user: user)
		
		self.navigationController?.pushViewController(listVC, animated: true)
	}
}

extension SearchViewController {
	
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

extension SearchViewController: UITextFieldDelegate {
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return false
	}
	
	@objc
	func onTap() {
		textField.resignFirstResponder()
	}
	
}


