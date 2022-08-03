# MVVM Exercise

과거의 프로젝트를 MVVM 패턴을 이용하여 다시 구현해봅시다!

## 1. 지하철 실시간 조회  - SubwayRealTimeArrival
[Refactoring 이전 코드](https://github.com/SunEom/TIL/tree/main/Swift/Upper%20Intermediate/SubwaySearch)

진행 상황 : Code Reviewing...

### 사용 기술 및 특징

1. RxSwift, RxCocoa
2. AutoLayout 코드 구현 (StoryBoard 및 SnapKit 사용 X) 
3. URLSession을 이용한 비동기 HTTP 통신
4. 서울 열린데이터 광장을 이용한 [지하철역 검색](https://data.seoul.go.kr/dataList/OA-121/S/1/datasetView.do)과 [지하철 실시간 도착정보](http://data.seoul.go.kr/dataList/OA-12764/F/1/datasetView.do) API 활용 
   - ~현재 sample API Key로 구현되어있기 때문에 일부의 역만 검색이 가능한 상태임~
   - 현재 위와 무관하게 정상적으로 작동되는 것을 확인 (2022.08.01 기준)
   - 검색 가능역 : 서울시 모든 역
5. SwiftPackageManager를 이용한 라이브러리 추가

## 2. 비트코인 환율 계산기  - ByteCoinMVVM
[Refactoring 이전 코드](https://github.com/SunEom/IOS-Development-Bootcamp/tree/main/ByteCoin)

진행 상황 : ing...

### 사용 기술 및 특징

1. RxSwift, RxCocoa
2. AutoLayout 코드 구현 (StoryBoard 및 SnapKit 사용 X) 
3. URLSession을 이용한 비동기 HTTP 통신
4. CoinAPI를 이용한 [환율 계산 API](https://docs.coinapi.io/#exchange-rates) 활용 
5. UIPickerView의 RxSwift 적용
6. CocoaPod을 이용한 라이브러리 추가
