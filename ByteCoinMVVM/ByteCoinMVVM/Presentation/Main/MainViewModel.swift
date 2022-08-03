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
    
    init() {
        
        price = self.itemPickerViewModel.selectedCurreny
            .flatMapLatest {
                CoinPriceNetwork().fetchCoinPrice(query: $0)
            }
            .map { result -> CoinData? in
                guard case .success(let data) = result else { return nil }
                return data
            }
            .map { data in
                guard let rate = data?.rate else { return 0.0 }
                return Double(Int(rate*1000)) * 0.001
            }
            
    }
}
