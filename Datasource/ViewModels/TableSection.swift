//
//  TableSection.swift
//  Datasource
//
//  Created by Kyaw Zay Ya Lin Tun on 01/03/2022.
//

import Foundation
import Differentiator

protocol TableItem {}

extension TableItem {
    func to<T: TableItem>(_ type: T.Type) -> T? {
        return self as? T
    }
}

struct TableSection<Header> {
    
    var header: Header
    var items: [TableItem]
}

extension TableSection: SectionModelType {
    
    typealias Item = TableItem
    
    init(original: TableSection<Header>, items: [TableItem]) {
        self = original
        self.items = items
    }
}
