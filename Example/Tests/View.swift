//
//  View.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 19.10.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import UIKit
import TinySwift

final class View: UIView {
    private(set) var view: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    fileprivate func setup() {
        view = viewFromNib
        if let view = view {
            addSubview(view)
        }
    }
}
