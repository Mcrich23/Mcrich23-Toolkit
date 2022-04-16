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

public struct AlertTextfield: View {
    @Binding var text: String
    @State var onCommit: () -> Void
    @State var placeholder: String
    @State var clearButtonMode: UITextField.ViewMode
    @State var enablesReturnKeyAutomatically: Bool
    @State var disableAutocorrection: Bool
    @State var autocapitalization: UITextAutocapitalizationType
    @State var keyboardType: UIKeyboardType
    @State var returnKeyType: UIReturnKeyType
    @State var isSecureTextEntry: Bool
    @State var dismissKeyboardOnReturn: Bool
    public init(text: Binding<String>, placeholder: String, clearButtonMode: UITextField.ViewMode, enablesReturnKeyAutomatically: Bool, disableAutocorrection: Bool, autocapitalization: UITextAutocapitalizationType, keyboardType: UIKeyboardType, returnKeyType: UIReturnKeyType, isSecureTextEntry: Bool, dismissKeyboardOnReturn: Bool, onCommit: @escaping () -> Void) {
        self._text = text
        self.placeholder = placeholder
        self.onCommit = onCommit
        self.clearButtonMode = clearButtonMode
        self.enablesReturnKeyAutomatically = enablesReturnKeyAutomatically
        self.disableAutocorrection = disableAutocorrection
        self.autocapitalization = autocapitalization
        self.keyboardType = keyboardType
        self.returnKeyType = returnKeyType
        self.isSecureTextEntry = isSecureTextEntry
        self.dismissKeyboardOnReturn = dismissKeyboardOnReturn
    }
    
    public var body: some View {
        CocoaTextField("title", text: $text, onCommit: {
            self.onCommit
        })
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
// MARK: Additional Initializers
extension AlertTextfield {
    public init(text: Binding<String>, placeholder: String) {
        self._text = text
        self.placeholder = placeholder
        self.onCommit = {}
        self.clearButtonMode = .whileEditing
        self.enablesReturnKeyAutomatically = true
        self.disableAutocorrection = false
        self.autocapitalization = .sentences
        self.keyboardType = .default
        self.returnKeyType = .default
        self.isSecureTextEntry = false
        self.dismissKeyboardOnReturn = true
    }
    public init(text: Binding<String>, placeholder: String, autocapitalization: UITextAutocapitalizationType, disableAutocorrection: Bool, onCommit: @escaping () -> Void) {
        self._text = text
        self.placeholder = placeholder
        self.onCommit = onCommit
        self.disableAutocorrection = disableAutocorrection
        self.autocapitalization = autocapitalization
        self.clearButtonMode = .whileEditing
        self.enablesReturnKeyAutomatically = true
        self.keyboardType = .default
        self.returnKeyType = .default
        self.isSecureTextEntry = false
        self.dismissKeyboardOnReturn = true
    }
    public init(text: Binding<String>, placeholder: String, isSecureTextEntry: Bool) {
        self._text = text
        self.placeholder = placeholder
        self.onCommit = {}
        self.clearButtonMode = .whileEditing
        self.enablesReturnKeyAutomatically = true
        self.disableAutocorrection = false
        self.autocapitalization = .sentences
        self.keyboardType = .default
        self.returnKeyType = .default
        self.dismissKeyboardOnReturn = true
        self.isSecureTextEntry = isSecureTextEntry
    }
    public init(text: Binding<String>, placeholder: String, keyboardType: UIKeyboardType) {
        self._text = text
        self.placeholder = placeholder
        self.onCommit = {}
        self.clearButtonMode = .whileEditing
        self.enablesReturnKeyAutomatically = true
        self.disableAutocorrection = false
        self.autocapitalization = .sentences
        self.returnKeyType = .default
        self.isSecureTextEntry = false
        self.dismissKeyboardOnReturn = true
        self.keyboardType = keyboardType
    }
    public init(text: Binding<String>, placeholder: String, keyboardType: UIKeyboardType, returnKeyType: UIReturnKeyType, clearButtonMode: UITextField.ViewMode, onCommit: @escaping () -> Void) {
        self._text = text
        self.placeholder = placeholder
        self.onCommit = onCommit
        self.keyboardType = keyboardType
        self.returnKeyType = returnKeyType
        self.clearButtonMode = clearButtonMode
        self.enablesReturnKeyAutomatically = true
        self.disableAutocorrection = false
        self.autocapitalization = .sentences
        self.isSecureTextEntry = false
        self.dismissKeyboardOnReturn = true
    }
}
#endif
