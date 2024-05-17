//
//  APIService.swift
//  MovieSwiftUI
//
//  Created by Work on 11/03/2023.
//

import Combine
import Foundation

struct APIService {
    
    static let share = APIService()
    private var session = URLSession.shared
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 5
        configuration.timeoutIntervalForResource = 5
        session = URLSession(configuration: configuration)
    }
    
    func request<T: Decodable>(input: ServiceBaseRequest) -> Observable<T> {
        guard let url = input.url else {
            return Fail(error: BaseError.redirectionError).eraseToAnyPublisher()
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = input.httpBody
        urlRequest.httpMethod = input.requestType.rawValue

        return session
            .dataTaskPublisher(for: urlRequest)
            .subscribe(on: DispatchQueue.global())
            .tryMap { data, response in
                print("\n------------REQUEST INPUT")
                print("Link: %@", input.urlString)
                print("Body: %@", input.httpBody ?? Data())
                print("Params: %@", input.params)
                print("------------ END REQUEST INPUT\n")
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                    throw BaseError.redirectionError
                }
                if statusCode == 200 {
                    if input.urlString.contains(URLs.login) || input.urlString.contains(URLs.userInfo) {
                        let range = 5..<data.count
                        let newData = data.subdata(in: range)
                        return newData
                    }
                    print("\n------------RESPONSE OUTPUT")
                    DictionaryPrinter.printBeauty(data: data)
                    print("------------END RESPONSE OUTPUT")
                    return data
                } else {
                    throw BaseError.httpError(httpCode: statusCode)
                }
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                return error
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
