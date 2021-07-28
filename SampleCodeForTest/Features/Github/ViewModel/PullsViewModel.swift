//
//  PullsViewModel.swift
//  SampleCodeForTest
//
//  Created by iOSVenture LLC on 3/5/21.
//

import Foundation
import Combine

class PullsViewModel: ObservableObject, PullService, Loadable {
    var apiSession: APISessionProtocol
    
    typealias Output = [Pull]
    
    typealias Factory = DependencyContainerProtocol
    
    private var cancellables = Set<AnyCancellable?>()
    
    @Published var state: LoadingState<[Pull]> = .idle
    
    init(apiSession: APISessionProtocol = APISession()) {
        self.apiSession = apiSession
        self.loadPulls()
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
