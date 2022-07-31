//
//  StationDetailViewModel.swift
//  SubwayRealTimeArrival
//
//  Created by 엄태양 on 2022/07/31.
//

import RxSwift
import RxRelay
import RxCocoa

struct StationDetailViewModel {
    
    let station = PublishSubject<Station>()
    
    let cellData: Driver<[RealtimeArrivalData]>
    
    init() {
        cellData = station
            .flatMapLatest({ station in
                RealtimeArrivalNetwork()
                    .fetchRealtimeArrivalData(for: station)
            })
            .compactMap { result in
                guard case .success(let data) = result else { return [] }
                return data.realtimeArrivalList
            }
            .asDriver(onErrorJustReturn: [])
    }
}
