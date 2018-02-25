//
//  Store.swift
//  RidersRedux
//
//  Created by Станислав Калиберов on 25.02.2018.
//  Copyright © 2018 Станислав Калиберов. All rights reserved.
//

import Foundation


protocol Presenter: class {
    func render(state: State)
}


final class Store {
    private var observers = [ObjectIdentifier: Presenter]()
    private(set) var state = State(teamList: TeamListState.initial)
    
    
    func dispatch(action: Action) {
        state = reduce(state, with: action)
        observers.forEach { $0.value.render(state: state) }
    }
    
    func addObserver(presenter: Presenter) {
        observers[ObjectIdentifier(presenter)] = presenter
        presenter.render(state: state)
    }
    
    func removeObserver(presenter: Presenter) {
        observers.removeValue(forKey: ObjectIdentifier(presenter))
    }
}
