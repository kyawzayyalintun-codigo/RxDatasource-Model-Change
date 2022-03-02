//
//  StudentCell.swift
//  Datasource
//
//  Created by Kyaw Zay Ya Lin Tun on 28/02/2022.
//

import UIKit

class StudentCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    
    var vm: StudentCellVM? {
        didSet {
            guard let vm = vm else {
                return
            }
            
            lblName.text = vm.name
            lblGender.text = vm.gender
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }

    private func setupView() {
        self.selectionStyle = .none
    }
    
}
