//
//  UIColor.swift
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

/// Adds initializing UIColor from HEX values
public extension UIColor {
  fileprivate convenience init(hex3: Int, alpha: Float) {
    self.init(red:   CGFloat( ((hex3 & 0xF00) >> 8).duplicate4bits() ) / 255.0,
              green: CGFloat( ((hex3 & 0x0F0) >> 4).duplicate4bits() ) / 255.0,
              blue:  CGFloat( ((hex3 & 0x00F) >> 0).duplicate4bits() ) / 255.0,
              alpha: CGFloat(alpha))
  }
  
  fileprivate convenience init(hex6: Int, alpha: Float) {
    self.init(red:   CGFloat( (hex6 & 0xFF0000) >> 16 ) / 255.0,
              green: CGFloat( (hex6 & 0x00FF00) >> 8 ) / 255.0,
              blue:  CGFloat( (hex6 & 0x0000FF) >> 0 ) / 255.0,
              alpha: CGFloat(alpha))
  }
  
  /// Creates a `UIColor` using integer `hex` and `alpha`.
  /// In case of invalid Hex value, UIColor.clear is returned.
  ///
  /// - parameter hexString:  String HEX value.
  /// - parameter alpha:      Float alpha.
  ///
  /// - returns: The created `UIColor`.
  public convenience init(hexString: String, alpha: Float = 1) {
    var hex = hexString
    // Check for hash and remove it
    if hex.hasPrefix("#") {
      hex = String(hex[hex.index(hex.startIndex, offsetBy: 1)...])
    }
    // Check if can get HEX integer
    guard let hexVal = Int(hex, radix: 16) else {
      self.init(hex3: 0, alpha: 0)
      return
    }
    switch hex.count {
    case 3:
      self.init(hex3: hexVal, alpha: alpha)
    case 6:
      self.init(hex6: hexVal, alpha: alpha)
    default:
      self.init(hex3: 0, alpha: 0)
    }
  }
  
  /// Creates a `UIColor` using integer `hex` and `alpha` = 1.
  ///
  /// - parameter hex:        Integer HEX value.
  ///
  /// - returns: The created `UIColor`.
  public convenience init(hex: Int) {
    self.init(hex: hex, alpha: 1.0)
  }
  
  /// Creates a `UIColor` using integer `hex` and `alpha`.
  ///
  /// - parameter hex:        Integer HEX value.
  /// - parameter alpha:      Float alpha.
  ///
  /// - returns: The created `UIColor`.
  public convenience init(hex: Int, alpha: Float) {
    if (0x000000 ... 0xFFFFFF) ~= hex {
      self.init(hex6: hex, alpha: alpha)
    }
    else {
      self.init(hex3: 0, alpha: 0)
    }
  }
  
  /// - returns: The `Hex` string of the current `UIColor`.
  func hexString() -> String {
    var r:CGFloat = 0
    var g:CGFloat = 0
    var b:CGFloat = 0
    var a:CGFloat = 0
    getRed(&r, green: &g, blue: &b, alpha: &a)
    let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
    return String(format:"%06x", rgb)
  }
}
