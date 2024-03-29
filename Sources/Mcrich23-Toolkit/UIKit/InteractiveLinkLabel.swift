//
//  InteractiveLinkLabel.swift
//  ClickableLabel
//
//  Created by Steven Curtis on 31/10/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit
import SafariServices

/**
 Easily hyperlink your UILabel with this component of the Mcrich23-Toolkit
 
 - parameter customUrlHandler: Open url in a custom way, Note: you may need to declare in viewDidLoad.
 
 # Example #
 ```
 let label: InteractiveLinkLabel = {
     let label = InteractiveLinkLabel()
     
     let firstChunk = NSMutableAttributedString(string: "Hello, my name is Morris, you can check out my website", attributes: nil) // Just text
     let website = NSMutableAttributedString(string: "here", attributes:[NSAttributedString.Key.link: URL(string: "https://mcrich23.com")!]) // Hyperlinked word
     
     //Put it together
     let fullAttributtedText = NSMutableAttributedString()
     fullAttributtedText.append(firstChunk)
     fullAttributtedText.append(tos)
     
     label.attributedText = fullAttributtedText
     label.numberOfLines = 0
     label.sizeToFit()
     label.translatesAutoresizingMaskIntoConstraints = false
     label.isUserInteractionEnabled = true
     label.customUrlHandler = { url in // Open url in a custom way, Note: you may need to declare in viewDidLoad
         let safari = SFSafariViewController(url: url)
         self.present(safari, animated: true)
     }
     
     return label
 }()
 ```
 
 */

public class InteractiveLinkLabel: UILabel {
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.configure()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    func configure() {
        isUserInteractionEnabled = true
    }
    
    public var customUrlHandler: (_ url: URL) -> Void = { url in
        UIApplication.shared.open(url)
    }
    
    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        
        let superBool = super.point(inside: point, with: event)
        
        // Configure NSTextContainer
        let textContainer = NSTextContainer(size: bounds.size)
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = lineBreakMode
        textContainer.maximumNumberOfLines = numberOfLines
        
        // Configure NSLayoutManager and add the text container
        let layoutManager = NSLayoutManager()
        layoutManager.addTextContainer(textContainer)
        
        guard let attributedText = attributedText else {return false}
        
        // Configure NSTextStorage and apply the layout manager
        let textStorage = NSTextStorage(attributedString: attributedText)
        textStorage.addAttribute(NSAttributedString.Key.font, value: font!, range: NSMakeRange(0, attributedText.length))
        textStorage.addLayoutManager(layoutManager)
        
        // get the tapped character location
        let locationOfTouchInLabel = point
        
        // account for text alignment and insets
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        var alignmentOffset: CGFloat!
        switch textAlignment {
        case .left, .natural, .justified:
            alignmentOffset = 0.0
        case .center:
            alignmentOffset = 0.5
        case .right:
            alignmentOffset = 1.0
        @unknown default:
            fatalError()
        }
        
        let xOffset = ((bounds.size.width - textBoundingBox.size.width) * alignmentOffset) - textBoundingBox.origin.x
        let yOffset = ((bounds.size.height - textBoundingBox.size.height) * alignmentOffset) - textBoundingBox.origin.y
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - xOffset, y: locationOfTouchInLabel.y - yOffset)
        
        // work out which character was tapped
        let characterIndex = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        // work out how many characters are in the string up to and including the line tapped, to ensure we are not off the end of the character string
        let lineTapped = Int(ceil(locationOfTouchInLabel.y / font.lineHeight)) - 1
        let rightMostPointInLineTapped = CGPoint(x: bounds.size.width, y: font.lineHeight * CGFloat(lineTapped))
        let charsInLineTapped = layoutManager.characterIndex(for: rightMostPointInLineTapped, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        guard characterIndex < charsInLineTapped else {return false}
        
        let attributeName = NSAttributedString.Key.link
        
        let attributeValue = self.attributedText?.attribute(attributeName, at: characterIndex, effectiveRange: nil)
        
        if let value = attributeValue {
            if let url = value as? URL {
                customUrlHandler(url)
            }
        }
        
        return superBool
        
    }
}
