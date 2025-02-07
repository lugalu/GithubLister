//Created by Lugalu on 06/02/25.

import UIKit

class ListViewController: UIViewController {
	private(set) var user: User
	
	lazy var tableView: UITableView = {
		let table = UITableView(frame: .zero, style: .plain)
		table.dataSource = self
		table.translatesAutoresizingMaskIntoConstraints = false
		table.backgroundColor = .clear
		table.register(RepositoryCell.self,
					   forCellReuseIdentifier: RepositoryCell.Identifier)
		
		return table
	}()
	
	lazy var titleView = makeTitleView()
	
	init(user: User) {
		self.user = user
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		makeUI()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(true, animated: false)

	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		navigationController?.setNavigationBarHidden(false, animated: false)
	}


}

extension ListViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if user.repositories.isEmpty {
			let size = tableView.bounds.size
			let noDataLabel: UILabel  = UILabel(frame: .init( origin: .zero,
					size: .init(width: size.width, height: size.height)
				))
			noDataLabel.text          = "This user has no repositories available"
			noDataLabel.textAlignment = .center
			tableView.backgroundView  = noDataLabel
			tableView.separatorStyle  = .none
			
			return 0
		}
		
		tableView.separatorStyle = .singleLine
		tableView.backgroundView = nil
		return user.repositories.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryCell.Identifier) as? RepositoryCell else {
			return UITableViewCell()
		}
		cell.configure(with: user.repositories[indexPath.row])
		return cell
	}
	
	
}

extension ListViewController {
	func makeUI() {
		view.backgroundColor = .systemBackground
		view.addSubview(tableView)
		view.addSubview(titleView)
		addAllConstraints()
	}
	
	func addAllConstraints() {
		let constraints = [
			titleView.topAnchor.constraint(equalTo: view.topAnchor),
			titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			titleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			titleView.heightAnchor.constraint(equalToConstant: 200),
			
			tableView.topAnchor
				.constraint(equalTo: titleView.bottomAnchor),
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		]
		
		NSLayoutConstraint.activate(constraints)
	}
	
	func makeTitleView() -> UIView {
		let view = UIView()
		view.backgroundColor = .secondarySystemFill
		view.translatesAutoresizingMaskIntoConstraints = false

		
		let imageSize: CGFloat = 100
		let imageView = makeImageView(withSize: imageSize)

		let backButton = makeBackButton()
		let nameLabel = makeNameLabel()
		
		view.addSubview(backButton)
		view.addSubview(imageView)
		view.addSubview(nameLabel)
	
		let safeArea = view.safeAreaLayoutGuide
		let constraints = [
			
			imageView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
			imageView.topAnchor.constraint(equalTo: safeArea.topAnchor),
			imageView.widthAnchor.constraint(equalToConstant: imageSize),
			imageView.heightAnchor.constraint(equalToConstant: imageSize),
			
			backButton.leftAnchor
				.constraint(equalTo: safeArea.leftAnchor, constant: 8),
			backButton.topAnchor
				.constraint(equalTo: safeArea.topAnchor),

			nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			nameLabel.topAnchor
				.constraint(equalTo: imageView.bottomAnchor, constant: 8)
		]
		NSLayoutConstraint.activate(constraints)
		
		return view
	}
	
	func makeBackButton() -> UIButton {
		var configuration: UIButton.Configuration = .plain()
		configuration.image = UIImage(systemName: "chevron.left")
		configuration.title = "Back"
		
		
		let action = UIAction { [weak self] _ in
			self?.navigationController?.popViewController(animated: true)
		}
		let backButton = UIButton(
			configuration: configuration ,
			primaryAction: action
		)
		backButton.translatesAutoresizingMaskIntoConstraints = false
		return backButton
	}
	
	func makeImageView(withSize imgSize: CGFloat) -> UIImageView {
		let imgView = UIImageView(image: user.image ?? UIImage(systemName: "person.circle.fill"))
		imgView.layer.cornerRadius = imgSize / 2
		imgView.clipsToBounds = true
		imgView.tintColor = .gray
		imgView.translatesAutoresizingMaskIntoConstraints = false
		return imgView
	}
	
	func makeNameLabel() -> UILabel {
		let label = UILabel()
		label.text = user.name
		label.numberOfLines = 1
		label.font = .systemFont(ofSize: 20)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}
}

