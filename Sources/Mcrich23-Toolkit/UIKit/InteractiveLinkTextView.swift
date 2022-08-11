//
//  InteractiveLinkTextView.swift
//  ClickableLabel
//
//  Created by Steven Curtis on 31/10/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit
import SafariServices

class InteractiveLinkTextView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    func configure() {
        isScrollEnabled = false
        isEditable = false
        isSelectable = false
        isUserInteractionEnabled = true
    }
    
    var customUrlHandler: (_ url: URL) -> Void = { url in
        UIApplication.shared.open(url)
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
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
