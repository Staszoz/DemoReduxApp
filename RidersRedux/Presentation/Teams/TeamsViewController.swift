//
//  TeamsViewController.swift
//  RidersRedux
//
//  Created by Станислав Калиберов on 24.02.2018.
//  Copyright © 2018 Станислав Калиберов. All rights reserved.
//

import UIKit


class TeamsPresenter: Presenter {
    weak var controller: TeamsViewController?
    let store: Store
    
    init(controller: TeamsViewController, store: Store) {
        self.controller = controller
        self.store = store
    }
    
    func render(state: State) {
        var internalState: TeamsViewController.Props.State
        
        switch state.teamList {
        case .none:
            internalState = .loading
        case .teams(let newTeams):
            internalState = .teams(newTeams.map { TeamsViewController.Props.Team(name: $0.name, uid: $0.uid, onSelect: { (controller) in
                print()
            })} )
        case .error(let errorMsg):
            internalState = .error(errorMsg)
        }
        DispatchQueue.main.async {
            self.controller?.render(props: TeamsViewController.Props(title: "Teams", state: internalState))
        }
    }
}


class TeamsViewController: UIViewController {
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView?
    private var props: Props = Props.initial
    
    struct Props {
        let title: String
        let state: State
        
        enum State {
            case loading
            case teams([Team])
            case error(String)
        }
        
        struct Team {
            let name: String
            let uid: String
            let onSelect: ((UIViewController)->())?
        }
        
        static let initial = Props(title: "", state: .teams([]))
    }
    
    
    func render(props: Props) {
        self.props = props
        
        switch props.state {
        case .teams(_):
            indicatorView.stopAnimating()
            errorLabel.isHidden = true
            tableView?.isHidden = false
            tableView?.reloadData()
        case .loading:
            indicatorView.startAnimating()
            errorLabel.isHidden = true
            tableView?.isHidden = true
        case .error(_):
            indicatorView.stopAnimating()
            errorLabel.isHidden = false
            tableView?.isHidden = true
        }
    }
}

extension TeamsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch props.state {
        case .teams(let teams):
            return teams.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch props.state {
        case .teams(let teams):
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell"),
                teams.count > indexPath.row
                else {
                    return UITableViewCell()
            }
            cell.textLabel?.text = teams[indexPath.row].name
            return cell
        default: return UITableViewCell()
        }
    }
}
