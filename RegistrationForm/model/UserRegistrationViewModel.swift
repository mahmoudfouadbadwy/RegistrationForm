//
//  UserRegistrationViewModel.swift
//  RegistrationForm
//
//  Created by Mahmoud Fouad on 7/22/21.
//
import Foundation
import Combine

class UserRegistrationViewModel: ObservableObject {
    
    // Input
    @Published var username = ""
    @Published var password = ""
    @Published var passwordConfirm = ""
    @Published var isReadySubmit = false
    
    // Output
    @Published var isUsernameLengthValid = false
    @Published var isPasswordLengthValid = false
    @Published var isPasswordCapitalLetter = false
    @Published var isPasswordConfirmValid = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init() {
        
        $username
            .receive(on: DispatchQueue.main)
            .map {
                $0.count >= 4
            }
            .assign(to: \.isUsernameLengthValid, on: self)
            .store(in: &cancellableSet)
        
        $password
            .receive(on: DispatchQueue.main)
            .map {
                $0.count >= 8
            }
            .assign(to: \.isPasswordLengthValid, on: self)
            .store(in: &cancellableSet)
        
        $password
            .receive(on: DispatchQueue.main)
            .map { password in
                let pattern = "[A-Z]"
                if let _ = password.range(of: pattern, options: .regularExpression) {
                    return true
                } else {
                    return false
                }
            }
            .assign(to: \.isPasswordCapitalLetter,
                    on: self)
            .store(in: &cancellableSet)
        
        Publishers.CombineLatest($password, $passwordConfirm)
            .receive(on: DispatchQueue.main)
            .map { (password, passwordConfirm) in
                return !passwordConfirm.isEmpty &&
                    (passwordConfirm == password)
            }
            .assign(to: \.isPasswordConfirmValid, on: self)
            .store(in: &cancellableSet)
        
        
        $isReadySubmit
            .receive(on: DispatchQueue.main)
            .map { [weak self] _ in
                
                self!.isUsernameLengthValid &&
                self!.isPasswordLengthValid &&
                self!.isPasswordCapitalLetter &&
                self!.isPasswordConfirmValid
            }
            .assign(to: \.isReadySubmit, on: self)
            .store(in: &cancellableSet)
    }
}


