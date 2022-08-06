//
//  StationSearchModel.swift
//  SubwayRealTimeArrival
//
//  Created by 엄태양 on 2022/08/01.
//

import RxSwift

struct StationSearchRepository {
    
    func fetchStationData (query: String?) -> Observable<[Station]> {
        StationSearchNetwork()
            .searchStation(query: query ?? "")
            .asObservable()
            .compactMap(parseData)
    }
    
    private func parseData(result: Result<SearchInfoBySubwayNameServiceData, Error>) -> [Station]? {
        guard case .success(let data) = result else { return nil }
        return data.SearchInfoBySubwayNameService.row
    }    
    
}
