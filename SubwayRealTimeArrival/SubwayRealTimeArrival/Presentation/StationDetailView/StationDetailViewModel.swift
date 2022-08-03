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
    
    init(_ repository: StationDetail = StationDetail()) {
        cellData = station
            .flatMapLatest(repository.fetchRealtimeArrivalData)
            .compactMap(repository.parseData)
            .asDriver(onErrorJustReturn: [])
    }
}
