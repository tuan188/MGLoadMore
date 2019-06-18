//
//  AppDelegate.swift
//  MGLoadMore
//
//  Created by Tuan Truong on 4/5/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var assembler: Assembler = DefaultAssembler()
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        if NSClassFromString("XCTest") != nil { // test
            window?.rootViewController = UnitTestViewController()
        } else {
            bindViewModel()
        }
    }

    private func bindViewModel() {
        guard let window = window else { return }
        
        let vm: AppViewModel = assembler.resolve(window: window)
        let input = AppViewModel.Input(loadTrigger: Driver.just(()))
        let output = vm.transform(input)
        
        output.toProductList
            .drive()
            .disposed(by: rx.disposeBag)
    }
}
