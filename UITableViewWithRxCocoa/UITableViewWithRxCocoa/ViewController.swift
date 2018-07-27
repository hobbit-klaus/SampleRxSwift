//
//  ViewController.swift
//  UITableViewWithRxCocoa
//
//  Created by SungYu on 2018. 7. 27..
//  Copyright © 2018년 Sung. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var tableView: UITableView!
    private let disposeBag = DisposeBag()
    
    var items = [String]()
    var itemsRelay = BehaviorRelay(value: [String]())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnAdd.rx.tap.subscribe(onNext: {
            self.items.append("\(self.items.count + 1)")
            self.itemsRelay.accept(self.items)
        }).disposed(by: disposeBag)
        
        // 각 셀을 구성한다.
        itemsRelay
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = "\(element)"
            }
            .disposed(by: disposeBag)
        
        // 셀을 클릭했을 때 데이터 값을 출력한다.
        tableView.rx
            .modelSelected(String.self)
            .subscribe(onNext:  {
                print("\($0)")
            })
            .disposed(by: disposeBag)
    }
    
}

