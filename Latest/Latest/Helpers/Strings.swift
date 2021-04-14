//
//  Strings.swift
//  Latest
//
//  Created by Cédric Bahirwe on 14/04/2021.
//

import Foundation
import UIKit

extension String {
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
}
