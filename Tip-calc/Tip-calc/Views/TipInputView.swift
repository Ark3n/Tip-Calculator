//
//  TipInputView.swift
//  Tip-calc
//
//  Created by Arken Sarsenov on 10.05.2024.
//

import UIKit

final class TipInputView: UIView {
    
    private let headerView: HeaderView = {
       let view = HeaderView()
        view.configure(topText: "Choose", bottomText: "your tip")
        return view
    }()
    
    private lazy var tenPercentButton: UIButton = {
        let button = buildTipButton(tip: .tenPercent)
        return button
    }()
    
    private lazy var fiftenPercentButton: UIButton = {
        let button = buildTipButton(tip: .fiftenPercent)
        return button
    }()
    
    private lazy var twentyPercentButton: UIButton = {
        let button = buildTipButton(tip: .twentyPercent)
        return button
    }()
    
    private lazy var customTipButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = ThemeColor.primary
        button.tintColor = .white
        button.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        button.setTitle("Custom Tip", for: .normal)
        button.addCornerRadius(radius: 8)
        return button
    }()
    
    private lazy var buttonHStackView: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [tenPercentButton, fiftenPercentButton, twentyPercentButton])
        stack.distribution = .fillEqually
        stack.spacing = 16
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var buttonVStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [buttonHStackView, customTipButton])
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fillEqually
        return stack
    }()
    
    // MARK: - View lifesycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout Views
    private func layout() {
        [headerView, buttonVStackView].forEach(addSubview(_:))
        
        buttonVStackView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
        }
        headerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalTo(buttonVStackView.snp.leading).offset(-24)
            make.width.equalTo(68)
            make.centerY.equalTo(buttonHStackView.snp.centerY)
        }
    }
    
    // MARK: - Button factory method
    private func buildTipButton(tip: Tip) -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = ThemeColor.primary
        button.addCornerRadius(radius: 8)
        let text = NSMutableAttributedString(string: tip.stringValue, attributes: [.font: ThemeFont.bold(ofSize: 20), .foregroundColor: UIColor.white])
        text.addAttributes([.font: ThemeFont.demiBold(ofSize: 14)], range: NSMakeRange(2, 1))
        button.setAttributedTitle(text, for: .normal)
        return button
    }
}
