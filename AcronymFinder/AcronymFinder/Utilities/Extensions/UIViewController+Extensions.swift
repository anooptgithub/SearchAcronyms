//
//  UIViewController+Extensions.swift
//  AcronymFinder
//
//  Created by Anoop Thomas on 8/21/22.
//

import UIKit

extension UIViewController {
    public class var defaultNibName: String {
        return String(describing: self)
    }
    
    public static func defaultInstance<T: UIViewController>() -> T {
        return T(nibName: T.defaultNibName, bundle: Bundle(for: T.self))
    }
}
