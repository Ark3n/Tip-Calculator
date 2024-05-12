//
//  AmountView.swift
//  Tip-calc
//
//  Created by Arken Sarsenov on 12.05.2024.
//

import UIKit

class AmountView: UIView {
    
    // MARK: - UIElements
    private let title: String
    private let textAligment: NSTextAlignment
    
    private lazy var titleLabel: UILabel = {
        LabelFactory.build(text: title, font: ThemeFont.regular(ofSize: 18),
                           textColor: ThemeColor.textColor, textAlignment: textAligment)
    }()
    
    private lazy var amountLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = textAligment
        label.textColor = ThemeColor.primary
        let text = NSMutableAttributedString(string: "$0", attributes: [.font: ThemeFont.bold(ofSize: 24)])
        text.addAttributes([.font: ThemeFont.bold(ofSize: 16)], range: NSMakeRange(0, 1))
        label.attributedText = text
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, amountLabel])
        stack.axis = .vertical
        return stack
    }()
    
    // MARK: - Amount View lifecycle
    init(title: String, textAligment: NSTextAlignment) {
        self.title = title
        self.textAligment = textAligment
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout views in AmountView
    private func layout() {
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

