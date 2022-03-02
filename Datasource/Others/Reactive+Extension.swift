//
//  Reactive+Extension.swift
//  Datasource
//
//  Created by Kyaw Zay Ya Lin Tun on 28/02/2022.
//

import Foundation
import RxSwift
import RxCocoa

public extension Reactive where Base: UIViewController {
    
    var viewWillAppear: ControlEvent<Void> {
        let source = self.methodInvoked(#selector(Base.viewWillAppear(_:)))
            .map { $0.first as? Bool ?? false }
            .map { _ -> Void in ()}
        return ControlEvent(events: source)
    }
}
