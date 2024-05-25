//
//  ServiceBaseRequest.swift
//  MovieSwiftUI
//
//  Created by Work on 12/03/2023.
//

import Foundation

class ServiceBaseRequest {
    
    private(set) var urlString = ""
    private(set) var requestType = HTTPMethod.get
    private(set) var params: [String: Any] = [:]
    private(set) var body: Encodable?
    
    var url: URL? {
        guard let url = URL(string: urlString) else {
            return nil
        }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = params.map {
            URLQueryItem(name: $0, value: "\($1)" )
        }
        
        return components?.url
    }
    
    var httpBody: Data? {
        guard let body = body else {
            return nil
        }
        let encoder = JSONEncoder()
        let data = try? encoder.encode(body)
        return data
    }
    
    init(urlString: String) {
        self.urlString = urlString
    }
    
    init(urlString: String, requestType: HTTPMethod) {
        self.urlString = urlString
        self.requestType = requestType
    }

    init(urlString: String, requestType: HTTPMethod, params: [String: Any]?) {
        self.urlString = urlString
        self.requestType = requestType
        var copyParams = params ?? [:]
        copyParams["api_key"] = API.key
        self.params = copyParams
        self.body = nil
    }
    
    init(urlString: String, requestType: HTTPMethod, body: Encodable?) {
        self.urlString = urlString
        self.requestType = requestType
        self.body = body
    }
}
