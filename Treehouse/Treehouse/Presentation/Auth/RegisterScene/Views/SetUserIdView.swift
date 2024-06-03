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
    
    @Environment(ViewRouter.self) var viewRouter: ViewRouter
    @Environment(UserSettingViewModel.self) private var viewModel
    
    @State var userId: String = ""
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
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.trailing, 2)
            .padding(.bottom, SizeLiterals.Screen.screenHeight * 26 / 852)
            
            userNameTextField
            
            Spacer()
            
            Button(action: {
                if viewModel.isButtonEnabled {
                    viewModel.userId = userId
                    Task {
                        await viewModel.checkUserName(userName: userId)
                        
                        if viewModel.isUserNameDuplicated == false {
                            viewRouter.push(RegisterRouter.showUserProfileView)
                        } else {
                            textFieldState = .duplicated
                        }
                    }
                }
            }) {
                Text(StringLiterals.Register.buttonTitle5)
                    .font(.fontGuide(.body2))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .foregroundStyle(viewModel.isButtonEnabled ? .gray1 : .gray6)
                    .background(viewModel.isButtonEnabled ? .treeBlack : .gray2)
                    .cornerRadius(10)
                    .padding(.trailing, 1)
            }
        }
        .padding(EdgeInsets(top: SizeLiterals.Screen.screenHeight * 22 / 852,
                            leading: 24,
                            bottom: SizeLiterals.Screen.screenHeight * 30 / 852,
                            trailing: 24))
        .onTapGesture {
            hideKeyboard()
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    viewRouter.pop()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.treeBlack)
                }
                .padding(.top, 5)
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            UITextField.appearance().clearButtonMode = .whileEditing
        }
        .onChange(of: userId) { _, newValue in
            viewModel.isUserNameDuplicated = false
            
            if self.isValidInputUserId(newValue) {
                viewModel.isButtonEnabled = true
                textFieldState = .enable
            } else {
                viewModel.isButtonEnabled = false
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
    NavigationStack {
        SetUserIdView()
            .environment(ViewRouter())
            .environment(UserSettingViewModel(checkNameUseCase: CheckNameUseCase(repository: RegisterRepositoryImpl()), registerUserUseCase: RegisterUserUseCase(repository: RegisterRepositoryImpl())))
    }
}
