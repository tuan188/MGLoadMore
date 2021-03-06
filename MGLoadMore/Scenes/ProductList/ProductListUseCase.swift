//
//  ProductListUseCase.swift
//  MGLoadMore
//
//  Created by Tuan Truong on 4/5/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

import RxSwift
import MGArchitecture

protocol ProductListUseCaseType {
    func getProductList(page: Int) -> Observable<PagingInfo<Product>>
}

struct ProductListUseCase: ProductListUseCaseType {
    func getProductList(page: Int) -> Observable<PagingInfo<Product>> {
        return Observable.create { observer in
            let products = [
                Product(id: 1, name: "iPhone", price: 1_000),
                Product(id: 2, name: "Apple Watch", price: 400)
            ]
            let page = PagingInfo(page: page, items: products)
            after(interval: 0.5) {
                observer.onNext(page)
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
}
