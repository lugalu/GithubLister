//Created by Lugalu on 06/02/25.

import Foundation

struct UserJSON: Decodable {
	let name: String
	let avatar_url: String
	let repos_url: String
}

struct RepositoryJSON: Decodable {
	let name: String
	let languages_url: String
	
	enum CodingKeys: CodingKey {
		case name
		case languages_url
	}
	
	private(set) var languages: [String] = []
	
	
	mutating func addLanguages(_ languages: [String]) {
		
	}
}
