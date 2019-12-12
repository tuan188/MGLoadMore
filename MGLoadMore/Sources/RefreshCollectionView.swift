//
//  RefreshCollectionView.swift
//  MGLoadMore
//
//  Created by Tuan Truong on 8/19/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

import UIKit
import MJRefresh
import RxCocoa
import RxSwift

open class RefreshCollectionView: UICollectionView {
    open var isRefreshing: Binder<Bool> {
        return Binder(self) { tableView, loading in
            if loading {
                tableView.mj_header?.beginRefreshing()
            } else {
                tableView.mj_header?.endRefreshing()
            }
        }
    }
    
    open var isLoadingMore: Binder<Bool> {
        return Binder(self) { tableView, loading in
            if loading {
                tableView.mj_footer?.beginRefreshing()
            } else {
                tableView.mj_footer?.endRefreshing()
            }
        }
    }
    
    private var _loadMoreTopTrigger = PublishSubject<Void>()
    
    open var refreshTrigger: Driver<Void> {
        return _loadMoreTopTrigger.asDriver(onErrorJustReturn: ())
    }
    
    private var _loadMoreBottomTrigger = PublishSubject<Void>()
    
    open var loadMoreTrigger: Driver<Void> {
        return _loadMoreBottomTrigger.asDriver(onErrorJustReturn: ())
    }
    
    open var refreshHeader: MJRefreshHeader? {
        didSet {
            mj_header = refreshHeader
            mj_header?.refreshingBlock = { [weak self] in
                self?._loadMoreTopTrigger.onNext(())
            }
        }
    }
    
    open var refreshFooter: MJRefreshFooter? {
        didSet {
            mj_footer = refreshFooter
            mj_footer?.refreshingBlock = { [weak self] in
                self?._loadMoreBottomTrigger.onNext(())
            }
        }
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        self.refreshHeader = RefreshAutoHeader()
        self.refreshFooter = RefreshAutoFooter()
    }
}
