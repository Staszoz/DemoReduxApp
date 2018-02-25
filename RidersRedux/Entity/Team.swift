//
//  Team.swift
//  RidersRedux
//
//  Created by Станислав Калиберов on 25.02.2018.
//  Copyright © 2018 Станислав Калиберов. All rights reserved.
//

import Foundation


final class Team: Codable {
    let uid: String
    let name: String
    
    init(uid: String, name: String) {
        self.uid = uid
        self.name = name
    }
}
