//
//  CourseCellVM.swift
//  Datasource
//
//  Created by Kyaw Zay Ya Lin Tun on 01/03/2022.
//

import Foundation

struct CourseCellVM: TableItem {
    let id: String = UUID().uuidString
    var name: String?
    var duration: String?
    
    static let mocks: [CourseCellVM] = [.init(name: "Apply Sicence and Technology", duration: "3 years"), .init(name: "Human Resource Management", duration: "1.5 years"), .init(name: "Aerospace Engineering", duration: "4 years")]
}

