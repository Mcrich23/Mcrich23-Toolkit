//
//  Data Structs.swift
//  
//
//  Created by Morris Richman on 3/28/22.
//

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS) || targetEnvironment(macCatalyst)
import UIKit
#elseif os(macOS)
import Cocoa
#endif
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
    public static func openUrl(url: String) {
        guard let url = URL(string: url) else { return }
        #if os(iOS) || os(tvOS) || os(watchOS) || targetEnvironment(macCatalyst)
            UIApplication.shared.open(url)
        #elseif os(macOS)
        NSWorkspace.shared.open(url)
        #endif
    }
}
