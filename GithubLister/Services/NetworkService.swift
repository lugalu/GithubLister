//Created by Lugalu on 06/02/25.

import Foundation
import UIKit


enum NetworkErrors: Error {
	case malformedURL
	case notFound
	case unknownError
}

protocol NetworkService {
	func getUser(_ : String) async throws -> UserJSON
	func getImage(source: String) async throws -> UIImage?
	func getRepositories(source: String) async throws -> [RepositoryJSON]
}

class ConcreteNetworkService: NetworkService {
	let decoderService: DecoderService
	
	
	init(decoderService: DecoderService) {
		self.decoderService = decoderService
	}
	
	func downloadData(url: URL) async throws -> Data {
		let request = URLRequest(url: url)
		let result = try await URLSession.shared.data(for: request)
		
		guard let (data, response) = result as? (Data, HTTPURLResponse) else {
			throw NetworkErrors.unknownError
		}
		
		try handleResponse(response)
		
		return data
	}
	
	func handleResponse(_ response: HTTPURLResponse) throws {
		if response.statusCode == 404 {
			throw NetworkErrors.notFound
		}
		
		if response.statusCode != 200 {
			throw NetworkErrors.unknownError
		}
	}
	
	func getUser(_ username: String) async throws -> UserJSON {
		guard let url = URL(string: "https://api.github.com/users/" + username) else {
			throw NetworkErrors.malformedURL
		}
		
		let data = try await downloadData(url: url)
		let user = try decoderService.decode(data, class: UserJSON.self)
		
		return user
	}
	
	func getImage(source: String) async throws -> UIImage? {
		guard let url = URL(string: source) else {
			throw NetworkErrors.malformedURL
		}
		
		let data = try await downloadData(url: url)
		return UIImage(data: data)
	}
	
	func getRepositories(source: String) async throws -> [RepositoryJSON] {
		guard let url = URL(string: source) else {
			throw NetworkErrors.malformedURL
		}
		
		let data = try await downloadData(url: url)
		let result = try decoderService.decode(data, class: [RepositoryJSON].self)
		
		return result
	}
}
