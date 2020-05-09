//
//  String+Format.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 09/05/2020.
//

import UIKit

public extension String {
    /**
     Returns an attributed string with the characters of a string and added the given `font` attribute to the given `substring`'s range.
     
     Sample usage:
     
     ~~~
     "Lorem ipsum dolor".formatted(
        substring: "ipsum",
        font: italicSystemFont(ofSize: UIFont.systemFontSize)
     )
     ~~~
     Returns "Lorem _ipsum_ dolor".
     
     - parameter substring: A substring of the string that is going to be formatted with the given `font`.
     - parameter font: A font to be added as an attribute to a range of the given `substring`
     - returns: A string that has associated font attribute for substring's range of its text.
     */
    func formatted(substring: String, font: UIFont) -> NSAttributedString {
        return NSAttributedString(string: self)
            .formatted(substring: substring, font: font)
    }
}

public extension NSAttributedString {
    /**
     Returns an attributed string with the characters of a string and added the given `font` attribute to the given `substring`'s range.
     
     Sample usage:
     
     ~~~
     let attributedString = "Lorem ipsum dolor".formatted(
        substring: "ipsum",
        font: italicSystemFont(ofSize: UIFont.systemFontSize)
     )
    
     attributedString.formatted(
        substring: "dolor",
        font: boldSystemFont(ofSize: UIFont.systemFontSize)
     )
     ~~~
     Returns "Lorem _ipsum_ **dolor**".
     
     - parameter substring: A substring of the string that is going to be formatted with the given `font`.
     - parameter font: A font to be added as an attribute to a range of the given `substring`
     - returns: A string that has associated font attribute for substring's range of its text.
     */
    func formatted(substring: String, font: UIFont) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(attributedString: self)
        
        guard let region = string.range(of: substring) else { return self }
        let substringRange = NSRange(region, in: string)
        
        attributedString.addAttributes(
            [.font: font],
            range: substringRange
        )
        
        return attributedString
    }
}
