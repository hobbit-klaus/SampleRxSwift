//
//  LoginViewModel.swift
//  LoginValidationWithMVVM
//
//  Created by SungYu on 2018. 7. 27..
//  Copyright © 2018년 Sung. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct LoginViewModel {
    var emailText = BehaviorRelay<String>(value: "")
    var passwordText = BehaviorRelay<String>(value: "")
    
    var isValid: Observable<Bool> {
        return Observable.combineLatest(emailText.asObservable(), passwordText.asObservable()) { email, password in
            email.count >= 3 && password.count >= 3
        }
    }
}
