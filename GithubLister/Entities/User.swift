//Created by Lugalu on 06/02/25.

import UIKit

struct User {
	var name: String
	var image: UIImage?
	var repositories: [Repository]
}

struct Repository {
	var name: String
	var language: String
}
