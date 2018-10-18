import UIKit
import MJRefresh
import RxCocoa
import RxSwift

open class LoadMoreTableView: UITableView {
    private let _refreshControl = UIRefreshControl()
    
    open var refreshing: Binder<Bool> {
        return Binder(self) { collectionView, loading in
            if loading {
                collectionView._refreshControl.beginRefreshing()
            } else {
                if collectionView._refreshControl.isRefreshing {
                    collectionView._refreshControl.endRefreshing()
                }
            }
        }
    }
    
    open var loadingMore: Binder<Bool> {
        return Binder(self) { collectionView, loading in
            if loading {
                collectionView.mj_footer?.beginRefreshing()
            } else {
                collectionView.mj_footer?.endRefreshing()
            }
        }
    }
    
    open var refreshTrigger: Driver<Void> {
        return _refreshControl.rx.controlEvent(.valueChanged).asDriver()
    }
    
    private var _loadMoreTrigger = PublishSubject<Void>()
    
    open var loadMoreTrigger: Driver<Void> {
        return _loadMoreTrigger.asDriver(onErrorJustReturn: ())
    }
    
    open var refreshFooter: MJRefreshFooter? {
        didSet {
            mj_footer = refreshFooter
            mj_footer?.refreshingBlock = { [weak self] in
                self?._loadMoreTrigger.onNext(())
            }
        }
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.addSubview(_refreshControl)
        self.refreshFooter = RefreshAutoFooter(refreshingBlock: nil)
    }
}
