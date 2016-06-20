//
//  FakeManager.swift
//  FakeSquare
//
//  Created by Azzaro Mujic on 20/06/16.
//  Copyright © 2016 Azzaro Mujic. All rights reserved.
//

import Foundation

final class FakeManager {
    
    static let sharedInstance = FakeManager()
    var shouldStealData: Bool = false
    
}