//
//  SetUserIdView.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 4/10/24.
//

import SwiftUI

struct SetUserIdView: View {
    
    // MARK: - State Property
    
    @Environment(ViewRouter.self) var viewRouter: ViewRouter
    @Environment(UserSettingViewModel.self) private var viewModel
    
    @State var userName: String = ""
    @State var textFieldState: TextFieldStateType = .notFocused
    @FocusState private var focusedField: Bool
    
    @State var isLengthValid = false
    @State var isValidInput = false
    
    @State var errorMessage = ""
    
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
                    viewModel.userName = userName
                    Task {
                        await viewModel.checkUserName(userName: userName)
                        
                        if viewModel.isUserNameDuplicated == false {
                            viewRouter.push(RegisterRouter.showUserProfileView)
                        } else {
                            textFieldState = .duplicated
                            errorMessage = StringLiterals.Register.indicatorTitle4
                        }
                    }
                }
            }) {
                Text(StringLiterals.Register.buttonTitle5)
                    .fontWithLineHeight(fontLevel: .body2)
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
            UIApplication.shared.hideKeyboard()
        }
        .onChange(of: userName) { _, newValue in
            viewModel.isUserNameDuplicated = false
            
            if self.isLengthValid(newValue) { // 글자수 체크
                isLengthValid = true
                
                if self.isValidInputUserId(newValue) { // 글자 종류
                    isValidInput = true
                    textFieldState = .enable
                    errorMessage = ""
                    viewModel.isButtonEnabled = true
                } else {
                    isValidInput = false
                    errorMessage = StringLiterals.Register.indicatorTitle3
                    textFieldState = .unable
                    viewModel.isButtonEnabled = false
                }
            } else if newValue.isEmpty { // 글자가 아에 없을 때
                viewModel.isButtonEnabled = false
                textFieldState = .enable
                errorMessage = ""
            } else {
                isLengthValid = false
                errorMessage = StringLiterals.Register.indicatorTitle5
                textFieldState = .unable
                viewModel.isButtonEnabled = false
            }
        }
        .onChange(of: focusedField) { _, newValue in
            if newValue == true {
                textFieldState = .enable
            } else if isLengthValid == false || isValidInput == false {
                textFieldState = .unable
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
            TextField(StringLiterals.Register.placeholderTitle2, text: $userName)
                .fontWithLineHeight(fontLevel: .body1)
                .foregroundStyle(textFieldState.fontColor)
                .tint(.treeGreen)
                .focused($focusedField)
                .padding(EdgeInsets(top: 18, leading: 18, bottom: 18, trailing: 10))
                .frame(height: 62)
                .background(textFieldState.backgroundColor)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(textFieldState.borderColor, lineWidth: 1.5)
                )
                .cornerRadius(12)
                .autocapitalization(.none)
            
            Text(errorMessage)
                .fontWithLineHeight(fontLevel: .caption1)
                .foregroundStyle(.error)
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        SetUserIdView()
            .environment(ViewRouter())
            .environment(UserSettingViewModel(checkNameUseCase: CheckNameUseCase(repository: RegisterRepositoryImpl()),
                                              registerUserUseCase: RegisterUserUseCase(repository: RegisterRepositoryImpl()),
                                              registerTreeMemberUseCase: RegisterTreeMemberUseCase(repository: RegisterRepositoryImpl()),
                                              acceptInvitationTreeMemberUseCase: AcceptInvitationTreeMemberUseCase(repository: InvitationRepositoryImpl()),
                                              checkInvitationsUseCase: CheckInvitationsUseCase(repository: InvitationRepositoryImpl()), presignedURLUseCase: PresignedURLUseCase(repository: FeedRepositoryImpl()), uploadImageToAWSUseCase: UploadImageToAWSUseCase(repository: AWSImageRepositoryImpl()), registerType: .registerUser
                                             ))
    }
}
