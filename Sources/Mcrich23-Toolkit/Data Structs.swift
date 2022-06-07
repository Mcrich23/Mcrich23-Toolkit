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
    /// SF Symbol
    case systemImage(named: String)
    /// Image From Assets
    case assetImage(named: String)
    /// Image From Remote Location
    case remoteImage(url: URL)
    case defaultIcon
}
/**
Class for all the free floating functions
 */
public class Mcrich23_Toolkit {
    
}
