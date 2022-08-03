//
//  FetchCoinPrice.swift
//  ByteCoinMVVM
//
//  Created by 엄태양 on 2022/08/03.
//

import Foundation
import RxSwift

enum CoinPriceNetworkError: Error {
    case invalidURL
    case invalidJSON
    case networkError
}

struct CoinPriceNetwork {
    
    private var session: URLSession
    
    init(_ session: URLSession = .shared){
        self.session = session
    }
    
    func fetchCoinPrice(query: String) -> Single<Result<CoinData, CoinPriceNetworkError>> {
        let urlString = "https://rest.coinapi.io/v1/exchangerate/\(query)/USD?apikey=\(Env().apikey)"
        
        guard let url = URL(string: urlString) else {
            print("CoinPriceNetworkError.invalidURL")
            return Single.just(.failure(CoinPriceNetworkError.invalidURL))
        }
        
        let request = URLRequest(url: url)
        
        return session.rx.data(request: request)
            .map { data -> Result<CoinData, CoinPriceNetworkError> in
                do {
                    let coinPriceData = try JSONDecoder().decode(CoinData.self, from: data)
                    
                    return .success(coinPriceData)
                } catch {
                    print("CoinPriceNetworkError.invalidJSON")
                    return .failure(CoinPriceNetworkError.invalidJSON)
                }
                
            }
            .catch { _ in
                print("CoinPriceNetworkError.networkError")
                return .just(.failure(CoinPriceNetworkError.networkError))
            }
            .asSingle()
    }
}
