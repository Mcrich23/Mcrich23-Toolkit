//
//  File.swift
//  
//
//  Created by Morris Richman on 3/28/22.
//

import Foundation
import SwiftUI
import SwiftUIX

public struct swiftUIAlert {
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
                tf.placeholder = textfield.placeholder
                tf.text = textfield.text
                tf.clearButtonMode = textfield.clearButtonMode
//                tf.clearsOnBeginEditing = textfield.clearsOnBeginEditing
                tf.enablesReturnKeyAutomatically = textfield.enablesReturnKeyAutomatically
                if textfield.disableAutocorrection {
                    tf.autocorrectionType = .no
                }else {
                    tf.autocorrectionType = .yes
                }
                tf.autocapitalizationType = textfield.autocapitalization
//                tf.font = textfield.font
                tf.returnKeyType = textfield.returnKeyType
                tf.keyboardType = textfield.keyboardType
        }
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
public struct AlertTextfield: View {
    @Binding var text: String
    @State var placeholder: String
    @State var clearButtonMode: UITextField.ViewMode
    @State var enablesReturnKeyAutomatically: Bool
    @State var disableAutocorrection: Bool
    @State var autocapitalization: UITextAutocapitalizationType
//    @State var font: Font
//    @State var fontWeight: Font.Weight
    @State var keyboardType: UIKeyboardType
    @State var returnKeyType: UIReturnKeyType
    @State var isSecureTextEntry: Bool
    @State var dismissKeyboardOnReturn: Bool
    public init(text: Binding<String>, placeholder: String, clearButtonMode: UITextField.ViewMode, enablesReturnKeyAutomatically: Bool, disableAutocorrection: Bool, autocapitalization: UITextAutocapitalizationType, keyboardType: UIKeyboardType, returnKeyType: UIReturnKeyType, isSecureTextEntry: Bool, dismissKeyboardOnReturn: Bool) { //font: Font, fontWeight: Font.Weight) {
        self._text = text
        self.placeholder = placeholder
        self.clearButtonMode = clearButtonMode
        self.enablesReturnKeyAutomatically = enablesReturnKeyAutomatically
        self.disableAutocorrection = disableAutocorrection
        self.autocapitalization = autocapitalization
//        self.font = font
//        self.fontWeight = fontWeight
        self.keyboardType = keyboardType
        self.returnKeyType = returnKeyType
        self.isSecureTextEntry = isSecureTextEntry
        self.dismissKeyboardOnReturn = dismissKeyboardOnReturn
    }
    
    public var body: some View {
        CocoaTextField("title", text: $text)
            .dismissKeyboardOnReturn(dismissKeyboardOnReturn)
            .secureTextEntry(isSecureTextEntry)
            .returnKeyType(returnKeyType)
            .clearButtonMode(clearButtonMode)
            .enablesReturnKeyAutomatically(enablesReturnKeyAutomatically)
            .disableAutocorrection(disableAutocorrection)
            .autocapitalization(autocapitalization)
//            .font(font, weight: fontWeight)
            .keyboardType(keyboardType)
    }
}
