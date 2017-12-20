//
//  UIView.swift
//  ExtensionKit
//
//  Copyright © 2017 Muhammad Bassio. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit

/// Interface Builder
public extension UIView {
  @IBInspectable public var borderColor:UIColor {
    get { return UIColor(cgColor: self.layer.borderColor!) }
    set { self.layer.borderColor = newValue.cgColor }
  }
  
  @IBInspectable public var borderWidth:CGFloat {
    get { return self.layer.borderWidth }
    set { self.layer.borderWidth = newValue }
  }
  
  @IBInspectable public var cornerRadius:CGFloat {
    get { return self.layer.cornerRadius }
    set { self.layer.cornerRadius = newValue }
  }
  
  
  @IBInspectable public var shadowColor:UIColor {
    get { return UIColor(cgColor: self.layer.shadowColor!) }
    set { self.layer.shadowColor = newValue.cgColor }
  }
  
  @IBInspectable public var shadowOffset:CGSize {
    get { return self.layer.shadowOffset }
    set { self.layer.shadowOffset = newValue }
  }
  
  @IBInspectable public var shadowOpacity:Float {
    get { return self.layer.shadowOpacity }
    set { self.layer.shadowOpacity = newValue }
  }
  
  @IBInspectable public var shadowRadius:CGFloat {
    get { return self.layer.shadowRadius }
    set { self.layer.shadowRadius = newValue }
  }
}

/// Constraints
public extension UIView {
  /// Removes all constrains for this view
  func removeConstraints() {
    var list = [NSLayoutConstraint]()
    if let constraints = self.superview?.constraints {
      for c in constraints {
        if c.firstItem as? UIView == self || c.secondItem as? UIView == self {
          list.append(c)
        }
      }
    }
    self.superview?.removeConstraints(list)
    self.removeConstraints(self.constraints)
  }
  
  /// Returns constrains with specified identifier
  public func constraint(withIdentifier:String) -> NSLayoutConstraint? {
    return self.constraints.filter{ $0.identifier == withIdentifier }.first
  }
}
