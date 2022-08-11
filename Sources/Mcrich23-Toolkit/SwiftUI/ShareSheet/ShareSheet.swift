//
//  ShareSheet.swift
//  Pickt
//
//  Created by Morris Richman on 3/24/22.
//

import Foundation
import SwiftUI

struct ShareSheet: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIActivityViewController

    var sharing: [Any]
    var excludedActivityTypes: [UIActivity.ActivityType]

    func makeUIViewController(context: UIViewControllerRepresentableContext<ShareSheet>) -> UIActivityViewController {
        let activity = UIActivityViewController(activityItems: sharing, applicationActivities: nil)
        activity.excludedActivityTypes = excludedActivityTypes
        return activity
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ShareSheet>) {

    }
}

extension Mcrich23_Toolkit {
    /**
     Presents a share sheet
     
     - parameter activityItems: Items to share in the share sheet.
     - parameter excludedActivityTypes: Application that are excluded from the share sheet.
     
     # Example #
     ```
     Mcrich23_Toolkit.presentShareSheet(activityItems: ["Hello World"])
     ```
     */
    public static func presentShareSheet(activityItems: [Any], excludedActivityTypes: [UIActivity.ActivityType]) {
        let activityController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        activityController.excludedActivityTypes = excludedActivityTypes
        guard var topVC = UIApplication.shared.windows.first?.rootViewController else {
            return
        }
        // iterate til we find the topmost presented view controller
        // if you don't you'll get an error since you can't present 2 vcs from the same level
        while let presentedVC = topVC.presentedViewController {
            topVC = presentedVC
        }
        if UIDevice.current.userInterfaceIdiom == .phone {
            topVC.present(activityController, animated: true)
        } else {
            topVC.present {
                ShareSheet(sharing: activityItems, excludedActivityTypes: excludedActivityTypes)
            }
        }
    }
}
