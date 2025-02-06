//Created by Lugalu on 06/02/25.

import Foundation

enum DecodeErrors: Error{
	case incompatibleType
}

protocol DecoderService {
	func decode<T:Decodable>(_ data: Data, class: T.Type) throws -> T
	func decode(_ data: Data) throws -> [String: Any]
	
}

struct ConcreteDecoderService: DecoderService {
	func decode<T:Decodable>(_ data: Data, class: T.Type) throws -> T {
		let decoder = JSONDecoder()
		return try decoder.decode(T.self, from: data)
	}
	
	func decode(_ data: Data) throws -> [String: Any]{
		guard let dict = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
			throw DecodeErrors.incompatibleType
		}
		return dict
	}
}
