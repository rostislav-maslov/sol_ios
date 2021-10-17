//
//  UINotificationFeedbackGeneratorExtention.swift
//  SOL
//
//  Created by Rostislav Maslov on 17.10.2021.
//

import Foundation
import SwiftUI

public enum GeneratorType{
    case TASK_CREATE
    case TASK_DONE
}

extension UINotificationFeedbackGenerator{
    public static func generate(_ type: GeneratorType){
        switch type {
        case .TASK_DONE:
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        case .TASK_CREATE:
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        }
    }
}
