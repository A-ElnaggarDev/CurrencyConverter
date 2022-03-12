//
//  APIClient.swift
//  CurrencyConverter
//
//  Created by maika on 11/03/2022.
//

import Foundation
import RxSwift

class APIClient {
    enum Endpoint {
        static let accessKey = "?access_key="
        
        case rates
        
        var stringValue: String {
            switch self {
            case .rates:
                return baseUrl + "latest?access_key=" + apiKey
            }
        }
        
        var stringToUrl: URL {
            return URL(string: stringValue)!
        }
    }
    
    static func fetchCurrencies() -> Observable<CurrecnyRatesModel> {
        return Observable.create { observable -> Disposable in
            let task = URLSession.shared.dataTask(with: Endpoint.rates.stringToUrl) { data, response, error in
                guard let data = data else {
                    observable.onError(NSError(domain: "", code: -1, userInfo: nil))
                    observable.onCompleted()
                    return
                }
                do {
                    let currency = try JSONDecoder().decode(CurrecnyRatesModel.self, from: data)
                    print(currency)
                    observable.onNext(currency)
                } catch {
                    observable.onError(error)
                }
                observable.onCompleted()
            }
            
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
