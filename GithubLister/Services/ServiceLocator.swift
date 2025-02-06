//Created by Lugalu on 05/02/25.

import Foundation

protocol ServiceLocator {
	var networkService: NetworkService { get }
	var decoderService: DecoderService { get }
	var converterService: ConverterService { get }
}

class ConcreteServiceLocator: ServiceLocator {
	private(set) var networkService: NetworkService
	private(set) var decoderService: DecoderService
	private(set) var converterService: ConverterService
	
	
	init(
		networkService: NetworkService,
		decoderService: DecoderService,
		converterService: ConverterService
	) {
		self.networkService = networkService
		self.decoderService = decoderService
		self.converterService = converterService
	}
	
}



