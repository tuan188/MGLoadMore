//
//  RefreshTableView.swift
//  MGLoadMore
//
//  Created by Tuan Truong on 4/5/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

import MJRefresh
import UIKit
import RxCocoa
import RxSwift

open class RefreshTableView: UITableView {
    open var loadingMoreTop: Binder<Bool> {
        return Binder(self) { tableView, loading in
            if loading {
                tableView.mj_header?.beginRefreshing()
            } else {
                tableView.mj_header?.endRefreshing()
            }
        }
    }
    
    open var loadingMoreBottom: Binder<Bool> {
        return Binder(self) { tableView, loading in
            if loading {
                tableView.mj_footer?.beginRefreshing()
            } else {
                tableView.mj_footer?.endRefreshing()
            }
        }
    }
    
    private var _loadMoreTopTrigger = PublishSubject<Void>()
    
    open var loadMoreTopTrigger: Driver<Void> {
        return _loadMoreTopTrigger.asDriver(onErrorJustReturn: ())
    }
    
    private var _loadMoreBottomTrigger = PublishSubject<Void>()
    
    open var loadMoreBottomTrigger: Driver<Void> {
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
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.refreshHeader = RefreshAutoHeader(refreshingBlock: nil)
        self.refreshFooter = RefreshAutoFooter(refreshingBlock: nil)
    }
}
