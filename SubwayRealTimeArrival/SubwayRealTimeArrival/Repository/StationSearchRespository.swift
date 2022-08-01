//
//  StationSearchModel.swift
//  SubwayRealTimeArrival
//
//  Created by 엄태양 on 2022/08/01.
//

import RxSwift

struct StationSearch {
    
    func fetchStationData (query: String?) -> Single<Result<SearchInfoBySubwayNameServiceData, Error>> {
        StationSearchNetwork()
            .searchStation(query: query ?? "")
    }
    
    func parseData(result: Result<SearchInfoBySubwayNameServiceData, Error>) -> [Station]? {
        guard case .success(let data) = result else { return nil }
        return data.SearchInfoBySubwayNameService.row
    }    
    
}
