//
//  MainViewModel.swift
//  ByteCoinMVVM
//
//  Created by 엄태양 on 2022/08/03.
//

import RxSwift
import RxCocoa

struct MainViewModel {
    let itemPickerViewModel = ItemPickerViewModel()
    
    let price: Observable<Double>
    
    init(repository: CoinDataRepository = CoinDataRepository()) {
        
        price = self.itemPickerViewModel.selectedCurreny
            .flatMapLatest(repository.fetchCoinPrice)
            .map(repository.parseData)
            .map(repository.roundRate)
            
    }
}
