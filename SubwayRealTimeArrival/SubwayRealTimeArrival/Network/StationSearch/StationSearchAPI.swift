//
//  StationSearchAPI.swift
//  SubwayRealTimeArrival
//
//  Created by 엄태양 on 2022/07/30.
//

import Foundation

struct StationSearchAPI {
    static let scheme = "https"
    static let host = "openapi.seoul.go.kr:8088"
    static let path = "sample/Json/SearchInfoBySubwayNameService/1/5/"
    
    func searchStation(query: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = StationSearchAPI.scheme
        components.host = StationSearchAPI.host
        components.path = StationSearchAPI.path + query
        
        return components
    }
}


