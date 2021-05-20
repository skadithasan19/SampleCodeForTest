//
//  DependencyContainer.swift
//  SampleCodeForTest
//
//  Created by Adit Hasan on 5/20/21.
//

import Foundation

protocol DependencyContainerProtocol: ViewModelFactory {
    var apiSession: APISessionProtocol { get }
    func makeAPISession() -> APISessionProtocol
}

class DependencyContainer: DependencyContainerProtocol {
    private(set) lazy var apiSession: APISessionProtocol = makeAPISession()
    func makeAPISession() -> APISessionProtocol {
        APISession()
    }
}

extension DependencyContainer: ViewModelFactory {
    func makeViewModel() -> PullsViewModel {
        PullsViewModel(factory: self)
    }
    func combine<A, B>(value: A, with closure: @escaping(A) -> B) -> () -> B {
        return { closure(value) }
    }
}
