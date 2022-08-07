//
//  CoinDataRepository.swift
//  ByteCoinMVVM
//
//  Created by 엄태양 on 2022/08/04.
//

import Foundation
import RxSwift

struct CoinDataRepository {
    func fetchCoinPrice(query: String) -> Observable<String> {
        CoinPriceNetwork().fetchCoinPrice(query: query)
            .asObservable()
            .compactMap(parseData)
            .map(toString)
            
    }
    
    private func parseData(result: Result<CoinData, CoinPriceNetworkError> ) -> CoinData? {
        guard case .success(let data) = result else { return nil }
        return data
    }
    
    private func toString(data: CoinData?) -> String {
        return String(format: "%.3f", data?.rate ?? 0.0)
    }
    
}
