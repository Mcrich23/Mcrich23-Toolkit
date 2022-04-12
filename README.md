# Mcrich23 Toolkit

This is a package that I made that has a bunch of qualities of life.

# Requirements 

- iOS 14, macOS 10.16, tvOS 14, or watchOS 6.7
- Swift 5.5+
- Xcode 12.5+

# Installation

The preferred way of installing SwiftUIX is via the [Swift Package Manager](https://swift.org/package-manager/).


1. In Xcode, open your project and navigate to **File** → **Add Packages...**
2. Paste the repository URL (`https://github.com/Mcrich23/Mcrich23-Toolkit`) and click **Next**.
3. For **Rules**, select **Up To Next Minor Version** (With base version set to 0.6.1).
4. Click **Finish**.
5. Check **Mcrich23-Toolkit**
6. Click **Add To Project**

## **Functions**

### **CapsuleMultiFilter**

#### **Image:**

<img width="277" alt="CapsuleMultiFilter Image" src="https://user-images.githubusercontent.com/81453549/160721810-0c5ca120-6440-443f-ad10-5e125b21c082.png">

#### **Example:**
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
    } else {
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

#### **Description:**

A screen for welcoming the user or presenting a What's New screen.

#### **Image:**

<img width="541" alt="OnboardingScreen Image" src="https://user-images.githubusercontent.com/81453549/160722025-afd6d319-39ad-4e21-9789-f701d08c7512.png">

#### **Example:**
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

#### **Description:**

Default alerts for SwiftUI

#### **Examples:**

##### **show**
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
##### **textfieldShow**
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

#### **Description:**

Watch connection to the internet and use information to modify app behavior.

#### **Usage:**

Start Monitoring: `NetworkMonitor.shared.startMonitoring()` (Call in AppDelagate)

Stop Monitoring: `NetworkMonitor.shared.stopMonitoring()`

Get Connection Type: `NetworkMonitor.shared.connectionType` (Unknown can mean disconnected)

### **CardView**

#### **Description:**

Similar to the cards in the App Store.

#### **Image:**

<img height="277" alt="CardView" src="https://user-images.githubusercontent.com/81453549/160887712-a05ae6b2-4915-448f-bca8-a6aba111a2fe.png"><img height="277" alt="OpenCard" src="https://user-images.githubusercontent.com/81453549/160888175-f886d89a-cd37-4b79-8c06-30c4b273a8d3.png">


#### **Example:**
```
ZStack {
    NavigationView {
        CardView(showHeader: true,  //Show the title, subtitle and create button
        headerTitle: "Home", //Title on the header
        headerSubtitle: "Subtitle", //Subtitle on the header
        headerSubtitleLocation: .below, //If Subtitle is above or below the Title
        cards: .constant(cardData), //All the cards in the view
        create: { //Action when create (Plus Button) is tapped
            showCreateTicket.toggle()
        })
            .navigationBarHidden(true) //Removes Navigation Bar
            .navigationBarTitle("Tickets") //Sets view title for back buttons
    }
}
```
### **ShareSheet**

#### **Description:**

System ShareSheet for SwiftUI.

#### **Image:**

<img height="277" alt="ShareSheet" src="https://user-images.githubusercontent.com/81453549/160920026-0230cadb-9a1f-4d44-8567-ba70454320c7.png">

#### **Example:**
```
Mcrich23_Toolkit.presentShareSheet(activityItems: [
    "Lorem Ipsum",
    "Please Share This"
])
```
### **.onRotate**

#### **Description:**

Update a variable and your view on rotate.

#### **Example:**

```
@State var orientation = UIDevice.current.orientation
...
var body: some view {
    VStack {
        if orientation == .portrait {
            Text("Hello World")
        }
    }
    .onRotate { newOrientation in
        orientation = newOrientation
    }
}
```
