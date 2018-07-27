//
//  ViewController.swift
//  LoginValidationWithMVVM
//
//  Created by SungYu on 2018. 7. 27..
//  Copyright © 2018년 Sung. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginEnabledLabel: UILabel!
    
    var loginViewModel = LoginViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = emailTextField.rx.text.map { $0 ?? "" }.bind(to: loginViewModel.emailText)
        _ = passwordTextField.rx.text.map { $0 ?? "" }.bind(to: loginViewModel.passwordText)
        
        _ = loginViewModel.isValid.bind(to: loginButton.rx.isEnabled)
        
        loginViewModel.isValid.subscribe(onNext: { [unowned self] in
            self.loginEnabledLabel.text = $0 ? "Enabled" : "Not Enabled"
            self.loginEnabledLabel.textColor = $0 ? .green : .red
            
            print("isValid = \($0)")
        }).disposed(by: disposeBag)
    }

}

