//
//  Rider.swift
//  RidersRedux
//
//  Created by Станислав Калиберов on 25.02.2018.
//  Copyright © 2018 Станислав Калиберов. All rights reserved.
//

import Foundation

final class Rider: Codable {
    let uid: String
    let teamUid: String
    
    let name: String
    var team: String
    var bike: String
    var placeOfBirth: String
    var dateOfBirth: String
    var weight: String
    var height: String
    var photoUrl: String
    
    init(uid: String, name: String, team: String, bike: String, placeOfBirth: String, dateOfBirth: String,
         weight: String, height: String, photoUrl: String, teamUid: String) {
        
        self.uid = uid
        self.teamUid = teamUid
        
        self.name = name
        self.team = team
        self.bike = bike
        self.placeOfBirth = placeOfBirth
        self.dateOfBirth = dateOfBirth
        self.weight = weight
        self.height = height
        self.photoUrl = photoUrl
    }
}
