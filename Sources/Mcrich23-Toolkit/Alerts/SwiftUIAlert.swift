//
//  SwiftUIAlert.swift
//  
//
//  Created by Morris Richman on 3/28/22.
//

import Foundation
import SwiftUI

#if os(iOS) || os(tvOS) || os(watchOS) || targetEnvironment(macCatalyst)// || os(macOS)
import SwiftUIX

public struct SwiftUIAlert {
    public static func show(title: String, message: String, preferredStyle: UIAlertController.Style, actions: [UIAlertAction]) {
        let presentingAlert = UIAlertController(title: NSLocalizedString(title, comment: ""), message: NSLocalizedString(message, comment: ""), preferredStyle: preferredStyle)
        for action in actions {
            presentingAlert.addAction(action)
        }
        guard var topVC = UIApplication.shared.windows.first?.rootViewController else {
            return
        }
        // iterate til we find the topmost presented view controller
        // if you don't you'll get an error since you can't present 2 vcs from the same level
        while let presentedVC = topVC.presentedViewController {
            topVC = presentedVC
        }
        topVC.present(presentingAlert, animated: true, completion: nil)
    }
    public static func textfieldShow(title: String, message: String, preferredStyle: UIAlertController.Style, textfield: AlertTextfield, actions: [UIAlertAction]) {
        let presentingAlert = UIAlertController(title: NSLocalizedString(title, comment: ""), message: NSLocalizedString(message, comment: ""), preferredStyle: preferredStyle)
            presentingAlert.addTextField { tf in
                tf.placeholder = NSLocalizedString(textfield.placeholder, comment: "")
                tf.text = textfield.text
                tf.clearButtonMode = textfield.clearButtonMode
//                tf.clearsOnBeginEditing = textfield.clearsOnBeginEditing
                tf.enablesReturnKeyAutomatically = textfield.enablesReturnKeyAutomatically
                if textfield.disableAutocorrection {
                    tf.autocorrectionType = .no
                } else {
                    tf.autocorrectionType = .yes
                }
                tf.autocapitalizationType = textfield.autocapitalization
//                tf.font = textfield.font
                tf.returnKeyType = textfield.returnKeyType
                tf.keyboardType = textfield.keyboardType
                tf.keyboardAppearance = textfield.keyboardAppearance
        }
        func setText() {
            if let textField = presentingAlert.textFields?.first, let text = textField.text {
//                print("Code = \(text)")
                textfield.text = text
            }
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                setText()
            }
        }
        setText()
        for action in actions {
            presentingAlert.addAction(action)
        }
        guard var topVC = UIApplication.shared.windows.first?.rootViewController else {
            return
        }
        // iterate til we find the topmost presented view controller
        // if you don't you'll get an error since you can't present 2 vcs from the same level
        while let presentedVC = topVC.presentedViewController {
            topVC = presentedVC
        }
        topVC.present(presentingAlert, animated: true, completion: nil)
    }
}
#endif
