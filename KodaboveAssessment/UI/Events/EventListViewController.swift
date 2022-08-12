//
//  EventListViewController.swift
//  KodaboveAssessment
//
//  Created by Drew Barnes on 11/08/2022.
//

import UIKit
import Combine

class EventListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var vm: ItemList?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension EventListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}

extension EventListViewController: UITableViewDelegate {

}
