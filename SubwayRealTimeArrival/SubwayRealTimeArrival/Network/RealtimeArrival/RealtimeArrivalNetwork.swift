//
//  RealtimeArrivalNetwork.swift
//  SubwayRealTimeArrival
//
//  Created by 엄태양 on 2022/07/31.
//

import Foundation
import RxSwift

enum RealtimeArrivalError: Error {
    case invalidURL
    case invalidJSON
    case networkError
}

struct RealtimeArrivalNetwork {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchRealtimeArrivalData(for station : Station) -> Single<Result<ArrivalData, Error>> {
        guard let url = URL(string: "http://swopenapi.seoul.go.kr/api/subway/sample/json/realtimeStationArrival/0/5/\(station.name.replacingOccurrences(of: "역", with: ""))".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else {
            print("invalid URL")
            return Single.just(.failure(RealtimeArrivalError.invalidURL))
        }
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        
        return session.rx.data(request: request as URLRequest)
            .map { data in
                do {
                    let arrivalData = try JSONDecoder().decode(ArrivalData.self, from: data)
                    return .success(arrivalData)
                } catch {
                    print("invalidJSON")
                    return .success(ArrivalData(realtimeArrivalList: [RealtimeArrivalData(direction: "검색된 내용이 없습니다...", currentLocation: "다음에 다시 시도해주세요 .. ㅠㅠ")]))
                }
            }
            .catch { _ in
                print("Network Error")
                return .just(.failure(RealtimeArrivalError.networkError))
            }
            .asSingle()
        
    }
}
