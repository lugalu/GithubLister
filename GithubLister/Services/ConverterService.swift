//Created by Lugalu on 06/02/25.

import UIKit

protocol ConverterService {
	func JSONToUser(
		user: UserJSON,
		image: UIImage?,
		repositories: [RepositoryJSON]
	) -> User
}

struct ConcreteConverterService: ConverterService {
	func JSONToUser(user: UserJSON,
					image: UIImage?,
					repositories: [RepositoryJSON]) -> User {
		let name = user.name
		var repositories = repositories.map {
			Repository(name: $0.name, languages: $0.languages.sorted(by: < ))
		}
		return User(name: name, image: image, repositories: repositories)
	}

	
}
