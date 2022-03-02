//
//  CourseCell.swift
//  Datasource
//
//  Created by Kyaw Zay Ya Lin Tun on 28/02/2022.
//

import UIKit
import RxSwift
import RxCocoa

class CourseCell: UITableViewCell {
    
    @IBOutlet weak var lblCourseName: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var btnChangw: UIButton!
    
    var onChangeTapped: PublishSubject<CourseCellVM> = .init()
    
    var vm: CourseCellVM? {
        didSet {
            guard let vm = vm else {
                return
            }
            
            self.lblCourseName.text = vm.name
            self.lblDuration.text = vm.duration
        }
    }
    
    var bag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
        setupInteraction()
    }
    
    override func prepareForReuse() {
        bag = DisposeBag()
    }
    
    private func setupView() {
        self.selectionStyle = .none
    }
    
    private func setupInteraction() {
        btnChangw.rx.tap
            .compactMap { self.vm }
            .bind(to: onChangeTapped)
            .disposed(by: bag)
    }
    
}
