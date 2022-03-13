//
//  APIClient.swift
//  CurrencyConverter
//
//  Created by maika on 11/03/2022.
//

import Foundation
import Network
import RxSwift


enum NetworkError: Error {
    case noInternetConnection
}

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
    
    static func checkNetworkConnection(completion: @escaping (_ success: Bool) -> ()) {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status != .unsatisfied {
                completion(true)
            } else {
                completion(false)
            }
        }
        let networkQueue = DispatchQueue(label: "network")
        monitor.start(queue: networkQueue)
    }
    
    static func fetchCurrencies() -> Observable<CurrecnyRatesModel> {
//        if false {
//            return .error(NetworkError.noInternetConnection)
//        }
        return Observable.create { observable -> Disposable in
            let task = URLSession.shared.dataTask(with: Endpoint.rates.stringToUrl) { data, response, error in
                guard let data = data else {
                    observable.onError(NSError(domain: "", code: -1, userInfo: nil))
                    observable.onCompleted()
                    return
                }
                do {
                    let currency = try JSONDecoder().decode(CurrecnyRatesModel.self, from: data)
                    observable.onNext(currency)
                } catch {
                    do {
                        let errorMessage = try JSONDecoder().decode(CurrencyErrorModel.self, from: data)
                        observable.onError(errorMessage.error)
                    } catch {
                        observable.onError(error)
                    }
                    
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
