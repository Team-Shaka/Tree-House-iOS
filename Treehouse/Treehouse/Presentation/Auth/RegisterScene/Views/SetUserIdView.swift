//
//  SetUserIdView.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 4/10/24.
//

import SwiftUI

enum SetUserIdField {
    case userId
}

struct SetUserIdView: View {
    
    // MARK: - State Property
    
    @State private var viewModel = SetUserIdViewModel()
    @State var userId: String = ""
    @State var isButtonEnabled: Bool = false
    @State var textFieldState: TextFieldStateType = .notFocused
    @FocusState private var focusedField: SetUserIdField?
    
    // MARK: - View
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 24) {
                Text(StringLiterals.Register.registerTitle4)
                    .fontWithLineHeight(fontLevel: .heading1)
                    .foregroundStyle(.black)
                
                Text(StringLiterals.Register.guidanceTitle3)
                    .fontWithLineHeight(fontLevel: .body3)
                    .foregroundStyle(.gray5)
            }
            .padding(.leading, 2)
            .padding(.bottom, 26)
            
            userNameTextField
            
            Spacer()
            
            Button(action: {
                viewModel.checkUserName(userName: userId)
            }) {
                Text(StringLiterals.Register.buttonTitle5)
                    .font(.fontGuide(.body2))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .foregroundStyle(isButtonEnabled ? .gray1 : .gray6)
                    .background(isButtonEnabled ? .treeBlack : .gray2)
                    .cornerRadius(10)
            }
        }
        .padding(EdgeInsets(top: 66, leading: 24, bottom: 23, trailing: 22))
        .onAppear {
            UITextField.appearance().clearButtonMode = .whileEditing
        }
        .onChange(of: userId) { _, newValue in
            if self.isValidInputUserId(newValue) {
                isButtonEnabled = true
                textFieldState = .enable
            } else {
                isButtonEnabled = false
                textFieldState = .unable
            }
        }
        .onChange(of: focusedField) { _, newValue in
            if newValue == .userId {
                textFieldState = .enable
            } else {
                textFieldState = .notFocused
            }
        }
    }
}

// MARK: - ViewBuilder

private extension SetUserIdView {
    @ViewBuilder
    var userNameTextField: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextField(StringLiterals.Register.placeholderTitle2, text: $userId)
                .fontWithLineHeight(fontLevel: .body1)
                .foregroundStyle(textFieldState.fontColor)
                .tint(.treeGreen)
                .focused($focusedField, equals: .userId)
                .padding(EdgeInsets(top: 18, leading: 18, bottom: 18, trailing: 10))
                .frame(height: 62)
                .background(textFieldState.backgroundColor)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(textFieldState.borderColor, lineWidth: 1.5)
                )
                .cornerRadius(12)
                .autocapitalization(.none)
            
            if textFieldState == .unable {
                Text(StringLiterals.Register.indicatorTitle3)
                    .fontWithLineHeight(fontLevel: .caption1)
                    .foregroundStyle(.error)
            }
            
            if viewModel.isUserNameDuplicated {
                Text(StringLiterals.Register.indicatorTitle4)
                    .fontWithLineHeight(fontLevel: .caption1)
                    .foregroundStyle(.error)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    SetUserIdView()
}
