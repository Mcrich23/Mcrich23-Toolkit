//
//  Data Structs.swift
//  
//
//  Created by Morris Richman on 3/28/22.
//

import Foundation
/**
 Different types of glyphs, whether it be icons, or images. one variable for all the types.
 */
public enum glyphImage: Hashable, Equatable {
    case systemImage(named: String)
    case assetImage(named: String)
    case remoteImage(named: URL)
    case defaultIcon
}
/**
Class for all the free floating functions
 */
public class Mcrich23_Toolkit {
    
}
