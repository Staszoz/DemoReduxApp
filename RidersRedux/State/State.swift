//
//  State.swift
//  RidersRedux
//
//  Created by Станислав Калиберов on 24.02.2018.
//  Copyright © 2018 Станислав Калиберов. All rights reserved.
//

import Foundation


struct State {
    let teamList: [Team.Identifier: Team]
    
    
    struct Team {
        typealias Identifier = GenericIdentifier<Team>
        
        let name: String
        let id: String
    }
}


struct GenericIdentifier<T>: RawRepresentable, Hashable, Equatable {
    var hashValue: Int {
        return rawValue.hashValue
    }
    
    let rawValue: String
    init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    static func == (lhs: GenericIdentifier<T>, rhs: GenericIdentifier<T>) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}
