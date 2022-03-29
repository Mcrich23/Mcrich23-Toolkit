//
//  WelcomeScreen.swift
//  Welcome
//
//  Created by Jordan Singer on 11/25/20.
//

import SwiftUI

public struct OnboardingScreen: View {
    @Environment(\.presentationMode) var presentationMode
    var titleIcon: glyphImage = .defaultIcon
    var titleIconColor: Color = .label
    var title: String = ""
    var subtitle: String = ""
    @Binding var cells: [FeatureCell]
    
    public init(titleIcon: glyphImage, titleIconColor: Color, title: String, subtitle: String, cells: Binding<[FeatureCell]>) {
        self.titleIcon = titleIcon
        self.titleIconColor = titleIconColor
        self.title = title
        self.subtitle = subtitle
        self._cells = cells
    }
    
    public var body: some View {
        VStack {
            Spacer()
            VStack {
                HStack {
                    switch titleIcon {
                    case .systemImage(let string):
                        Image(string)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 34)
                            .foregroundColor(titleIconColor)
                    case .assetImage(let string):
                        Image(string)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 34)
                            .foregroundColor(titleIconColor)
                    case .defaultIcon:
                        EmptyView()
                    }
                    Text(NSLocalizedString(title, comment: ""))
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                Text(NSLocalizedString(subtitle, comment: ""))
                    .font(.title)
                    .fontWeight(.bold)
            }
                .multilineTextAlignment(.center)
                .padding(.horizontal)//, 48)
            Spacer()
            
            VStack(spacing: 24) {
                ForEach(cells, id: \.self) { cell in
                    FeatureCell(image: cell.image, imageColor: cell.imageColor, title: NSLocalizedString(cell.title, comment: ""), subtitle: NSLocalizedString(cell.subtitle, comment: ""))
                }
            }
            .padding(.leading)
            
            Spacer()
            Spacer()
            
            Button(action: { presentationMode.wrappedValue.dismiss() }) {
                HStack {
                    Spacer()
                    Text("Continue")
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
