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
    
    init() {
        
        cellData = keyword
            .flatMapLatest { query in
                StationSearchNetwork()
                    .searchStation(query: query ?? "")
            }
            .compactMap{ result -> SearchInfoBySubwayNameServiceData? in
                guard case .success(let data) = result else { return nil }
                return data
            }
            .map { data in
                return data.SearchInfoBySubwayNameService.row
            }
            .asDriver(onErrorJustReturn: [])
        
    }
}
