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
		label.font = .systemFont(ofSize: 13)
		label.textColor = .secondaryLabel
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	
	
	func configure(with repo: Repository) {
		if (repositoryName.superview == nil) {
			makeUI()
		}
		
		repositoryName.text = repo.name
		repositoryLanguages.text = repo.language.capitalized
	}
	
	func makeUI () {
		contentView.addSubview(repositoryName)
		contentView.addSubview(repositoryLanguages)
		
		makeNameConstraints()
		makeLanguagesConstraints()
	}
	
	func makeNameConstraints() {
		let view = contentView
		let constraints = [
			repositoryName.topAnchor.constraint(equalTo: view.topAnchor,constant: 8),
			repositoryName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8)
		]
		NSLayoutConstraint.activate(constraints)
	}
	
	func makeLanguagesConstraints() {
		let view = contentView
		let constraints = [
			repositoryLanguages.topAnchor.constraint(equalTo: repositoryName.bottomAnchor, constant: 4),
			repositoryLanguages.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
			repositoryLanguages.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -4)
		]
		
		NSLayoutConstraint.activate(constraints);
	}
	
}
