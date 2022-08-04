//
//  CoinDataRepository.swift
//  ByteCoinMVVM
//
//  Created by 엄태양 on 2022/08/04.
//

import Foundation
import RxSwift

struct CoinDataRepository {
    func fetchCoinPrice(query: String) -> Single<Result<CoinData, CoinPriceNetworkError>> {
        CoinPriceNetwork().fetchCoinPrice(query: query)
    }
    
    func parseData(result: Result<CoinData, CoinPriceNetworkError>) -> CoinData? {
        guard case .success(let data) = result else { return nil }
        return data
    }
    
    func roundRate(data: CoinData?) -> Double {
        guard let rate = data?.rate else { return 0.0 }
        return Double(Int(rate*1000)) * 0.001
    }
}
