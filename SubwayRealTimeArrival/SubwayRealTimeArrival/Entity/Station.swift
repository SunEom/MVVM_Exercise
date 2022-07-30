//
//  Station.swift
//  SubwayRealTimeArrival
//
//  Created by 엄태양 on 2022/07/30.
//

import Foundation

struct SearchInfoBySubwayNameServiceData: Decodable {
    
    let SearchInfoBySubwayNameService: SearchInfoBySubwayNameService
    
    struct SearchInfoBySubwayNameService: Decodable {
        let row: [Station]
    }
}

struct Station: Decodable {
    let name: String
    let line: String
    
    enum CodingKeys: String, CodingKey {
        case name = "STATION_NM"
        case line = "LINE_NUM"
    }
}
