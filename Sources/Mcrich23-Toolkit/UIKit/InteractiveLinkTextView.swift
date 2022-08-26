//
//  InteractiveLinkTextView.swift
//  ClickableLabel
//
//  Created by Steven Curtis on 31/10/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit
import SafariServices

/**
 Easily hyperlink your UITextView with this component of the Mcrich23-Toolkit
 
 - parameter customUrlHandler: Open url in a custom way, Note: you may need to declare in viewDidLoad.
 
 # Example #
 ```
 let textView: InteractiveLinkLabel = {
     let textView = InteractiveLinkLabel()
     
     let firstChunk = NSMutableAttributedString(string: "Hello, my name is Morris, you can check out my website", attributes: nil) // Just text
     let website = NSMutableAttributedString(string: "here", attributes:[NSAttributedString.Key.link: URL(string: "https://mcrich23.com")!]) // Hyperlinked word
     
     //Put it together
     let fullAttributtedText = NSMutableAttributedString()
     fullAttributtedText.append(firstChunk)
     fullAttributtedText.append(tos)
     
     // Modifiers
     textView.attributedText = fullAttributtedText
     textView.numberOfLines = 0
     textView.sizeToFit()
     textView.translatesAutoresizingMaskIntoConstraints = false
     textView.isUserInteractionEnabled = true
     textView.customUrlHandler = { url in // Open url in a custom way, Note: you may need to declare in viewDidLoad
         let safari = SFSafariViewController(url: url)
         self.present(safari, animated: true)
     }
     
     return label
 }()
 ```
 
 */

public class InteractiveLinkTextView: UITextView {
    
    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configure()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    func configure() {
        isScrollEnabled = false
        isEditable = false
        isSelectable = false
        isUserInteractionEnabled = true
    }
    
    public var customUrlHandler: (_ url: URL) -> Void = { url in
        UIApplication.shared.open(url)
    }
    
    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let superBool = super.point(inside: point, with: event)
        
        var location = point
        location.x -= self.textContainerInset.left
        location.y -= self.textContainerInset.top
        
        let characterIndex = layoutManager.characterIndex(for: location, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        guard characterIndex < textStorage.length else {return false}
        let attributes = textStorage.attributes(at: characterIndex, effectiveRange: nil)
        
        let attributeName = NSAttributedString.Key.link
        
        let attributeValue = self.attributedText?.attribute(attributeName, at: characterIndex, effectiveRange: nil)
        
        if let value = attributeValue {
            if let url = value as? URL {
                customUrlHandler(url)
            }
        }
        
        return superBool && attributes[NSAttributedString.Key.underlineStyle ] != nil
    }
    
    
}
