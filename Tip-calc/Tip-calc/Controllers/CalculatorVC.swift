//
//  ViewController.swift
//  Tip-calc
//
//  Created by Arken Sarsenov on 10.05.2024.
//

import UIKit
import SnapKit
import Combine

final class CalculatorVC: UIViewController {
    
    // MARK: - private UI Elements
    private let logoView = LogoView()
    private let resultView = ResultView()
    private let billInputView = BillInputView()
    private let tipInputView = TipInputView()
    private let splitInputView = SplitInputView()
    private lazy var vStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [logoView, resultView, billInputView, tipInputView, splitInputView, UIView()])
        stackView.axis = .vertical
        stackView.spacing = 36
        return stackView
    }()
    
    private let vm = CalculatorViewModel()
    private var cancelabels = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        bind()
    }
    
    private func bind() {
        let input = CalculatorViewModel.Input(
            billPublisher: billInputView.valuePublisher,
            tipPublisher: tipInputView.valuePablisher,
            splitPublisher: splitInputView.valuePablisher)
        
        let output = vm.transform(input: input)
        output.updateViewPublisher.sink { result in
            print("result \(result)")
        }.store(in: &cancelabels)
    }
    
    // MARK: - Layout
    
    private func layout() {
        view.backgroundColor = ThemeColor.bg
        view.addSubview(vStackView)
        vStackView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leadingMargin).offset(16)
            make.trailing.equalTo(view.snp.trailingMargin).offset(-16)
            make.bottom.equalTo(view.snp.bottomMargin).offset(-16)
            make.top.equalTo(view.snp.topMargin).offset(16)
        }
        logoView.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        
        resultView.snp.makeConstraints { make in
            make.height.equalTo(224)
        }
        
        billInputView.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
        
        tipInputView.snp.makeConstraints { make in
            make.height.equalTo(56+56+16)
        }
        
        splitInputView.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
    }
}

