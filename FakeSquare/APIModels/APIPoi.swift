//
//  APIPoi.swift
//  FakeSquare
//
//  Created by Azzaro Mujic on 19/06/16.
//  Copyright © 2016 Azzaro Mujic. All rights reserved.
//

import Foundation
import ObjectMapper

struct APIPoi: Mappable {

    var poiId: String?
    var title: String?
    var address: String?
    var tel: String?
    var lat: Double = 0
    var lng: Double = 0
    var imageURL: String = ""
    
    
    init?(_ map: Map) {
        mapping(map)
    }
    
    mutating func mapping(map: Map) {
        poiId <- map["id"]
        title <- map["title"]
        address <- map["address"]
        tel <- map["tel"]
        imageURL <- map["image"]
        lat <- map["lat"]
        lng <- map["lng"]
    }
    
}