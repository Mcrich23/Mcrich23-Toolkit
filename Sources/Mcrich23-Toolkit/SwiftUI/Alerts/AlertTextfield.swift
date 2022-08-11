//
//  AlertTextfield.swift
//  
//
//  Created by Morris Richman on 3/28/22.
//

import Foundation
import SwiftUI

#if os(iOS) || os(tvOS) || os(watchOS) || targetEnvironment(macCatalyst)// || os(macOS)
import SwiftUIX

public enum IsSecureTextFieldOptions {
    case yes(passwordRules: UITextInputPasswordRules)
    case no
}

public struct AlertTextfield {
    @Binding var text: String
    @State var keyboardAppearance: UIKeyboardAppearance
    @State var placeholder: String
    @State var clearButtonMode: UITextField.ViewMode
    @State var enablesReturnKeyAutomatically: Bool
    @State var autocorrectionType: UITextAutocorrectionType
    @State var autocapitalization: UITextAutocapitalizationType
    @State var keyboardType: UIKeyboardType
    @State var returnKeyType: UIReturnKeyType
    @State var isSecureTextEntry: IsSecureTextFieldOptions
    @State var dismissKeyboardOnReturn: Bool
    
    public init(text: Binding<String>, placeholder: String, clearButtonMode: UITextField.ViewMode, enablesReturnKeyAutomatically: Bool, autocorrectionType: UITextAutocorrectionType, autocapitalization: UITextAutocapitalizationType, keyboardType: UIKeyboardType, keyboardAppearance: UIKeyboardAppearance, returnKeyType: UIReturnKeyType, isSecureTextEntry: IsSecureTextFieldOptions, dismissKeyboardOnReturn: Bool) {
        self._text = text
        self.placeholder = placeholder
        self.keyboardAppearance = keyboardAppearance
        self.clearButtonMode = clearButtonMode
        self.enablesReturnKeyAutomatically = enablesReturnKeyAutomatically
        self.autocorrectionType = autocorrectionType
        self.autocapitalization = autocapitalization
        self.keyboardType = keyboardType
        self.returnKeyType = returnKeyType
        self.isSecureTextEntry = isSecureTextEntry
        self.dismissKeyboardOnReturn = dismissKeyboardOnReturn
    }
// MARK: Additional Initializers
    public init(text: Binding<String>, placeholder: String) {
        self._text = text
        self.placeholder = placeholder
        self.clearButtonMode = .whileEditing
        self.enablesReturnKeyAutomatically = true
        self.autocorrectionType = .default
        self.autocapitalization = .sentences
        self.keyboardType = .default
        self.keyboardAppearance = .default
        self.returnKeyType = .default
        self.isSecureTextEntry = .no
        self.dismissKeyboardOnReturn = true
    }
    public init(text: Binding<String>, placeholder: String, keyboardType: UIKeyboardType, keyboardAppearance: UIKeyboardAppearance, autocapitalization: UITextAutocapitalizationType, autocorrectionType: UITextAutocorrectionType) {
        self._text = text
        self.placeholder = placeholder
        self.autocorrectionType = autocorrectionType
        self.autocapitalization = autocapitalization
        self.clearButtonMode = .whileEditing
        self.enablesReturnKeyAutomatically = true
        self.keyboardType = .default
        self.keyboardAppearance = keyboardAppearance
        self.returnKeyType = .default
        self.isSecureTextEntry = .no
        self.dismissKeyboardOnReturn = true
    }
    public init(text: Binding<String>, placeholder: String, isSecureTextEntry: IsSecureTextFieldOptions) {
        self._text = text
        self.placeholder = placeholder
        self.clearButtonMode = .whileEditing
        self.enablesReturnKeyAutomatically = true
        self.autocorrectionType = .default
        self.autocapitalization = .sentences
        self.keyboardType = .default
        self.keyboardAppearance = .default
        self.returnKeyType = .default
        self.dismissKeyboardOnReturn = true
        self.isSecureTextEntry = isSecureTextEntry
    }
    public init(text: Binding<String>, placeholder: String, keyboardType: UIKeyboardType) {
        self._text = text
        self.placeholder = placeholder
        self.clearButtonMode = .whileEditing
        self.enablesReturnKeyAutomatically = true
        self.autocorrectionType = .default
        self.autocapitalization = .sentences
        self.returnKeyType = .default
        self.isSecureTextEntry = .no
        self.dismissKeyboardOnReturn = true
        self.keyboardType = keyboardType
        self.keyboardAppearance = .default
    }
    public init(text: Binding<String>, placeholder: String, keyboardType: UIKeyboardType, keyboardAppearance: UIKeyboardAppearance, returnKeyType: UIReturnKeyType, clearButtonMode: UITextField.ViewMode) {
        self._text = text
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.keyboardAppearance = keyboardAppearance
        self.returnKeyType = returnKeyType
        self.clearButtonMode = clearButtonMode
        self.enablesReturnKeyAutomatically = true
        self.autocorrectionType = .default
        self.autocapitalization = .sentences
        self.isSecureTextEntry = .no
        self.dismissKeyboardOnReturn = true
    }
}
#endif
