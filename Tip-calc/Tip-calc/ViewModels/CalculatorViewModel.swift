//
//  CalculatorViewModel.swift
//  Tip-calc
//
//  Created by Arken Sarsenov on 13.05.2024.
//

import Foundation
import Combine
import CombineCocoa

final class CalculatorViewModel {
    
    private var cancellables = Set<AnyCancellable>()
    
    private let audioPlayerService: AudioPlayerService
    
    init(audioPlayerService: AudioPlayerService = DefaultAudioPlayer()) {
        self.audioPlayerService = audioPlayerService
    }
    
    
    struct Input {
        let billPublisher: AnyPublisher<Double, Never>
        let tipPublisher: AnyPublisher<TipModel, Never>
        let splitPublisher: AnyPublisher<Int, Never>
        let logoViewTapPublisher: AnyPublisher<Void, Never>
        
    }
    
    struct Output {
        let updateViewPublisher: AnyPublisher<ResultModel, Never>
        let resetCalculatorPublisher: AnyPublisher<Void, Never>
    }
    
    func transform(input: Input) -> Output {
        let updateViewPublisher = Publishers.CombineLatest3(
            input.billPublisher,
            input.tipPublisher,
            input.splitPublisher).flatMap {[unowned self] (bill, tip, split) in
                let totalTip = getTipAmount(bill: bill, tip: tip)
                let totalBill = bill + totalTip
                let amountPerPerson = totalBill / Double(split)
                let result = ResultModel(
                    amountPerPerson: amountPerPerson,
                    totalBill: totalBill,
                    totalTip: totalTip)
                return Just(result)
            }.eraseToAnyPublisher()
        let resultCalculatorPublisher = input.logoViewTapPublisher.handleEvents(receiveOutput: { [unowned self] _ in
            audioPlayerService.playSound()
        }).flatMap { _ in
            return Just(())
        }.eraseToAnyPublisher()
        
        return Output(updateViewPublisher: updateViewPublisher,
                      resetCalculatorPublisher: resultCalculatorPublisher)
    }
    
    private func getTipAmount(bill: Double, tip: TipModel) -> Double {
        switch tip {
        case .none:
            return 0
        case .tenPercent:
            return bill * 0.1
        case .fifteenPercent:
            return bill * 0.15
        case .twentyPercent:
            return bill * 0.2
        case .custom(value: let value):
            return bill * (Double(value) / 100)
        }
    }
}
