//
//  StationSearchNetwork.swift
//  SubwayRealTimeArrival
//
//  Created by 엄태양 on 2022/07/30.
//

import Foundation
import RxSwift

enum StationSearchError: Error {
    case invalidURL
    case invalidJSON
    case networkError
}

struct StationSearchNetwork {
    private let session: URLSession
    let api = StationSearchAPI()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func searchStation(query: String) -> Single<Result<SearchInfoBySubwayNameServiceData, Error>> {
        
        guard let url = URL(string: "http://openapi.seoul.go.kr:8088/sample/json/SearchInfoBySubwayNameService/1/5/\(query)/".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else {
            print("Error invalidURL")
            return Single.just(.failure(StationSearchError.invalidURL))
        }
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        
        return session.rx.data(request: request as URLRequest)
            .map { data in
                do {
                    let stationData = try JSONDecoder().decode(SearchInfoBySubwayNameServiceData.self, from: data)
                    return .success(stationData)
                } catch {
                    print("Error invalidJSON")
                    return .failure(StationSearchError.invalidJSON)
                }
            }
            .catch { _ in
                print("Error NetwokError")
                return .just(.failure(StationSearchError.networkError))
            }
            .asSingle()
    }
}
