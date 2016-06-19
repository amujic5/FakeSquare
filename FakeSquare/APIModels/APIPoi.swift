//
//  APIPoi.swift
//  FakeSquare
//
//  Created by Azzaro Mujic on 19/06/16.
//  Copyright © 2016 Azzaro Mujic. All rights reserved.
//

import Foundation
import ObjectMapper
import MapKit

final class APIPoi: NSObject, Mappable {

    var poiId: String?
    var title: String?
    var address: String?
    var tel: String?
    var lat: Double = 0
    var lng: Double = 0
    var imageURL: String = ""
    
    
    required init?(_ map: Map) {
        super.init()
        mapping(map)
    }
    
    func mapping(map: Map) {
        poiId <- map["id"]
        title <- map["title"]
        address <- map["address"]
        tel <- map["tel"]
        imageURL <- map["image"]
        lat <- map["lat"]
        lng <- map["lng"]
    }
    
}

extension APIPoi: MKAnnotation {
    @objc var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: lat, longitude: lng)
    }
    
    var subtitle: String? {
        return address
    }
}