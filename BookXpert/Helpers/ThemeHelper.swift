//
//  ThemeHelper.swift
//  BookXpert
//
//  Created by Sree Lakshman on 17/04/25.
//

import UIKit

enum Theme: Int {
  case system = 0, light, dark

  var style: UIUserInterfaceStyle {
    switch self {
    case .system: return .unspecified
    case .light:  return .light
    case .dark:   return .dark
    }
  }

  static var current: Theme {
    get {
      let raw = UserDefaults.standard.integer(forKey: "selectedTheme")
      return Theme(rawValue: raw) ?? .system
    }
    set {
      UserDefaults.standard.set(newValue.rawValue, forKey: "selectedTheme")
      apply(newValue)
    }
  }

  /// Immediately apply to all windows
  static func apply(_ theme: Theme) {
    UIApplication.shared.windows.forEach { window in
      window.overrideUserInterfaceStyle = theme.style
    }
  }
}
