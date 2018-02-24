//
//  TeamsViewController.swift
//  RidersRedux
//
//  Created by Станислав Калиберов on 24.02.2018.
//  Copyright © 2018 Станислав Калиберов. All rights reserved.
//

import UIKit


class TeamsPresenter {
    weak var controller: TeamsViewController?
    
    init(controller: TeamsViewController) {
        self.controller = controller
    }
    
    func render(state: State) {
        let props = TeamsViewController.Props(
            title: "Teams",
            teams: state.teamList.map { TeamsViewController.Props.Team(
                name: $0.value.name,
                uid: $0.value.id,
                onSelect: { controller in
                    print()
                })
            }
        )
        
        controller?.render(props: props)
    }
}


class TeamsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView?
    private var props: Props = Props.initial
    
    struct Props {
        let title: String
        let teams: [Team]
        
        struct Team {
            let name: String
            let uid: String
            let onSelect: ((UIViewController)->())?
        }
        
        static let initial = Props(title: "", teams: [])
    }
    
    
    func render(props: Props) {
        self.props = props
        tableView?.reloadData()
    }
}

extension TeamsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return props.teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell"),
            props.teams.count > indexPath.row
            else {
                return UITableViewCell()
        }
        cell.textLabel?.text = props.teams[indexPath.row].name
        return cell
    }
}
