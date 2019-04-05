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
    func getProductList() -> Observable<PagingInfo<Product>>
    func loadMoreProductList(page: Int) -> Observable<PagingInfo<Product>>
}

struct ProductListUseCase: ProductListUseCaseType {
    func getProductList() -> Observable<PagingInfo<Product>> {
        return loadMoreProductList(page: 1)
    }
    
    func loadMoreProductList(page: Int) -> Observable<PagingInfo<Product>> {
        let products = [
            Product(id: 1, name: "iPhone", price: 1000),
            Product(id: 2, name: "Apple Watch", price: 400)
        ]
        let page = PagingInfo(page: 1, items: products)
        return Observable.just(page)
    }
}
