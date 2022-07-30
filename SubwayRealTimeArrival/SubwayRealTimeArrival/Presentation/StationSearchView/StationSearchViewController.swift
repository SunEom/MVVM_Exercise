//
//  StationSearchViewController.swift
//  SubwayRealTimeArrival
//
//  Created by 엄태양 on 2022/07/29.
//

import UIKit
import RxSwift
import RxCocoa

class StationSearchViewController : UIViewController {

    private let disposeBag = DisposeBag()
    private let tableView = UITableView()
    private let searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchBar.placeholder = "역 이름을 검색해주세요"
        searchController.obscuresBackgroundDuringPresentation = false
        
        navigationItem.searchController = searchController
        
        attribute()
        layout()
    }
    
    func bind(_ viewModel: StationSearchViewModel) {
        searchController.searchBar.rx.text
            .bind(to: viewModel.keyword)
            .disposed(by: disposeBag)
    
        viewModel.cellData
            .drive(tableView.rx.items) { tv, row, data in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")

                cell.textLabel?.text = data.name
                cell.detailTextLabel?.text = data.line
                return cell
            }
        
    }
    
    private func attribute() {
        view.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        title = "지하철 도착 정보"
        
        tableView.backgroundColor = .white
        
    }
    
    private func layout() {
        [tableView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
}
