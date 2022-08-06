//
//  StationSearchViewModel.swift
//  SubwayRealTimeArrival
//
//  Created by 엄태양 on 2022/07/29.
//

import RxSwift
import RxRelay
import RxCocoa

struct StationSearchViewModel {
    let disposeBag = DisposeBag()
    
    let keyword = PublishRelay<String?>()
    let textChangeDidfinish = PublishRelay<Void>()
    let textChangeStart = PublishRelay<Void>()
    let cellSelected = PublishRelay<Int>()
    
    let cellData: Driver<[Station]>
    let selectedStation: Driver<Station>
        
    
    init(_ repository: StationSearchRepository = StationSearchRepository()) {
        
        cellData = keyword
            .flatMapLatest (repository.fetchStationData)
            .asDriver(onErrorJustReturn: [])
        
        selectedStation = cellSelected
            .withLatestFrom(cellData) { idx, stations in
                return stations[idx]
            }
            .asDriver(onErrorJustReturn: Station(name: "", line: ""))
        
    }
}
