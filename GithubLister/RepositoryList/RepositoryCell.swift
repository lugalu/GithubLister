//Created by Lugalu on 06/02/25.

import UIKit

class RepositoryCell: UITableViewCell {
	static let Identifier = "RepositoryCell"
	
	lazy var repositoryName: UILabel = {
		let label = UILabel()
		label.font = .boldSystemFont(ofSize: 16)
		label.numberOfLines = 1
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	lazy var repositoryLanguages: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 12)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	
	
	func configure(with repo: Repository) {
		if (repositoryName.superview == nil) {
			makeUI()
		}
	}
	
	func makeUI () {
		self.addSubview(repositoryName)
		self.addSubview(repositoryLanguages)
		//add constraints
	}
}
