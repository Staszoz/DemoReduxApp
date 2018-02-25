//
//  State.swift
//  RidersRedux
//
//  Created by Станислав Калиберов on 24.02.2018.
//  Copyright © 2018 Станислав Калиберов. All rights reserved.
//

import Foundation


struct State {
    let teamList: TeamListState
}


func reduce(_ state: State, with action: Action) -> State {
    return State(
        teamList: reduce(state.teamList, with: action)
    )
}

