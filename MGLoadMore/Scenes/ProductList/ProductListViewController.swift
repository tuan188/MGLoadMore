//
//  ProductListViewController.swift
//  MGLoadMore
//
//  Created by Tuan Truong on 4/5/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

import UIKit
import Reusable
import MGArchitecture
import RxSwift
import RxCocoa
import Then
import NSObject_Rx

final class ProductListViewController: UIViewController, BindableType {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: PagingTableView!

    // MARK: - Properties
    
    var viewModel: ProductListViewModel!

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
    }
    
    deinit {
        logDeinit()
    }

    // MARK: - Methods
    
    private func configView() {
        tableView.do {
            $0.estimatedRowHeight = 550
            $0.rowHeight = UITableView.automaticDimension
            $0.register(cellType: ProductCell.self)
        }
        
        tableView.rx
            .setDelegate(self)
            .disposed(by: rx.disposeBag)
    }

    func bindViewModel() {
        let input = ProductListViewModel.Input(
            loadTrigger: Driver.just(()),
            reloadTrigger: tableView.refreshTrigger,
            loadMoreTrigger: tableView.loadMoreTrigger,
            selectProductTrigger: tableView.rx.itemSelected.asDriver()
        )

        let output = viewModel.transform(input)
        
        output.productList
            .drive(tableView.rx.items) { tableView, index, product in
                return tableView.dequeueReusableCell(
                    for: IndexPath(row: index, section: 0),
                    cellType: ProductCell.self)
                    .then {
                        $0.bindViewModel(ProductViewModel(product: product))
                    }
            }
            .disposed(by: rx.disposeBag)
        
        output.error
            .drive(rx.error)
            .disposed(by: rx.disposeBag)
        
        output.isLoading
            .drive(rx.isLoading)
            .disposed(by: rx.disposeBag)
        
        output.isReloading
            .drive(tableView.isRefreshing)
            .disposed(by: rx.disposeBag)
        
        output.isLoadingMore
            .drive(tableView.isLoadingMore)
            .disposed(by: rx.disposeBag)

        output.selectedProduct
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.isEmpty
            .drive()
            .disposed(by: rx.disposeBag)
    }
}

// MARK: - Binders
extension ProductListViewController {

}

// MARK: - UITableViewDelegate
extension ProductListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - StoryboardSceneBased
extension ProductListViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}
