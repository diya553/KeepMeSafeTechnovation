//
//  NSAttributedStringExtension.swift
//  KeepMeSafe
//
//  Created by Diya Hituvalli on 5/28/21.
//  Copyright © 2021 Diya Hituvalli. All rights reserved.
//

import Foundation

extension NSAttributedString {
    static func makeHyperlink (for path: String, in string: String, as substring: String) -> NSAttributedString {
        let nsString = NSString(string: string)
        let substringRange = nsString.range(of: substring)
        let attributedString = NSMutableAttributedString(string: string)
        attributedString.addAttribute(.link, value: path, range: substringRange)
        return attributedString
    }
}
