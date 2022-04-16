//
//  Get TopView.swift
//  
//
//  Created by Morris Richman on 4/16/22.
//

import Foundation
import UIKit

extension Mcrich23_Toolkit {
    public static func getTopVC(completion: @escaping (_ topVC: UIViewController) -> Void) {
        guard var topVC = UIApplication.shared.windows.first?.rootViewController else {
            return
        }
        // iterate til we find the topmost presented view controller
        // if you don't you'll get an error since you can't present 2 vcs from the same level
        while let presentedVC = topVC.presentedViewController {
            topVC = presentedVC
        }
        completion(topVC)
    }
}