//
//  Currency.swift
//  currencylist
//
//  Created by Andrey Oshev on 11/04/2018.
//  Copyright © 2018 Andrey Oshev. All rights reserved.
//

import UIKit
import ObjectMapper

class Currency: Mappable {
    var name: String = ""
    var volume: Int = 0
    var amount: Double = 0.0
    
    required init?(map: Map) {
        
    }
    
    // MARK: - Mapping
    
    func mapping(map: Map) {
        name    <- map["name"]
        volume  <- map["volume"]
        amount  <- map["price.amount"]
    }
}
