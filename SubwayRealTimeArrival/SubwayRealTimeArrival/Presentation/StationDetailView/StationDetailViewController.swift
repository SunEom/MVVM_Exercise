//
//  StationDetailViewController.swift
//  SubwayRealTimeArrival
//
//  Created by 엄태양 on 2022/07/31.
//

import UIKit
import RxSwift
import RxCocoa

class StationDetailViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
    }
    
    func bind(_ viewModel: StationDetailViewModel) {
        
        tableView.rx.itemSelected
            .subscribe(onNext: {
                self.tableView.cellForRow(at: $0)?.isSelected = false
            })
            .disposed(by: disposeBag)
            
        
        viewModel.cellData
            .drive(tableView.rx.items) { tv, row, data in
                let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
                cell.textLabel?.text = data.direction ?? ""
                cell.detailTextLabel?.text = data.currentLocation ?? ""
                cell.backgroundColor = .white
                cell.textLabel?.textColor = .black
                cell.detailTextLabel?.textColor = .black
                return cell
            }
            .disposed(by: disposeBag)
        
        viewModel.station
            .subscribe(onNext: { station in
                self.title = station.name
            })
            .disposed(by: disposeBag)
        
        
    }
    
    private func attribute() {
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        
        
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
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
