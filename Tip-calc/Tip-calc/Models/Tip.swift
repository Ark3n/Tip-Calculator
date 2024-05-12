//
//  Tip.swift
//  Tip-calc
//
//  Created by Arken Sarsenov on 12.05.2024.
//

import Foundation

enum Tip {
    case none, tenPercent, fiftenPercent, twentyPercent
    case custom(value: Int)
    
    var stringValue: String {
        switch self {
        case .none:
            return ""
        case .tenPercent:
            return "10%"
        case .fiftenPercent:
            return "15%"
        case .twentyPercent:
            return "20%"
        case .custom(let value):
            return "\(value)"
        }
    }
}
