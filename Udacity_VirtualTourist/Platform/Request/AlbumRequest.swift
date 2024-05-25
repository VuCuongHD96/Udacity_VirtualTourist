//
//  AlbumRequest.swift
//  Udacity_VirtualTourist
//
//  Created by Work on 25/5/24.
//

import Foundation

class AlbumRequest: ServiceBaseRequest {
    
    init() {
        let params: [String : Any] = [
            "method" : "flickr.photos.search",
            "lat": 21.392510,
            "lon": 109.284721,
            "per_page": 10,
            "format": "json",
            "nojsoncallback": 1
        ]
        super.init(urlString: URLs.rest, requestType: .get, params: params)
    }
}
