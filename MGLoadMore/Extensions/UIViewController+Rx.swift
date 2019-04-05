//
//  UIViewController+Rx.swift
//  MGLoadMore
//
//  Created by Tuan Truong on 4/5/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

extension Reactive where Base: UIViewController {
    var error: Binder<Error> {
        return Binder(base) { viewController, error in
            print(error.localizedDescription)
        }
    }
    
    var isLoading: Binder<Bool> {
        return Binder(base) { _, isLoading in
            print(isLoading)
        }
    }
}
