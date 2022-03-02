//
//  ViewModel.swift
//  Datasource
//
//  Created by Kyaw Zay Ya Lin Tun on 28/02/2022.
//

import Foundation
import RxSwift
import RxRelay

enum Section: CaseIterable {
    case student
    case course
}

protocol ViewModelInput {
    
    var viewWillAppear: PublishSubject<Void> { get }
    var courseChange: PublishSubject<CourseCellVM> { get }
}

protocol ViewModelOutput {
    var models: BehaviorRelay<[TableSection<Section>]> { get }
}

protocol ViewModelLogic {
    var inputs: ViewModelInput { get }
    var outputs: ViewModelOutput { get }
}

class ViewModel: ViewModelInput, ViewModelOutput, ViewModelLogic {
    
    // Inputs
    let viewWillAppear: PublishSubject<Void> = .init()
    let courseChange: PublishSubject<CourseCellVM> = .init()
    
    // Outputs
    let models: BehaviorRelay<[TableSection<Section>]> = .init(value: [])
    
    var inputs: ViewModelInput {
        return self
    }
    
    var outputs: ViewModelOutput {
        return self
    }
    
    private let bag = DisposeBag()
    
    init() {
        let startEvent = viewWillAppear.share()
        
        startEvent
            .map { self.loadDummies() }
            .asDriver(onErrorDriveWith: .never())
            .drive(outputs.models)
            .disposed(by: bag)
            
        courseChange
            .map { self.convert(vm: $0) }
            .debug("VM")
            .asDriver(onErrorDriveWith: .never())
            .drive(outputs.models)
            .disposed(by: bag)
    }
    
    private func convert(vm: CourseCellVM?) -> [TableSection<Section>] {
        guard let vm = vm else { return [] }

        var models = outputs.models.value
        
        
        if models.count >= 2 {
            var items = models[1].items as? [CourseCellVM] ?? []
            items.mutateEach { item in
                if item.id == vm.id {
                    item.name = "Changed Course"
                }
            }
            models[1].items = items
        }
        
        return models
    }
    
    private func loadDummies() -> [TableSection<Section>] {
        var sections = [TableSection<Section>]()
        
        Section.allCases.forEach { sect in
            var model = TableSection<Section>(header: sect, items: [])
            
            switch sect {
            case .student:
                model.items = StudentCellVM.mocks
            case .course:
                model.items = CourseCellVM.mocks
            }
            
            sections.append(model)
        }
        
        return sections
    }
    
}

extension Array {
    mutating func mutateEach(by transform: (inout Element) throws -> Void) rethrows {
        self = try map { el in
            var el = el
            try transform(&el)
            return el
        }
     }
}
