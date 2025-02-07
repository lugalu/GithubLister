//Created by Lugalu on 05/02/25.

import Testing
import UIKit
@testable import GithubLister








struct SearchModelTests {
	let locator = ConcreteServiceLocator(
		networkService: FakeNetwork(),
		decoderService: ConcreteDecoderService(),
		converterService: ConcreteConverterService()
	)
	
    @Test func noErrors() async throws {

		let delegate = FakeDelegate(){ delegate in
			#expect(!delegate.isLoadingControl)
		}
		let sut = GithubLister.ConcreteSearchModel(locator: locator)
		sut.assign(delegate: delegate)
		sut.fetchUser(withName: "lugalu")
    }
	
	@Test func modelShouldBlockSimultaneousAttemps() async throws {

		let delegate = FakeDelegate(){ delegate in
			#expect(delegate.completeCounter == 1)
		}
		let sut = GithubLister.ConcreteSearchModel(locator: locator)
		sut.assign(delegate: delegate)
		sut.fetchUser(withName: "lugalu")
		sut.fetchUser(withName: "lugalu")

	}
	
	@Test func modelShouldCallOnError() async throws {
		let localLocator = ConcreteServiceLocator(
			networkService: FakeNetwork(shouldFailUser: true),
			decoderService: ConcreteDecoderService(),
			converterService: ConcreteConverterService()
		)
		let delegate = FakeDelegate(){ _ in
		} alertCallback: { delegate in
			#expect(delegate.showedAlert)
		}
		let sut = GithubLister.ConcreteSearchModel(locator: localLocator)
		sut.assign(delegate: delegate)
		sut.fetchUser(withName: "lugalu")
	}
	
	@Test func imageDoesntCallError() async throws {
		let localLocator = ConcreteServiceLocator(
			networkService: FakeNetwork(shouldFailImage: true),
			decoderService: ConcreteDecoderService(),
			converterService: ConcreteConverterService()
		)
		let delegate = FakeDelegate(){ delegate in
			#expect(delegate.completeCounter == 1)
		} alertCallback: { delegate in
			#expect(Bool(false))
		}
		let sut = GithubLister.ConcreteSearchModel(locator: localLocator)
		sut.assign(delegate: delegate)
		sut.fetchUser(withName: "lugalu")
	}
	
	@Test func RepoDoesntCallError() async throws {
		let localLocator = ConcreteServiceLocator(
			networkService: FakeNetwork(shouldFailRepo: true),
			decoderService: ConcreteDecoderService(),
			converterService: ConcreteConverterService()
		)
		let delegate = FakeDelegate(){ delegate in
			#expect(delegate.completeCounter == 1)
		} alertCallback: { delegate in
			#expect(Bool(false))
		}
		let sut = GithubLister.ConcreteSearchModel(locator: localLocator)
		sut.assign(delegate: delegate)
		sut.fetchUser(withName: "lugalu")
	}

}
