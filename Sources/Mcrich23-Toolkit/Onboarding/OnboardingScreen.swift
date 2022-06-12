//
//  WelcomeScreen.swift
//  Welcome
//
//  Created by Jordan Singer on 11/25/20.
//

import SwiftUI
import URLImage
import StepperView


/**
 An onboarding screen similar to apple's onboarding screens.
 
 - parameter titleIcon: An icon to go next to the title.
 - parameter titleIconColor: Color for the icon next to the title.
 - parameter title: The title.
 - parameter subtitle: The subtitle (leave blank for it to dissapear.
 - parameter cells: An array of FeatureCells.
 # Example #
 ```
 OnboardingScreen(
     titleIcon: .systemImage(named: "plus"),
     titleIconColor: .yellow,
     title: "Hello World",
     subtitle: "Lorem Ipsum",
     cells: .constant([
         FeatureCell(
             image: .systemImage(named: "hand"),
             imageColor: .red,
             title: "Title",
             subtitle: "Subtitle"
        )
     ])
 )
 ```
 */
public struct OnboardingScreen<Content: View>: View {
    @Environment(\.presentationMode) var presentationMode
    var titleIcon: glyphImage = .defaultIcon
    var titleIconColor: Color = .gray
    var title: String = ""
    var subtitle: String = ""
    var cells: cellType
    
    public init(titleIcon: glyphImage, titleIconColor: Color, title: String, subtitle: String, cells: cellType) {
        self.titleIcon = titleIcon
        self.titleIconColor = titleIconColor
        self.title = title
        self.subtitle = subtitle
        self.cells = cells
    }
    
    public enum cellType {
        case individual([FeatureCell])
        case steps(StepperViewOnboarding<Content>)
    }
    
    public var body: some View {
        VStack {
            Spacer()
            VStack {
                HStack {
                    switch titleIcon {
                    case .systemImage(let string):
                        Image(systemName: string)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 54)
                            .foregroundColor(titleIconColor)
                    case .assetImage(let string):
                        Image(string)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 54)
                            .foregroundColor(titleIconColor)
                    case .remoteImage(let url):
                        if #available(iOS 15, *) {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 54)
                                    .foregroundColor(titleIconColor)
                            } placeholder: {
                                Image(systemName: "photo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 54)
                                    .foregroundColor(titleIconColor)
                            }
                        } else {
                            URLImage(url) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 54)
                                    .foregroundColor(titleIconColor)
                            }
                        }
                    case .defaultIcon:
                        EmptyView()
                    }
                }
                Text(NSLocalizedString(title, comment: ""))
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text(NSLocalizedString(subtitle, comment: ""))
                    .font(.title)
                    .fontWeight(.bold)
            }
                .multilineTextAlignment(.center)
                .padding(.horizontal)//, 48)
            Spacer()
            
            VStack {
                switch cells {
                case .individual(let inputedCells):
                    VStack(spacing: 24) {
                        ForEach(inputedCells, id: \.self) { cell in
                            FeatureCell(image: cell.image.wrappedValue, imageColor: cell.imageColor.wrappedValue, title: NSLocalizedString(cell.title.wrappedValue, comment: ""), subtitle: NSLocalizedString(cell.subtitle.wrappedValue, comment: ""))
                        }
                    }
                case .steps(let steps):
                    steps
                }
            }
            .padding(.leading)
            
            Spacer()
            Spacer()
            
            Button(action: { presentationMode.wrappedValue.dismiss() }) {
                HStack {
                    Spacer()
                    Text(NSLocalizedString("Continue", comment: ""))
                        .font(.headline)
                        .foregroundColor(.white)
                    Spacer()
                }
            }
            .frame(height: 50)
            .background(Color.blue)
            .cornerRadius(15)
        }
        .padding()
    }
}
