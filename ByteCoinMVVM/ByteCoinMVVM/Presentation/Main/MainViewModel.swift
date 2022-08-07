//
//  MainViewModel.swift
//  ByteCoinMVVM
//
//  Created by 엄태양 on 2022/08/03.
//

import RxSwift
import RxCocoa

struct MainViewModel {
    let disposeBag = DisposeBag()
    
    let itemPickerViewModel = ItemPickerViewModel()
    
    let price = PublishSubject<String>()
    
    let selectedData = PublishSubject<(String, String)>()
    
    init(repository: CoinDataRepository = CoinDataRepository()) {
            
        itemPickerViewModel.selectedCurreny
            .flatMapLatest(repository.fetchCoinPrice)
            .bind(to: price)
            .disposed(by: disposeBag)
        
        price
            .withLatestFrom(itemPickerViewModel.selectedCurreny) { priceString, currency in
                (priceString, currency)
            }
            .bind(to: selectedData)
            .disposed(by: disposeBag)
        
    }
}
