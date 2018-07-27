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
    
    @IBOutlet weak var tableView: UITableView!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let items = Observable.just(
            (1...5).map { "\($0)" }
        )
        
        // 각 셀을 구성한다.
        items
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

