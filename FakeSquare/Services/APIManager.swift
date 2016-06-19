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

final class APIManager {
    
    
    let manager: Manager
    
    init() {
        manager = Alamofire.Manager.sharedInstance
    }

    
    func pois(completion: (pois:[APIPoi]) -> Void) {
        let url = "https://demo0131377.mockable.io/places"
        
        manager
            .request(.GET, url, parameters: nil, encoding: .JSON, headers: nil)
            .responseJSON { (jsonResponse) in
                
                if let pois: [APIPoi] = Mapper<APIPoi>().mapArray(jsonResponse.result.value) {
                    completion(pois: pois)
                } else {
                    completion(pois: [])
                }
                
        }
        
    }
    
}