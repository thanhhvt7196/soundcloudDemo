//
//  HomeViewModel.swift
//  myNews
//
//  Created by kennyS on 2/2/20.
//  Copyright © 2020 kennyS. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
import SVProgressHUD

class HomeViewModel: ViewModel {
    let errorTracker = ErrorTracker()
    let activityIndicator = ActivityIndicator()
    let refreshIndicator = ActivityIndicator()
    private let bag = DisposeBag()
    
    func transform(input: Input) -> Output {
        let playLists = input.loadDataTrigger.flatMapLatest { [unowned self] _ in
            return self.request()
                .trackError(self.errorTracker)
                .trackActivity(self.activityIndicator)
            }
            .map { $0.map { $0.tracks?.first }.compactMap { $0 } }
            .unwrap()
        return Output(playLists: playLists, loading: activityIndicator.asObservable())
    }
    
    private func request() -> Observable<[PlayList]> {
        let url = URL(string: "http://api.soundcloud.com/playlists")!
        let params: [String: Any] = ["client_id": "a25e51780f7f86af0afa91f241d091f8",
                                     "kind": "top",
                                     "genre": "alternativerock",
                                     "offset": 0,
                                     "limit": 20]
        return Observable.create { observer in
            AF.request(url, method: .get, parameters: params)
                .validate()
                .responseData { response in
                    print(response.request?.url?.absoluteString)
                    switch response.result {
                    case .success(let data):
                        if let statusCode = response.response?.statusCode, statusCode == 200 {
                            do {
                                let object = try JSONDecoder().decode([PlayList].self, from: data)
                                observer.onNext(object)
                            } catch let error {
                                print(error)
                                observer.onError(error)
                            }
                        } else {
                            do {
                                let object = try JSONDecoder().decode(ErrorDetails.self, from: data)
                                observer.onError(object)
                            } catch let error {
                                observer.onError(error)
                            }
                        }
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                        observer.onCompleted()
                    }
            }
            return Disposables.create { }
        }
    }
}

extension HomeViewModel {
    private func clearCache() {

    }
}

extension HomeViewModel {
    struct Input {
        var loadDataTrigger: Observable<Void>
        var itemSelected: Observable<IndexPath>
    }
    
    struct Output {
        var playLists: Observable<[Track]>
        var loading: Observable<Bool>
    }
}
