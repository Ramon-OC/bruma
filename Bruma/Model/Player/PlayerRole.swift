//
//  playerRole.swift
//  Bruma
//
//  Created by José Ramón Ortiz Castañeda on 18/09/25.
//

import SwiftUI

enum PlayerRole {
    case fish
    case hook
    case fisherman
}

extension PlayerRole {
    var roleName: String {
        switch self {
        case .fish:
            return "fish".translated()
        case .hook:
            return "hook".translated()
        case .fisherman:
            return "fisherman".translated()
        }
    }
    
    var phonetic: String {
        switch self {
        case .fish:
            return "afi_fish".translated()
        case .hook:
            return "afi_hook".translated()
        case .fisherman:
            return "[peskaˈðoɾ]".translated()
        }
    }
    
    var imageName: String {
        switch self {
        case .fish:
            return "fish.fill"
        case .hook:
            return "hook"
        case .fisherman:
            return "figure.fishing"
        }
    }
    
    // Si necesitas la imagen directamente (iOS)
    var image: UIImage? {
        return UIImage(named: self.imageName)
    }
}
