//Created by Lugalu on 07/02/25.

import UIKit
@testable import GithubLister

class FakeDelegate: SearchViewControllerDelegate {
	var completeCounter = 0
	var showedAlert = false
	var isLoadingControl = false
	var user: GithubLister.User? = nil
	var callback: (FakeDelegate) -> Void
	var alertCallback: ((FakeDelegate) -> Void)?
	
	init(
		callback: @escaping (FakeDelegate) -> Void,
		alertCallback: ((FakeDelegate) -> Void)? = nil
	) {

		self.callback = callback
		self.alertCallback = alertCallback
	}
	func showAlert(withMessage: String) {
		showedAlert = true
		alertCallback?(self)
	}

	func isLoading() -> Bool {
		return isLoadingControl
	}

	func showLoading() {
		isLoadingControl = true
	}

	func dismissLoading() {
		completeCounter += 1
		isLoadingControl = false
		callback(self)
	}

	func displayList(user: GithubLister.User) {
		self.user = user
	}

	
}
