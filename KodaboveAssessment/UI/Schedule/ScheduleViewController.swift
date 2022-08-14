//
//  ScheduleViewController.swift
//  KodaboveAssessment
//
//  Created by Drew Barnes on 13/08/2022.
//

import UIKit
import Combine

class ScheduleViewController: UIViewController, AlertDisplayer {

    @IBOutlet weak var tableView: UITableView!
    private var cancellables: Set<AnyCancellable> = []
    var vm: EventListViewModel?
    var fetchDataWaitPeriod: TimeInterval = 30

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Schedule"

        configureTableView()
        bindVmPublishers()

        vm?.loadData(limit: PageSize.limit)
        vm?.loadData(limit: PageSize.limit, every: fetchDataWaitPeriod)
    }

}

extension ScheduleViewController {

    private func configureTableView() {
        registerCell()
        removeEmptyCellsFromBottom()
        configureTableViewCellHeight()
    }

    private func bindVmPublishers() {
        bindFetchCompletePublisher()
        bindOnErrorrPublisher()
    }

    private func registerCell() {
        tableView.register(
            UINib(nibName: ListItemCell.cellId, bundle: nil),
            forCellReuseIdentifier: ListItemCell.cellId
        )
    }

    private func removeEmptyCellsFromBottom() {
        tableView.tableFooterView = UIView()
    }

    private func configureTableViewCellHeight() {
        tableView.estimatedRowHeight = 124
        tableView.rowHeight = UITableView.automaticDimension
    }

    private func bindFetchCompletePublisher() {
        vm?.$onFetchComplete.sink { [weak self] _ in
            self?.tableView.reloadData()
        }.store(in: &cancellables)
    }

    private func bindOnErrorrPublisher() {
        vm?.$onError.sink { [weak self] error in
            guard let error = error else { return }
            self?.displayAlert(
                with: "Error",
                message: error.localizedDescription,
                preferredStyle: .alert
            )
        }.store(in: &cancellables)
    }

}

extension ScheduleViewController {

    func shouldShowLoadingAnimatation() -> Bool {
        guard let vm = vm else { return true }
        return vm.isLoadingData && vm.totalCount < 1
    }

}

extension ScheduleViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let itemCount = vm?.totalCount else { return 7 }
        let count = shouldShowLoadingAnimatation() ? 7 : itemCount
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ListItemCell.cellId, for: indexPath
        ) as? ListItemCell else {
            fatalError("Unexpected error")
        }

        if isLoadingCell(for: indexPath) {
            cell.showLoadingAnimation()
            cell.configure(with: .none)
        } else {
            cell.hideLoadingAnimation()
            cell.configure(with: vm?.viewModel(at: indexPath.row))
        }

        return cell
    }

}

extension ScheduleViewController {

    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        guard let vm = vm else { return true }
        return indexPath.item >= vm.currentCount
    }

    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
      let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
      let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
      return Array(indexPathsIntersection)
    }

}

extension ScheduleViewController: UITableViewDataSourcePrefetching {

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            vm?.loadData(limit: PageSize.limit)
        }
    }

}
