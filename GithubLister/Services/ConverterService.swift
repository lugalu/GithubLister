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
		let repositories = repositories.map {
			Repository(name: $0.name, language: $0.language ?? "")
		}
			.sorted(by: { $0.name < $1.name})
		return User(name: name, image: image, repositories: repositories)
	}

	
}
