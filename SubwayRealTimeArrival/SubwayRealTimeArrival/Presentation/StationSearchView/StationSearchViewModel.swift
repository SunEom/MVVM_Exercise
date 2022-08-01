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
    let selectedStation = PublishSubject<Station>()
    
    init(_ model: StationSearch = StationSearch()) {
        
        cellData = keyword
            .flatMapLatest (model.fetchStationData)
            .compactMap(model.parseData)
            .asDriver(onErrorJustReturn: [])
        
    }
}
