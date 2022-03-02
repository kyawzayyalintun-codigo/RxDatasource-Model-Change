//
//  ViewController.swift
//  Datasource
//
//  Created by Kyaw Zay Ya Lin Tun on 28/02/2022.
//

import UIKit
import RxSwift
import RxDataSources

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var vm: ViewModelLogic!
    let bag = DisposeBag()
    
    typealias Datasource = RxTableViewSectionedReloadDataSource<TableSection<Section>>
    
    private lazy var dataSource = Datasource { _, tableView, indexPath, item in
        switch item {
        case is StudentCellVM:
            let cell = tableView.deque(StudentCell.self)
            cell.vm = item.to(StudentCellVM.self)
            return cell
        case is CourseCellVM:
            let cell = tableView.deque(CourseCell.self)
            cell.vm = item.to(CourseCellVM.self)
            
            cell.onChangeTapped
                .debug("Cell")
                .bind(to: self.vm.inputs.courseChange)
                .disposed(by: self.bag)
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    // MARK: - Lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupBinding()
    }
    
    deinit {
        print("deinit ViewController")
    }
    
    // MARK: - Private Helpers
    private func setup() {
        vm = ViewModel()
    }
    
    private func setupView() {
        tableView.register(UINib(nibName: StudentCell.className, bundle: nil), forCellReuseIdentifier: StudentCell.className)
        tableView.register(UINib(nibName: CourseCell.className, bundle: nil), forCellReuseIdentifier: CourseCell.className)
        
        tableView.estimatedRowHeight = 50
        tableView.contentInset.top = 8
        tableView.sectionHeaderHeight = CGFloat.leastNormalMagnitude
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: CGFloat.leastNormalMagnitude))
        tableView.sectionFooterHeight = CGFloat.leastNormalMagnitude
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: CGFloat.leastNormalMagnitude))
    }
    
    private func setupBinding() {
        vm.outputs.models
            .debug("dataSource 💿")
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
        
        rx.viewWillAppear
            .bind(to: vm.inputs.viewWillAppear)
            .disposed(by: bag)
    }
    
}

public extension UITableView {
    
    func deque<cell: UITableViewCell>(_ cell: cell.Type) -> cell {
        return dequeueReusableCell(withIdentifier: cell.className) as! cell
    }
}

public extension NSObject {

    class var className: String {
        return String(describing: self)
    }
}
