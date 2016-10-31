//
//  UIViewController.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 24.09.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

#if !os(watchOS)
    
    import UIKit

    public extension UIViewController {
        /**
         Presents an alert controller with "OK" button modally.
         
         - parameter title: The title of the alert. Use this string to get the user’s attention and communicate the reason for the alert.
         - parameter message: Descriptive text that provides additional details about the reason for the alert.
         - parameter completion: The block to execute after the presentation finishes. This block has no return value and takes no parameters. You may specify nil for this parameter.
         - parameter handler: The block to execute when the user selects the action. This block has no return value and takes the selected action object as its only parameter.
         */
        public func presentAlertController(withTitle title: String?, message: String?, completion: (() -> Void)?, handler: ((UIAlertAction) -> Void)? = nil) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: handler))
            present(alertController, animated: true, completion: completion)
        }
    }

#endif
