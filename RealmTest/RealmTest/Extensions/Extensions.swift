//
//  Extensions.swift
//  RealmTest
//
//  Created by Deepak Kumar on 31/08/18.
//  Copyright © 2018 Deepak Kumar. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func dropShadow(shadowColor: CGColor = UIColor.gray.cgColor, shadowOffset: CGSize = .zero, shadowRadius: CGFloat = 10.0, shadowOpacity: Float = 0.7 ) {
        self.layer.shadowColor = shadowColor
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shouldRasterize = true
    }
}

