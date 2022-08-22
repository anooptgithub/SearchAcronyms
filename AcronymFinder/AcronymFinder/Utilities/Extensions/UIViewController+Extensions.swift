//
//  UIViewController+Extensions.swift
//  AcronymFinder
//
//  Created by Anoop Thomas on 8/21/22.
//

import UIKit

extension UIViewController {
    /// Provides default nib name for the UIViewController
    public class var defaultNibName: String {
        return String(describing: self)
    }
    
    /// Creates an instance of the UIViewController of type T from its nib file.
    public static func defaultInstance<T: UIViewController>() -> T {
        return T(nibName: T.defaultNibName, bundle: Bundle(for: T.self))
    }
}
