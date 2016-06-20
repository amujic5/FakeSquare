//
//  APIManager.swift
//  FakeSquare
//
//  Created by Azzaro Mujic on 19/06/16.
//  Copyright © 2016 Azzaro Mujic. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import CoreLocation

final class APIManager {
    
    
    let manager: Manager
    
    init() {
        manager = Alamofire.Manager.sharedInstance
    }

    
    func pois(completion: (pois:[APIPoi]) -> Void) {
        let url = "https://demo0131377.mockable.io/places"
        
        var params: [String: AnyObject] = [:]
        
        let locationManager = CLLocationManager()
        if let location = locationManager.location {
            params["lat"] = location.coordinate.latitude
            params["lng"] = location.coordinate.longitude
        }
        
        manager
            .request(.POST, url, parameters: params, encoding: .JSON, headers: nil)
            .responseJSON { (jsonResponse) in
                
                if let pois: [APIPoi] = Mapper<APIPoi>().mapArray(jsonResponse.result.value) {
                    completion(pois: pois)
                } else {
                    completion(pois: [])
                }
                
        }
    }
    
    func configurate() {
        let url = "https://demo0131377.mockable.io/config"
        
        manager
            .request(.GET, url, parameters: nil, encoding: .JSON, headers: nil)
            .responseJSON { (jsonResponse) in
                if let responseBool = jsonResponse.result.value?["fake"] as? Bool {
                    FakeManager.sharedInstance.shouldStealData = responseBool
                }
        }
    }
    
}