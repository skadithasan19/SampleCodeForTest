//
//  PullsViewModel.swift
//  SampleCodeForTest
//
//  Created by iOSVenture LLC on 3/5/21.
//

import Foundation
import Combine

class PullsViewModel: ObservableObject, PullService, Loadable {
    
    typealias Output = [Pull]
    
    typealias Factory = DependencyContainerProtocol
    
    private let factory: Factory
    
    private(set) lazy var apiSession: APISessionProtocol = factory.apiSession
    
    private var cancellables = Set<AnyCancellable?>()
    
    @Published var state: LoadingState<[Pull]> = .idle
    
    init(factory: Factory) {
        self.factory = factory
        self.loadPulls()
    }
    
    convenience init(apiSession: APISessionProtocol = APISession()) { // For Unit Testing
        self.init(factory: DependencyContainer())
        self.apiSession = apiSession
    }
    
    func loadPulls() {
        self.state = .loading
        cancellables.insert(self.getPulls()
                                .receive(on: DispatchQueue.main)
                                .sink(receiveCompletion: { (result) in
                                    switch result {
                                    case .failure(let error):
                                        print(error.localizedDescription)
                                        self.state = .failed(error)
                                        break
                                    case .finished:
                                        break
                                    }
                                }, receiveValue: { (pulls) in
                                    self.state = .loaded(pulls)
                                }))
    }
}
