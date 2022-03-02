//
//  StudentCellVM.swift
//  Datasource
//
//  Created by Kyaw Zay Ya Lin Tun on 01/03/2022.
//

import Foundation

enum Gender {
    case male
    case female
    case other
    
    var text: String {
        switch self {
        case .male:
            return "Male"
        case .female:
            return "Female"
        case .other:
            return "Others"
        }
    }
}

struct StudentCellVM: TableItem {
    let id: String = UUID().uuidString
    var name: String?
    var gender: String?
    
    static let mocks: [StudentCellVM] = [.init(name: "Albert Kohn", gender: Gender.male.text), .init(name: "Olivia Tann", gender: Gender.female.text), .init(name: "Daniel Wick", gender: Gender.male.text)]
}
