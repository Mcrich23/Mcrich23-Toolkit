//
//  FeatureCell.swift
//  Welcome
//
//  Created by Jordan Singer on 11/25/20.
//

import SwiftUI

public struct FeatureCell: View, Hashable {
    
    var image: glyphImage
    var title: String
    var subtitle: String
    var imageColor: Color
    
    public init(image: glyphImage, imageColor: Color, title: String, subtitle: String) {
        self.image = image
        self.title = title
        self.subtitle = subtitle
        self.imageColor = imageColor
    }
    
    public var body: some View {
        HStack(spacing: 24) {
            switch image {
            case .systemImage(let string):
                Image(systemName: string)
    //                .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32)
                    .foregroundColor(imageColor)
            case .assetImage(let string):
                Image(systemName: string)
    //                .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32)
                    .foregroundColor(imageColor)
            case .defaultIcon:
                EmptyView()
            }
                    
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                if subtitle != "" {
                    Text(subtitle)
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                }
            }
            
            Spacer()
        }
    }
}

struct FeatureCell_Previews: PreviewProvider {
    static var previews: some View {
        FeatureCell(image: .systemImage(named: "text.badge.checkmark"), imageColor: .yellow, title: "Title", subtitle: "Subtitle")
    }
}
