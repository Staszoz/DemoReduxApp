//
//  RidersOfTeamViewController.swift
//  RidersRedux
//
//  Created by Станислав Калиберов on 25.02.2018.
//  Copyright © 2018 Станислав Калиберов. All rights reserved.
//

import UIKit


class RidersOfTeamPresenter: Presenter {
    weak var controller: RidersOfTeamViewController?
    let store: Store
    
    init(controller: RidersOfTeamViewController, store: Store) {
        self.controller = controller
        self.store = store
    }
    
    deinit {
        store.removeObserver(presenter: self)
        print("RidersOfTeamPresenter")
    }
    
    func render(state: State) {
        var internalState: RidersOfTeamViewController.Props.State
        var teamName: String = ""
        switch state.ridersOfTeam {
        case .didSelect(let team):
            internalState = .loading
            teamName = team.name
            getRidersOfTeam(team: team)
        case .riders(let team, let riders):
            teamName = team.name
            internalState = .riders(
                riders.map {
                    RidersOfTeamViewController.Props.Rider(
                        name: $0.name,
                        uid: $0.uid,
                        onSelect: { controller in
                        print()
                        }
                    )
                }
            )
        case .error(let errorMsg):
            internalState = .error(errorMsg)
        }
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.controller?.render(props: RidersOfTeamViewController.Props(title: teamName, state: internalState))
        }
    }
    
    
    func getRidersOfTeam(team: Team) {
        getURL(url: URL(string: "https://s3.eu-west-2.amazonaws.com/motogpriders/riders.json")!) { [weak self](ridersResponse: RidersOfTeamResponse) in
            self?.store.dispatch(action: CompletedLoadRidersOfTeam(team: team, response: ridersResponse))
        }
    }
}



class RidersOfTeamViewController: UIViewController {
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView?
    private var props: Props = Props.initial
    
    struct Props {
        let title: String
        let state: State
        
        enum State {
            case loading
            case riders([Rider])
            case error(String)
        }
        
        struct Rider {
            let name: String
            let uid: String
            let onSelect: ((UIViewController)->())?
        }
        
        static let initial = Props(title: "", state: .riders([]))
    }
    
    
    deinit {
        print("RidersOfTeamViewController")
    }
    
    
    func render(props: Props) {
        self.props = props
        
        title = props.title
        
        switch props.state {
        case .riders(_):
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

extension RidersOfTeamViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch props.state {
        case .riders(let riders):
            return riders.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch props.state {
        case .riders(let riders):
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: "RiderTableViewCellIdentifier") as? RiderTableViewCell,
                riders.count > indexPath.row
                else {
                    return UITableViewCell()
            }
            cell.nameLabel.text = riders[indexPath.row].name
            cell.numberLabel.text = riders[indexPath.row].uid
            return cell
        default: return UITableViewCell()
        }
    }
}








class RiderTableViewCell: UITableViewCell {
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
}
