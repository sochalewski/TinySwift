//
//  UIView.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 19.10.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import UIKit

#if !os(watchOS)

public extension UIView {
    /**
     Returns a view instantiated from the nib/xib corresponding to the view.
     
     For example a snippet for `MyView.xib`:
     
         class MyView: UIView {
             private(set) view: UIView?
     
             override init(frame: CGRect) {
                 super.init(frame: frame)
                 setup()
             }
     
             fileprivate func setup() {
                 view = viewFromNib
                 guard let view = view else { return }
                 addSubiew(view)
             }
         }
    */
    public var viewFromNib: UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        view?.frame = bounds
        view?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return view
    }
}

#endif
