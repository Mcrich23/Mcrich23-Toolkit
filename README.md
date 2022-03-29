# Mcrich23 Toolkit

This is a package that I made that has a bunch of qualities of life.

# Requirements 

- iOS 14, macOS 10.16, tvOS 14, or watchOS 67
- Swift 5.5+
- Xcode 13.0+

# Installation

The preferred way of installing SwiftUIX is via the [Swift Package Manager](https://swift.org/package-manager/).


1. In Xcode, open your project and navigate to **File** → **Add Packages...**
2. Paste the repository URL (`https://github.com/Mcrich23/Mcrich23-Toolkit`) and click **Next**.
3. For **Rules**, select **Up To Next Major Version** (With base version set to 0.0.4).
4. Click **Finish**.
5. Check **Mcrich23-Toolkit**
6. Click **Add To Project**

## **Usage**

### **CapsuleMultiFilter**
```
CapsuleMultiFilter(menuContent: .constant(AnyView(VStack { //Passes in the view for the plus button menu. Must use .constant() so that the view updates.
    if horizantalSizeClass == .regular {
        ForEach(filterOpt, id: \.self) { text in
            if !filter.contains(text) {
                Button {
                    filter.append(text)
                } label: {
                    Text(text)
                }
            }
        }
    }else {
        ForEach(filterOpt, id: \.self) { text in
            if !filter.contains(text) {
                Button {
                    filter.append(text)
                } label: {
                    Text(text)
                }
            }
        }
    }
})), opt: filterOpt, //Use an array that are the same options as in the menu
selected: $filter //An array of currently selected filters
)
```
### **OnboardingScreen**
```
OnboardingScreen(titleIcon: .systemImage(named: "plus"), //An icon to go next to the title
                 titleIconColor: .yellow, //Color for the icon next to the title
                    title: "Hello World", //Title
                    subtitle: "Lorem Ipsum", //Subtitle (leave blank for it to dissapear)
                    cells: .constant([FeatureCell(image: .systemImage(named: "hand"), //An icon next to the cell
                                                  imageColor: .red, //Color for the icon next to the cell
                                                title: "Title", //Title
                                                subtitle: "Subtitle")]) //Subtitle/Description (leave blank for it to dissapear)
)
```
### **SwiftUIAlert**
#### **show**
```
SwiftUIAlert.show(title: "Hello Word!", //Alert Title
                    message: "Lorem Ipsum", //Alert Message
                    preferredStyle: .alert, //Style (alert or action sheet)
                    actions: [UIAlertAction(title: "Done", //Action Title
                                            style: .default, //Action Style (default, destructive, dismiss)
                                            handler: {_ in}) //Handler for choosing that action
                    ]
)
```
#### **textfieldShow**
```
SwiftUIAlert.textfieldShow(title: "Test", //Alert Title
                            message: "Hello World!", //Alert Message
                            preferredStyle: .alert, //Style (alert or action sheet)
                            textfield: AlertTextfield(text: $text, //Textfield Text
                                                        placeholder: "", //Textfield Placeholder
                                                        clearButtonMode: .whileEditing, //When to show clear butt(always, whileEditing, unlessEditing, or never)
                                                        enablesReturnKeyAutomatically: true, //Show return key keyboard
                                                        disableAutocorrection: false, //Disable Autocorrection?
                                                        autocapitalization: .sentences, //Autocapitalization (nonsentances, allCharacter, or words)
                                                        keyboardType: .default, //The type of keyboard
                                                        returnKeyType: .default, //Type of return key on keyboard
                                                        isSecureTextEntry: false, //Is Secure Textfield?
                                                        dismissKeyboardOnReturn: true), //Dismiss keyboard on return?
                            actions: [UIAlertAction(title: "Done", style: .default)]
)
```
### **NetworkMonitor**

Start Monitoring: `NetworkMonitor.shared.startMonitoring()`

Stop Monitoring: `NetworkMonitor.shared.stopMonitoring()`

Get Connection Type: `NetworkMonitor.shared.connectionType` (Unknown can mean disconnected)
