//
//  ViewController.swift
//  ByteCoinMVVM
//
//  Created by 엄태양 on 2022/08/03.
//

import UIKit
import RxCocoa
import RxSwift

class MainViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let titleLabel = UILabel()
    let picker = ItemPicker()
    let iconImageView = UIImageView()
    let stackView = UIStackView()
    let priceLabel = UILabel()
    let currencyLabel = UILabel()
    
    override func viewDidLoad() {
        
        attribute()
        layout()
        
    }
    
    func bind(_ viewModel: MainViewModel) {
        
        picker.bind(viewModel.itemPickerViewModel)
        
        viewModel.itemPickerViewModel.selectedCurreny
            .bind(to: currencyLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.price
            .map { rate -> String in
                return String(format: "%.3f", rate)
            }
            .bind(to: priceLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        
        view.backgroundColor = UIColor(named: "Background Color")
        
        titleLabel.text = "Byte Coin"
        titleLabel.textColor = UIColor(named: "Title Color")
        titleLabel.font = .systemFont(ofSize: 50, weight: .semibold)
        titleLabel.textAlignment = .center
        
        stackView.layer.cornerRadius = 45
        stackView.backgroundColor = .tertiaryLabel
        
        iconImageView.image = UIImage(systemName: "bitcoinsign.circle.fill")
        iconImageView.tintColor = UIColor(named: "Icon Color")
        
        priceLabel.text = "...."
        priceLabel.font = .systemFont(ofSize: 30)
        
        currencyLabel.text = "AUD"
        currencyLabel.font = .systemFont(ofSize: 30)
        
    }
    
    private func layout() {
        [titleLabel, stackView, priceLabel, iconImageView, picker].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        [iconImageView, priceLabel, currencyLabel].forEach{ self.stackView.addArrangedSubview($0)}
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.spacing = 10
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 3, leading: 10, bottom: 3, trailing: 10)
        
        let cons = [
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 80),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            stackView.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 90),
            
            iconImageView.widthAnchor.constraint(equalToConstant: 84),
            iconImageView.heightAnchor.constraint(equalToConstant: 84),
            
            picker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            picker.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            picker.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            picker.heightAnchor.constraint(equalToConstant: 200)
        ]
        NSLayoutConstraint.activate(cons)

    }
}
