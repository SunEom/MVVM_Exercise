//
//  ItemPicker.swift
//  ByteCoinMVVM
//
//  Created by 엄태양 on 2022/08/03.
//

import UIKit
import RxSwift
import RxCocoa

class ItemPicker: UIPickerView {
    let disposeBag = DisposeBag()
    func bind(_ viewModel: ItemPickerViewModel) {
        
        viewModel.currencyList
            .bind(to: self.rx.itemTitles) { idx, title in
                return String(title)
            }
            .disposed(by: disposeBag)
        
        self.rx.itemSelected
            .subscribe(onNext: {
                viewModel.selectedIdx.onNext($0.row)
            })
            .disposed(by: disposeBag)
        
        Observable
            .combineLatest(viewModel.currencyList, viewModel.selectedIdx) { list, idx in
                return list[idx]
            }
            .subscribe(onNext: {
                viewModel.selectedCurreny.onNext($0)
            })
            .disposed(by: disposeBag)
            
    }
    
    
}


