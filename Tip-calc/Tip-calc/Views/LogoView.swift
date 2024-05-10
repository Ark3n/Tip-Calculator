//
//  LogoView.swift
//  Tip-calc
//
//  Created by Arken Sarsenov on 10.05.2024.
//

import UIKit

final class LogoView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        backgroundColor = .systemRed
    }
}
