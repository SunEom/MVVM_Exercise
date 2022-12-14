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
        
        searchController.searchBar.rx.textDidEndEditing
            .bind(to: viewModel.textChangeDidfinish)
            .disposed(by: disposeBag)
        
        searchController.searchBar.rx.cancelButtonClicked
            .bind(to: viewModel.textChangeDidfinish)
            .disposed(by: disposeBag)
        
        searchController.searchBar.rx.textDidBeginEditing
            .bind(to: viewModel.textChangeStart)
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .map { $0.row }
            .bind(to: viewModel.cellSelected)
            .disposed(by: disposeBag)
            
    
        viewModel.cellData
            .drive(tableView.rx.items) { tv, row, data in
                let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
                cell.textLabel?.text = data.name
                cell.detailTextLabel?.text = data.line
                cell.backgroundColor = .white
                cell.textLabel?.textColor = .black
                cell.detailTextLabel?.textColor = .black
                return cell
            }
            .disposed(by: disposeBag)
        
        viewModel.textChangeDidfinish
            .subscribe(onNext: {
                self.tableView.isHidden = true
            })
            .disposed(by: disposeBag)
        
        viewModel.textChangeStart
            .subscribe(onNext: {
                self.tableView.isHidden = false
            })
            .disposed(by: disposeBag)
        
        viewModel.selectedStation
            .drive(onNext: {
                let vm = StationDetailViewModel()
                let vc = StationDetailViewController()
                vc.bind(vm)
                vm.station.onNext($0)
                self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
    
    }
    
    private func attribute() {
        view.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        title = "지하철 도착 정보"
        
        tableView.backgroundColor = .white
        
        searchController.searchBar.tintColor = .black
        searchController.searchBar.barTintColor = .black
        searchController.searchBar.searchTextField.tintColor = .black
        searchController.searchBar.searchTextField.textColor = .black

        
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
