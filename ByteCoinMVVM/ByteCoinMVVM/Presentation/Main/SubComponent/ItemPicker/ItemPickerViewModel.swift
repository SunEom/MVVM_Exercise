//
//  ItemPickerViewModel.swift
//  ByteCoinMVVM
//
//  Created by 엄태양 on 2022/08/03.
//

import RxSwift
import RxCocoa
import RxRelay

struct ItemPickerViewModel {
    let disposeBag = DisposeBag()
    
    let currencyList = Observable<[String]>.just(["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"])
    let selectedIdx = PublishSubject<Int>()
    
    let selectedCurreny = PublishSubject<String>()
    
    init() {
        
        Observable
            .combineLatest(currencyList, selectedIdx) { list, idx in
                list[idx]
            }
            .bind(to: selectedCurreny)
            .disposed(by: disposeBag)
        
    }
    

}
