# Mcrich23 Toolkit

This is a package that I made that has a bunch of qualities of life.

## Installation
### **Swift Package Manager**

The Swift Package Manager is a tool for automating the distribution of Swift code and is integrated into the swift compiler. It is in early development, but Mcrich23-Toolkit does support its use on supported platforms.

Once you have your Swift package set up, adding Mcrich23-Toolkit as a dependency is as easy as adding it to the dependencies value of your Package.swift.

```
dependencies: [
    .package(url: "https://github.com/Mcrich23/Mcrich23-Toolkit.git", .upToNextMajor(from: "0.0.2"))
]
```

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
