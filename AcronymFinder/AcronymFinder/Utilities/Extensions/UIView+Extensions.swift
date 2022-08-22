//
//  UIView+Extensions.swift
//  AcronymFinder
//
//  Created by Anoop Thomas on 8/21/22.
//

import UIKit

public extension UIView {
    static var defaultNibName: String {
        return String(describing: self)
    }
    
    static func loadFromDefaultNib<T: UIView>() -> T {
        return loadFromNib(defaultNibName)
    }
    
    static func loadFromNib<T: UIView>(_ nibName: String) -> T {
        return loadFromNib(nibName, bundle: Bundle(for: self))
    }
    
    static func loadFromNib<T: UIView>(_ nibName: String, bundle: Bundle) -> T {
        return loadFromNib(nibName, bundle: bundle, owner: nil)
    }
    
    static func loadFromNib<T: UIView>(_ nibName: String, bundle: Bundle, owner: Any?) -> T {
        guard let view = bundle.loadNibNamed(nibName, owner: owner, options: nil)?.first as? T else {
            fatalError("\(self) has not been initialized properly from nib \(nibName)")
        }
        return view
    }
    
    func loadViewFromNib(_ nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}

public extension UIView {
    /// Helper method to init and setup the view from the Nib.
    func xibSetup(nibname: String) {
        guard let view = loadViewFromNib(nibname) else { return }
        addSubview(view)
        view.fillSuperView()
    }
    
    /// Helper method which
    func fillSuperView() {
        guard let superview = superview else {
            assertionFailure("View does not have Super View. Add to a view and try again.")
            return
        }
        translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            topAnchor.constraint(equalTo: superview.topAnchor),
            leftAnchor.constraint(equalTo: superview.leftAnchor),
            rightAnchor.constraint(equalTo: superview.rightAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
