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
    
    let keyword = PublishRelay<String?>()
    
    let cellData: Driver<[Station]>

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
                print(data)
                return data.SearchInfoBySubwayNameService.row
            }
            .asDriver(onErrorJustReturn: [])
            
    }
}
