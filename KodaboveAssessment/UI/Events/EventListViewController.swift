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
    private var cancellables: Set<AnyCancellable> = []
    var vm: ItemListViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        vm?.loadData(limit: PageSize.limit)
    }
}

extension EventListViewController {

    private func bindVmPublishers() {
        bindFetchCompletePublisher()
    }

    private func bindFetchCompletePublisher() {
        vm?.$onFetchComplete.sink { [weak self] _ in
            self?.tableView.reloadData()
        }.store(in: &cancellables)
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

extension EventListViewController: UITableViewDataSourcePrefetching {

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
    }

}

extension EventListViewController: UITableViewDelegate {

}
