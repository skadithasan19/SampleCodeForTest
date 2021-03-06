//
//  PullsViewModel.swift
//  SampleCodeForTest
//
//  Created by iOSVenture LLC on 3/5/21.
//

import Foundation
import Combine

class PullsViewModel: ObservableObject, PullService {
    var apiSession: APIService
    
    @Published var pulls = [Pull]()
    
    private var disposables = Set<AnyCancellable>()
    
    init(apiSession:APISession = APISession()) {
        self.apiSession = apiSession
        self.loadPulls()
    }
    
    func loadPulls() {
        disposables.insert(self.getPulls()
                            .receive(on: DispatchQueue.main)
                            .sink(receiveCompletion: { (result) in
                                switch result {
                                case .failure(let error):
                                    print(error.localizedDescription)
                                    break
                                case .finished:
                                    break
                                }
                            }, receiveValue: { (pulls) in
                                self.pulls = pulls.filter({ $0.state == AppState.open })
                            }))
    }
}
