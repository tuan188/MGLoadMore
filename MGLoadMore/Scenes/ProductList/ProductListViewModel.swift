//
//  ProductListViewModel.swift
//  MGLoadMore
//
//  Created by Tuan Truong on 4/5/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

import MGArchitecture
import RxSwift
import RxCocoa

struct ProductListViewModel {
    let navigator: ProductListNavigatorType
    let useCase: ProductListUseCaseType
}

// MARK: - ViewModelType
extension ProductListViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let reloadTrigger: Driver<Void>
        let loadMoreTrigger: Driver<Void>
        let selectProductTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let error: Driver<Error>
        let loading: Driver<Bool>
        let refreshing: Driver<Bool>
        let loadingMore: Driver<Bool>
        let fetchItems: Driver<Void>
        let productList: Driver<[Product]>
        let selectedProduct: Driver<Void>
        let isEmptyData: Driver<Bool>
    }
    
    func transform(_ input: Input) -> Output {
        let loadMoreOutput = setupLoadMorePaging(
            loadTrigger: input.loadTrigger,
            getItems: useCase.getProductList,
            refreshTrigger: input.reloadTrigger,
            refreshItems: useCase.getProductList,
            loadMoreTrigger: input.loadMoreTrigger,
            loadMoreItems: useCase.loadMoreProductList)
        
        let (page, fetchItems, loadError, loading, refreshing, loadingMore) = loadMoreOutput
        
        let productList = page
            .map { $0.items.map { $0 } }
            .asDriverOnErrorJustComplete()
        
        let selectedProduct = input.selectProductTrigger
            .withLatestFrom(productList) {
                return ($0, $1)
            }
            .map { indexPath, productList in
                return productList[indexPath.row]
            }
            .do(onNext: { product in
                self.navigator.toProductDetail(product: product)
            })
            .mapToVoid()
        
        let isEmptyData = Driver.combineLatest(fetchItems, Driver.merge(loading, refreshing))
            .withLatestFrom(productList) { ($0.1, $1.isEmpty) }
            .map { args -> Bool in
                let (loading, isEmpty) = args
                if loading { return false }
                return isEmpty
            }
        
        return Output(
            error: loadError,
            loading: loading,
            refreshing: refreshing,
            loadingMore: loadingMore,
            fetchItems: fetchItems,
            productList: productList,
            selectedProduct: selectedProduct,
            isEmptyData: isEmptyData
        )
    }
}
