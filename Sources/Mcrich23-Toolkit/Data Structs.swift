//
//  Data Structs.swift
//  
//
//  Created by Morris Richman on 3/28/22.
//

import Foundation

public enum glyphImage: Hashable, Equatable {
    case systemImage(named: String)
    case assetImage(named: String)
    case defaultIcon
}
