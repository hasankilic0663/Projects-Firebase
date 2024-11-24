//
//  UIViewExtension.swift
//  XiBLearning-UIKit
//
//  Created by Hasan Hüseyin Kılıç on 8.11.2024.
//

import UIKit.UIView
@IBDesignable 
extension UIView {
    func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
