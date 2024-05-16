//
//  TipInputView.swift
//  Tip-calc
//
//  Created by Arken Sarsenov on 10.05.2024.
//

import UIKit
import Combine
import CombineCocoa

final class TipInputView: UIView {
    
    private let headerView: HeaderView = {
       let view = HeaderView()
        view.configure(topText: "Choose", bottomText: "your tip")
        return view
    }()
    
    private lazy var tenPercentButton: UIButton = {
        let button = buildTipButton(tip: .tenPercent)
        button.tapPublisher.flatMap({Just(TipModel.tenPercent)})
            .assign(to: \.value, on: tipSubject)
            .store(in: &cancellables)
        return button
    }()
    
    private lazy var fiftenPercentButton: UIButton = {
        let button = buildTipButton(tip: .fifteenPercent)
        button.tapPublisher.flatMap({Just(TipModel.fifteenPercent)})
            .assign(to: \.value, on: tipSubject)
            .store(in: &cancellables)
        return button
    }()
    
    private lazy var twentyPercentButton: UIButton = {
        let button = buildTipButton(tip: .twentyPercent)
        button.tapPublisher.flatMap({Just(TipModel.twentyPercent)})
            .assign(to: \.value, on: tipSubject)
            .store(in: &cancellables)
        return button
    }()
    
    private lazy var customTipButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = ThemeColor.primary
        button.tintColor = .white
        button.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        button.setTitle("Custom Tip", for: .normal)
        button.addCornerRadius(radius: 8)
        button.tapPublisher.sink { [weak self] _ in
            self?.handleCustomTipButton()
        }.store(in: &cancellables)
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
    
    // Combine
    private var tipSubject = CurrentValueSubject<TipModel, Never>(.none)
    var valuePablisher: AnyPublisher<TipModel, Never> {
        return tipSubject.eraseToAnyPublisher()
    }
    private var cancellables = Set<AnyCancellable>()
    
    
    // MARK: - View lifesycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layout()
        observe()
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
    
    private func handleCustomTipButton() {
        let alertController = UIAlertController(title: "Enter custom tip",
                                                message: nil,
                                                preferredStyle: .alert)
        alertController.addTextField { textFiled in
            textFiled.placeholder = "Make it generous!"
            textFiled.keyboardType = .numberPad
            textFiled.autocorrectionType = .no
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            guard let text = alertController.textFields?.first?.text,
                  let value = Int(text) else { return }
            self?.tipSubject.send(.custom(value: value))
        }
        [cancelAction, okAction].forEach(alertController.addAction(_:))
        
        // Show allert in ViewController
        parentViewController?.present(alertController, animated: true)
    }
    // Update Buttons style
    private func observe() {
        tipSubject.sink { [unowned self] tip in
            resetView()
            switch tip {
            case .none:
                break
            case .tenPercent:
                tenPercentButton.backgroundColor = ThemeColor.secondary
            case .fifteenPercent:
                fiftenPercentButton.backgroundColor = ThemeColor.secondary
            case .twentyPercent:
                twentyPercentButton.backgroundColor = ThemeColor.secondary
            case .custom(value: let value):
                customTipButton.backgroundColor = ThemeColor.secondary
                let text = NSMutableAttributedString(
                    string: "$\(value)", attributes: [.font: ThemeFont.bold(ofSize: 20), .foregroundColor: UIColor.white])
                text.addAttributes(
                    [.font: ThemeFont.bold(ofSize: 14)],
                    range: NSMakeRange(0, 1))
                customTipButton.setAttributedTitle(text, for: .normal)
            }
        }.store(in: &cancellables)
    }
    // reset Buttons settings to default
    private func resetView() {
        [tenPercentButton, fiftenPercentButton,
         twentyPercentButton, customTipButton].forEach {
            $0.backgroundColor = ThemeColor.primary
        }
        let text = NSMutableAttributedString(
            string: "Custom Tip",
            attributes: [.font: ThemeFont.bold(ofSize: 20), .foregroundColor: UIColor.white])
        customTipButton.setAttributedTitle(text, for: .normal)
    }
    
    // MARK: - Button factory method
    private func buildTipButton(tip: TipModel) -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = ThemeColor.primary
        button.addCornerRadius(radius: 8)
        let text = NSMutableAttributedString(string: tip.stringValue, attributes: [.font: ThemeFont.bold(ofSize: 20), .foregroundColor: UIColor.white])
        text.addAttributes([.font: ThemeFont.demiBold(ofSize: 14)], range: NSMakeRange(2, 1))
        button.setAttributedTitle(text, for: .normal)
        return button
    }
}
