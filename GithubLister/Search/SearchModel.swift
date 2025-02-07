//Created by Lugalu on 05/02/25.

import UIKit

protocol SearchModel {
	func assign(delegate: SearchViewControllerDelegate)
	func fetchUser(withName name: String)
}

class ConcreteSearchModel: SearchModel {
	let locator: ServiceLocator
	var delegate: SearchViewControllerDelegate? = nil
	
	init(locator: ServiceLocator) {
		self.locator = locator
	}
	
	func assign(delegate: any SearchViewControllerDelegate) {
		self.delegate = delegate
	}
	
	func fetchUser(withName name: String) {
		guard let delegate, !delegate.isLoading() else { return }
		delegate.showLoading()
		Task {
			do {

				let networkService = locator.networkService
				let userJSON = try await networkService.getUser(name)
				async let imageDownload = networkService.getImage(source: userJSON.avatar_url)
				async let repositoriesDowload = networkService.getRepositories(source: userJSON.repos_url)
				
				let (image, repositories) = (try? await (imageDownload, repositoriesDowload)) ?? (nil, [])
				let converterService = locator.converterService
				
				let user = converterService.JSONToUser(
					user: userJSON,
					image: image,
					repositories: repositories
				)
				
				DispatchQueue.main.async { [weak self] in
					self?.delegate?.dismissLoading()
					self?.delegate?.displayList(user: user)
				}
				
			} catch NetworkErrors.notFound {
				onError(message: "User not found. Please enter another name")
			} catch {
				onError(message: "A network error has occurred. Check your Internet connection and try again later.")
			}
		}
	}
	
	func onError(message: String) {
		DispatchQueue.main.async { [weak self] in
			self?.delegate?.dismissLoading()
			self?.delegate?.showAlert(withMessage: message)
		}
	}
	
}


