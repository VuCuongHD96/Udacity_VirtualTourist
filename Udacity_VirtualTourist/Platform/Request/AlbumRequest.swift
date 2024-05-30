//
//  AlbumRequest.swift
//  Udacity_VirtualTourist
//
//  Created by Work on 25/5/24.
//

import CoreLocation

class AlbumRequest: ServiceBaseRequest {
    
    init(pinEntity: PinEntity) {
        let params: [String : Any] = [
            "method" : "flickr.photos.search",
            "lat": pinEntity.latitude,
            "lon": pinEntity.longitude,
            "per_page": 10,
            "format": "json",
            "nojsoncallback": 1
        ]
        super.init(urlString: URLs.rest, requestType: .get, params: params)
    }
}
