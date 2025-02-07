//Created by Lugalu on 07/02/25.

import UIKit
@testable import GithubLister

class FakeNetwork: NetworkService {
	let shouldFailUser: Bool
	let shouldFailImage: Bool
	let shouldFailRepo: Bool
	
	init(
		shouldFailUser: Bool = false,
		shouldFailImage: Bool = false,
		shouldFailRepo: Bool = false
	) {
		self.shouldFailUser = shouldFailUser
		self.shouldFailImage = shouldFailImage
		self.shouldFailRepo = shouldFailRepo
	}
	
	func getUser(_: String) async throws -> GithubLister.UserJSON {
		if shouldFailUser {
			throw NetworkErrors.notFound
		}
		return UserJSON(name: "lugalu", avatar_url: "catty", repos_url: "nada")
	}

	func getImage(source: String) async throws -> UIImage? {
		if shouldFailImage {
			throw NetworkErrors.malformedURL
		}
		return UIImage(named: "catty")!
	}

	func getRepositories(source: String) async throws -> [GithubLister.RepositoryJSON] {
		if shouldFailRepo {
			throw NetworkErrors.unknownError
		}
		
		return [
			RepositoryJSON(name: "hm", language: "hm")
		]
	}
}
