//
//  AppViewModel.swift
//  MGLoadMore
//
//  Created by Tuan Truong on 4/5/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

import MGArchitecture
import RxSwift
import RxCocoa

struct AppViewModel {
    let navigator: AppNavigatorType
    let useCase: AppUseCaseType
}

// MARK: - ViewModelType
extension AppViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
    }
    
    struct Output {
        let toProductList: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        let toProductList = input.loadTrigger
            .do(onNext: navigator.toProductList)
        
        return Output(toProductList: toProductList)
    }
}
