//
//  ContentView.swift
//  RegistrationForm
//
//  Created by Mahmoud Fouad on 7/22/21.
//

import SwiftUI

struct RegistrationForm: View {
    
    @ObservedObject private var userRegistrationViewModel
        = UserRegistrationViewModel()
    
    var body: some View {
        VStack {
            
            Text("Create an account")
                .font(.system(.largeTitle, design: .rounded))
                .bold()
                .padding(.bottom, 30)
            
            FormField(fieldName: "Username", fieldValue: $userRegistrationViewModel.username)
                
            RequirementText(iconColor: userRegistrationViewModel.isUsernameLengthValid ? Color.secondary : Color(red: 251/255, green: 128/255, blue: 128/255), text: "A minimum of 4 characters", isStrikeThrough: userRegistrationViewModel.isUsernameLengthValid)
                .padding()
            
            
            
            FormField(fieldName: "Password", fieldValue: $userRegistrationViewModel.password, isSecure: true)
            
            VStack {
                RequirementText(iconName: "lock.open",
                                iconColor: userRegistrationViewModel.isPasswordLengthValid ?
                                    Color.secondary : Color(red: 251/255, green: 128/255, blue: 128/255),
                                text: "Aminimum of 8 characters", isStrikeThrough: userRegistrationViewModel.isPasswordLengthValid)
                
                RequirementText(iconName: "lock.open", iconColor:
                                    userRegistrationViewModel.isPasswordCapitalLetter ?
                                    Color.secondary : Color(red: 251/255, green: 128/255,
                                                            blue: 128/255), text: "One uppercase letter",
                                isStrikeThrough:
                                    userRegistrationViewModel.isPasswordCapitalLetter)
                
            }
            .padding()
            
            FormField(fieldName: "Confirm Password",
                      fieldValue: $userRegistrationViewModel.passwordConfirm, isSecure: true)
                
            
            RequirementText(iconColor:
                                userRegistrationViewModel.isPasswordConfirmValid ?
                                Color.secondary : Color(red: 251/255, green: 128/255,
                                                        blue: 128/255),
                            text: "Your confirm password should be the same as password", isStrikeThrough:
                                userRegistrationViewModel.isPasswordConfirmValid)
                
                .padding()
                .padding(.bottom, 50)
            
            
            Button(action: {
                // Proceed to the next screen
            }) {
                Text("Sign Up")
                    .font(.system(.body, design: .rounded))
                    .foregroundColor(.white)
                    .bold()
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(userRegistrationViewModel.isReadySubmit ?
                                    
                                    LinearGradient(gradient: Gradient(colors:
                                                                        [Color(red: 251/255, green: 128/255, blue: 128/255),
                                                                         Color(red: 253/255, green: 193/255, blue: 104/255)]),
                                                   startPoint: .leading, endPoint: .trailing)
                                    : LinearGradient(gradient: Gradient(colors: [Color.secondary, Color.secondary]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
            }
            .disabled(!userRegistrationViewModel.isReadySubmit)
            
            HStack {
                
                Text("Already have an account?")
                    .font(.system(.body, design: .rounded))
                    .bold()
                
                Button(action: {
                    // Proceed to Sign in screen
                }) {
                    Text("Sign in")
                        .font(.system(.body, design: .rounded))
                        .bold()
                        .foregroundColor(Color(red: 251/255, green: 128/255, blue: 128/255))
                }
                
            }
            .padding(.top, 50)
            Spacer()
        }
        .padding()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationForm()
    }
}
