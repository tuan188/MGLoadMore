Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '9.0'
s.name = "MGLoadMore"
s.summary = "LoadMoreTableView, LoadMoreCollectionView"
s.requires_arc = true

# 2
s.version = "0.3.0"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "Tuan Truong" => "tuan188@gmail.com" }

# 5 - Replace this URL with your own GitHub page's URL (from the address bar)
s.homepage = "https://github.com/tuan188/MGLoadMore"

# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/tuan188/MGLoadMore.git",
:tag => "#{s.version}" }

# 7
s.framework = "UIKit"
s.dependency 'RxAtomic', '~> 4.4'
s.dependency 'RxSwift', '~> 4.4'
s.dependency 'RxCocoa', '~> 4.4'
s.dependency 'MJRefresh', '~> 3.1'

# 8
s.source_files = "MGLoadMore/Sources/*.{swift}"

# 9
# s.resources = "MGLoadMore/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"

# 10
s.swift_version = "5.0"

end
