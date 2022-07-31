//
//  Arrival.swift
//  SubwayRealTimeArrival
//
//  Created by 엄태양 on 2022/07/31.
//

import Foundation

struct ArrivalData: Decodable {
    let realtimeArrivalList: [RealtimeArrivalData]
}

struct RealtimeArrivalData: Decodable {
    let direction: String?
    let currentLocation: String?
    
    enum CodingKeys: String, CodingKey {
        case direction = "trainLineNm"
        case currentLocation = "arvlMsg2"
    }
}
