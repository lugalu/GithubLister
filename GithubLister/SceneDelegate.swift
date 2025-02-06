//Created by Lugalu on 05/02/25.

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?
	var locator: ServiceLocator?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		window = UIWindow(windowScene: windowScene)
		
		locator = addServiceLocator()
		guard let locator else {
			fatalError("Error initializing the ServiceLocator")
		}
		
		let search = makeSearchViewController(locator: locator)
		window?.rootViewController = makeNavigation(root: search)
		window?.makeKeyAndVisible()
	}
	
	func addServiceLocator() -> ServiceLocator {
		let decoder = ConcreteDecoderService()
		let network = ConcreteNetworkService(decoderService: decoder)
		let converter = ConcreteConverterService()
		return ConcreteServiceLocator(networkService: network,
									  decoderService: decoder,
									  converterService: converter
		)
	}
	
	func makeSearchViewController(locator: ServiceLocator) -> SearchController {
		let searchModel = ConcreteSearchModel(locator: locator)
		return SearchController(model: searchModel)
	}
	
	func makeNavigation(root: UIViewController) -> UINavigationController {
		
		let navigation = UINavigationController(rootViewController: root)
		navigation.toolbar.backgroundColor = .secondarySystemFill
		navigation.navigationBar.prefersLargeTitles = false
		navigation.navigationBar.isTranslucent = false
		
		//Needed for the statusBar and navigationBar to be the same color
		let navigationAppearence = UINavigationBarAppearance()
		navigationAppearence.backgroundColor = .secondarySystemFill
		navigation.navigationBar.scrollEdgeAppearance = navigationAppearence

		
		return navigation
	}

}

