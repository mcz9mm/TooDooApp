//
//  UserUxManager.swift
//  TooDoo
//
//  Created by kaoru matarai on 2024/05/16.
//

import Foundation
import UIKit

class UserUxManager {
  static func tapHF() {
    let generator = UIImpactFeedbackGenerator(style: .medium)
    generator.impactOccurred()
  }
  
  static func addHF() {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.success)
  }

  static func removeHF() {
    let generator = UIImpactFeedbackGenerator(style: .heavy)
    generator.impactOccurred()
  }
}
