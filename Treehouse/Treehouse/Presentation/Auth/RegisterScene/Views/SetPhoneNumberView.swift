//
//  PhoneNumberInsertView.swift
//  Treehouse
//
//  Created by 윤영서 on 4/11/24.
//

import SwiftUI

enum SetPhoneNumberViewField {
    case phoneNumber
}

struct SetPhoneNumberView: View {
    
    // MARK: - State Property
    
    @Environment(ViewRouter.self) var viewRouter: ViewRouter
    @State var viewModel = UserSettingViewModel(checkNameUseCase: CheckNameUseCase(repository: RegisterRepositoryImpl()),
                                                registerUserUseCase: RegisterUserUseCase(repository: RegisterRepositoryImpl()),
                                                registerTreeMemberUseCase: RegisterTreeMemberUseCase(repository: RegisterRepositoryImpl()),
                                                acceptInvitationTreeMemberUseCase: AcceptInvitationTreeMemberUseCase(repository: InvitationRepositoryImpl()),
                                                checkInvitationsUseCase: CheckInvitationsUseCase(repository: InvitationRepositoryImpl()),
                                                presignedURLUseCase: PresignedURLUseCase(repository: FeedRepositoryImpl()), uploadImageToAWSUseCase: UploadImageToAWSUseCase(repository: AWSImageRepositoryImpl()), registerType: .registerUser)
    @State private var phoneNumber: String = ""
    @State private var errorMessage: String? = nil
    @State private var textFieldState: TextFieldStateType = .notFocused
    @State private var isButtonEnabled: Bool = false
    
    @FocusState private var focusedField: SetPhoneNumberViewField?
    
    // MARK: - View
    
    var body: some View {
        @Bindable var viewRouter = viewRouter
        
        NavigationStack(path: $viewRouter.path) {
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(StringLiterals.Register.registerTitle1)
                        .fontWithLineHeight(fontLevel: .heading1)
                        .foregroundColor(.treeBlack)
                        .padding(.bottom, SizeLiterals.Screen.screenHeight * 36 / 852)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        phoneNumberTextField
                        
                        if errorMessage == errorMessage {
                            Text(errorMessage ?? "")
                                .fontWithLineHeight(fontLevel: .caption1)
                                .foregroundColor(.error)
                        }
                    }
                    
                    Text(StringLiterals.Register.guidanceTitle1)
                        .fontWithLineHeight(fontLevel: .body5)
                        .foregroundColor(.gray5)
                        .padding(.top, errorMessage == nil ? 0 : 24)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                Button(action: {
                    if isButtonEnabled {
                        viewRouter.push(RegisterRouter.verificationView)
                        viewModel.phoneNumber = phoneNumber
                    }
                }) {
                    Text(StringLiterals.Register.buttonTitle1)
                        .fontWithLineHeight(fontLevel: .body2)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .foregroundColor(isButtonEnabled ? .gray1 : .gray6)
                        .background(isButtonEnabled ? .treeBlack : .gray2)
                        .cornerRadius(12)
                }
            }
            .padding(EdgeInsets(top: 22+44, leading: 24, bottom: 30, trailing: 24))
            .navigationDestination(for: RegisterRouter.self) { router in
                viewRouter.buildScene(inputRouter: router, viewModel: viewModel)
            }
        }
        .onAppear {
            UITextField.appearance().clearButtonMode = .whileEditing
            UIApplication.shared.hideKeyboard()
        }
        .onChange(of: focusedField) { _, newValue in
            if newValue == .phoneNumber {
                textFieldState = .enable
            } else {
                textFieldState = .notFocused
            }
        }
        .onChange(of: phoneNumber) { _, newValue in
            if newValue.validatePhoneNumber() {
                errorMessage = nil
                isButtonEnabled = true
                textFieldState = .enable
            } else if newValue.isEmpty {
                errorMessage = nil
                isButtonEnabled = false
                textFieldState = .enable
            } else {
                errorMessage = StringLiterals.Register.indicatorTitle1
                isButtonEnabled = false
                textFieldState = .unable
            }
        }
    }
}

// MARK: - View Builder

extension SetPhoneNumberView {
    @ViewBuilder
    private var phoneNumberTextField: some View {
        HStack {
            Text("+82")
                .font(.fontGuide(.body3))
                .foregroundColor(.gray7)
                .padding(.leading)
            
            TextField("전화번호 입력", text: $phoneNumber)
                .font(.fontGuide(.body1))
                .keyboardType(.numberPad)
                .padding()
                .tint(.treeGreen)
                .focused($focusedField, equals: .phoneNumber)
        }
        .frame(height: 62)
        .background(textFieldState.backgroundColor)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(textFieldState.borderColor, lineWidth: 1)
        )
        .clipped()
        .cornerRadius(12)
    }
}

// MARK: - Preview

#Preview {
    SetPhoneNumberView()
        .environment(ViewRouter())
        .environment(UserSettingViewModel(checkNameUseCase: CheckNameUseCase(repository: RegisterRepositoryImpl()),
                                          registerUserUseCase: RegisterUserUseCase(repository: RegisterRepositoryImpl()),
                                          registerTreeMemberUseCase: RegisterTreeMemberUseCase(repository: RegisterRepositoryImpl()),
                                          acceptInvitationTreeMemberUseCase: AcceptInvitationTreeMemberUseCase(repository: InvitationRepositoryImpl()),
                                          checkInvitationsUseCase: CheckInvitationsUseCase(repository: InvitationRepositoryImpl()), presignedURLUseCase: PresignedURLUseCase(repository: FeedRepositoryImpl()), uploadImageToAWSUseCase: UploadImageToAWSUseCase(repository: AWSImageRepositoryImpl()), registerType: .registerUser
                                         ))
}
