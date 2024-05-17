//
//  ResultView.swift
//  Tip-calc
//
//  Created by Arken Sarsenov on 10.05.2024.
//

import UIKit

final class ResultView: UIView {
    // MARK: - private UI Elements
    private let headerLabel: UILabel = {
        LabelFactory.build(text: "Total p/Person", font: ThemeFont.demiBold(ofSize: 18))
    }()
    private let amountPerPersonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        let text = NSMutableAttributedString(string: "$0", attributes: [.font: ThemeFont.bold(ofSize: 48)])
        text.addAttributes([.font: ThemeFont.bold(ofSize: 24)], range: NSMakeRange(0, 1))
        label.attributedText = text
        return label
    }()
    
    private let horizontalLineView: UIView = {
       let view = UIView()
        view.backgroundColor = ThemeColor.separator
        return view
    }()
    
    private lazy var vStackView: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [headerLabel, amountPerPersonLabel, horizontalLineView, buildSpacerView(height: 0), hStackView])
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private let totalBillView: AmountView = {
       let view = AmountView(title: "Total bill", textAligment: .left)
        return view
    }()
    
    private let totalTipView: AmountView = {
       let view = AmountView(title: "Total tip", textAligment: .right)
        return view
    }()
    
    private lazy var hStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            totalBillView,
            UIView(),
            totalTipView ])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    
    // MARK: - View Lifecycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(result: ResultModel) {
        let text  = NSMutableAttributedString(
            string: result.amountPerPerson.currencyFormatted,
            attributes: [.font: ThemeFont.bold(ofSize: 48)])
        text.addAttributes(
            [.font: ThemeFont.bold(ofSize: 24)],
            range: NSMakeRange(0, 1))
        amountPerPersonLabel.attributedText = text
        
        totalBillView.configure(amount: result.totalBill)
        totalTipView.configure(amount: result.totalTip)
    }
    
    // MARK: - Layout Views
    private func layout() {
        backgroundColor = .white
        addSubview(vStackView)
        vStackView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(24)
            make.bottom.equalTo(snp.bottom).offset(-24)
            make.leading.equalTo(snp.leading).offset(24)
            make.trailing.equalTo(snp.trailing).offset(-24)
        }
        horizontalLineView.snp.makeConstraints { make in
            make.height.equalTo(2)
        }
        addShadow(offSet: CGSize(width: 0, height: 3), color: .black, radius: 12, opacity: 0.1)
    }
    
    private func buildSpacerView(height: CGFloat) -> UIView {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
        return view
    }
}
