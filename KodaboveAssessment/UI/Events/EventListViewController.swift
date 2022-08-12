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

        registerCell()
        bindFetchCompletePublisher()

        vm?.loadData(limit: PageSize.limit)
    }
}

extension EventListViewController {

    private func configureTableView() {
        registerCell()
        removeEmptyCellsFromBottom()
    }

    private func bindVmPublishers() {
        bindFetchCompletePublisher()
    }

    private func registerCell() {
        self.tableView.register(
            UINib(nibName: ListItemCell.cellId, bundle: nil),
            forCellReuseIdentifier: ListItemCell.cellId
        )
    }

    private func removeEmptyCellsFromBottom() {
        self.tableView.tableFooterView = UIView()
    }

    private func bindFetchCompletePublisher() {
        vm?.$onFetchComplete.sink { [weak self] _ in
            self?.tableView.reloadData()
        }.store(in: &cancellables)
    }
}

extension EventListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm?.totalCount ?? 0
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
