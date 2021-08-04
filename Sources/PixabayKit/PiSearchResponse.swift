//
//  File.swift
//  
//
//  Created by Rob Jonson on 03/08/2021.
//

import Foundation

public struct PiSearchResponse:Codable {
    let totalResults:Int
    let photos:[PiPhoto]
    
    enum CodingKeys: String, CodingKey {
        case totalResults="totalHits",photos="hits"
    }
}
