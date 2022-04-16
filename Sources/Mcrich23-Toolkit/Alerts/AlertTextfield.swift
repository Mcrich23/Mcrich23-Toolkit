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
    @State var placeholder: String
    @State var clearButtonMode: UITextField.ViewMode
    @State var enablesReturnKeyAutomatically: Bool
    @State var disableAutocorrection: Bool
    @State var autocapitalization: UITextAutocapitalizationType
    @State var keyboardType: UIKeyboardType
    @State var returnKeyType: UIReturnKeyType
    @State var isSecureTextEntry: Bool
    @State var dismissKeyboardOnReturn: Bool
    public init(text: Binding<String>, placeholder: String, clearButtonMode: UITextField.ViewMode, enablesReturnKeyAutomatically: Bool, disableAutocorrection: Bool, autocapitalization: UITextAutocapitalizationType, keyboardType: UIKeyboardType, returnKeyType: UIReturnKeyType, isSecureTextEntry: Bool, dismissKeyboardOnReturn: Bool) {
        self._text = text
        self.placeholder = placeholder
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
// MARK: Additional Initializers
extension AlertTextfield {
    enum DefaultTypes: CaseIterable {
        case clearButtonMode
        case enablesReturnKeyAutomatically
        case disableAutocorrection
        case autocapitalization
        case keyboardType
        case returnKeyType
        case isSecureTextEntry
        case dismissKeyboardOnReturn
    }
    func setDefaults(defaultsArray: [DefaultTypes]) {
        for defaultArray in defaultsArray {
            switch defaultArray {
            case .clearButtonMode:
                self.clearButtonMode = .whileEditing
            case .enablesReturnKeyAutomatically:
                self.enablesReturnKeyAutomatically = true
            case .disableAutocorrection:
                self.disableAutocorrection = false
            case .autocapitalization:
                self.autocapitalization = .sentences
            case .keyboardType:
                self.keyboardType = .default
            case .returnKeyType:
                self.returnKeyType = .default
            case .isSecureTextEntry:
                self.isSecureTextEntry = false
            case .dismissKeyboardOnReturn:
                self.dismissKeyboardOnReturn = true
            }
        }
    }
    public init(text: Binding<String>, placeholder: String) {
        self._text = text
        self.placeholder = placeholder
        setDefaults(defaultsArray: [.clearButtonMode, .enablesReturnKeyAutomatically, .disableAutocorrection, .autocapitalization, .keyboardType, .returnKeyType, .isSecureTextEntry, .dismissKeyboardOnReturn])
    }
    public init(text: Binding<String>, placeholder: String, autocapitalization: UITextAutocapitalizationType, disableAutocorrection: Bool) {
        self._text = text
        self.placeholder = placeholder
        self.disableAutocorrection = disableAutocorrection
        self.autocapitalization = autocapitalization
        setDefaults(defaultsArray: [.clearButtonMode, .enablesReturnKeyAutomatically, .keyboardType, .returnKeyType, .isSecureTextEntry, .dismissKeyboardOnReturn])
    }
    public init(text: Binding<String>, placeholder: String, isSecureTextEntry: Bool) {
        self._text = text
        self.placeholder = placeholder
        setDefaults(defaultsArray: [.clearButtonMode, .enablesReturnKeyAutomatically, .disableAutocorrection, .autocapitalization, .keyboardType, .returnKeyType, .dismissKeyboardOnReturn])
        self.isSecureTextEntry = isSecureTextEntry
    }
    public init(text: Binding<String>, placeholder: String, keyboardType: UIKeyboardType) {
        self._text = text
        self.placeholder = placeholder
        setDefaults(defaultsArray: [.clearButtonMode, .enablesReturnKeyAutomatically, .disableAutocorrection, .autocapitalization, .returnKeyType, .isSecureTextEntry, .dismissKeyboardOnReturn])
        self.keyboardType = keyboardType
    }
    public init(text: Binding<String>, placeholder: String, keyboardType: UIKeyboardType, returnKeyType: UIReturnKeyType, clearButtonMode: UITextField.ViewMode) {
        self._text = text
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.returnKeyType = returnKeyType
        self.clearButtonMode = clearButtonMode
        setDefaults(defaultsArray: [.enablesReturnKeyAutomatically, .disableAutocorrection, .autocapitalization, .isSecureTextEntry, .dismissKeyboardOnReturn])
    }
}
#endif
