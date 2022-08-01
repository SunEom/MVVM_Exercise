//
//  StationDetailModel.swift
//  SubwayRealTimeArrival
//
//  Created by 엄태양 on 2022/08/01.
//

import RxSwift

struct StationDetail {
    
    func fetchRealtimeArrivalData(station: Station) -> Single<Result<ArrivalData, Error>> {
        return RealtimeArrivalNetwork()
            .fetchRealtimeArrivalData(for: station)
    }
    
    func parseData(result: Result<ArrivalData, Error>) -> [RealtimeArrivalData]? {
        guard case .success(let data) = result else { return nil }
        return data.realtimeArrivalList
    }
    
}
