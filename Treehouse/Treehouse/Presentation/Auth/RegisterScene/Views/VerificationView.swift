//
//  VerificationView.swift
//  Treehouse
//
//  Created by 티모시 킴 on 4/9/24.
//

import SwiftUI

struct VerificationView: View {
    
    // MARK: - Property
    
    var phoneNumber: String?
    
    // MARK: - State Property
    
    @Environment(UserSettingViewModel.self) private var viewModel
    @Environment(ViewRouter.self) private var viewRouter
    
    @State private var checkUserPhoneViewModel = CheckUserPhoneViewModel(checkUserPhoneUseCase: CheckUserPhoneUseCase(repository: RegisterRepositoryImpl()))
    @State private var verificationCode: String = ""
    @State private var isValid = false
    @FocusState private var isKeyboardShowing: Bool
    
    // MARK: - View
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 0) {
                    Text("+82\(viewModel.phoneNumber ?? "nil")")
                        .foregroundStyle(.treeGreen)
                    +
                    Text("로 전송된\n6자리 인증 번호를 입력해주세요.")
                        .foregroundStyle(.treeBlack)
                }
                .fontWithLineHeight(fontLevel: .heading1)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 72)
                .padding(.bottom, SizeLiterals.Screen.screenHeight * 50 / 852)
                
                HStack(spacing: 0) {
                    ForEach(0 ..< 6, id: \.self) {index in
                        verificationCodeBox(index)
                    }
                }
                .background(content: {
                    TextField("", text: $verificationCode.limit(6))
                        .keyboardType(.numberPad)
                        .textContentType(.oneTimeCode)
                        .frame(width: 1, height: 1)
                        .opacity(0.001)
                        .blendMode(.screen)
                        .focused($isKeyboardShowing)
                })
                .contentShape(Rectangle())
                .onTapGesture {
                    isKeyboardShowing.toggle()
                }
                .padding(.bottom, 8)
                
                Text(isValid == false ? "" : StringLiterals.Register.indicatorTitle2)
                    .fontWithLineHeight(fontLevel: .caption1)
                    .foregroundStyle(.error)
                
                Text(StringLiterals.Register.guidanceTitle1)
                    .fontWithLineHeight(fontLevel: .body5)
                    .foregroundStyle(.gray5)
                    .padding(.top, SizeLiterals.Screen.screenHeight * 24 / 852)
            }
            .padding(.top, SizeLiterals.Screen.screenHeight * 22 / 852)
            
            Spacer()
            
            Button {
                Task {
                    // TODO: 전화번호 인증 API 인증
                    await checkUserPhoneViewModel.checkUserPhone(phoneNumber: viewModel.phoneNumber?.formatPhoneNumber ?? "")
                    
                    switch checkUserPhoneViewModel.isAuthentication {
                    case .notInvitation:
                        viewRouter.push(RegisterRouter.unableRegisterView)
                    case .notSignUp:
                        viewRouter.push(RegisterRouter.setUserIdView)
                    case .comebackUser:
                        viewRouter.push(RegisterRouter.loginView)
                    case .error:
                        print("네트워크 및 어떠한 오류로 인해 인증 받지 못하였음")
                    }
                }
            } label: {
                Text(StringLiterals.Register.buttonTitle2)
                    .font(.fontGuide(.body2))
                    .frame(width: SizeLiterals.Screen.screenWidth * 344 / 393, height: 56)
                    .disableWithOpacity(verificationCode.count < 6)
                    .cornerRadius(12)
            }
        }
        .padding(.horizontal, SizeLiterals.Screen.screenWidth * 24 / 393)
        .padding(.bottom, SizeLiterals.Screen.screenHeight * 30 / 852)
        .onTapGesture {
            hideKeyboard()
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            isKeyboardShowing = true
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
            
            ToolbarItem(placement: .keyboard) {
                Button("완료"){
                    isKeyboardShowing.toggle()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }
    
    // MARK: - Verification Code Box
    
    @ViewBuilder
    func verificationCodeBox(_ index: Int)->some View{
        ZStack{
            if verificationCode.count > index {
                let startIndex = verificationCode.startIndex
                let charIndex = verificationCode.index(startIndex, offsetBy: index)
                let charToString = String(verificationCode[charIndex])
                Text(charToString)
            } else {
                Text(" ")
            }
        }
        .frame(width: 51, height: 51)
        .background {
            RoundedRectangle(cornerRadius: 6, style: .continuous)
                .fill(.gray1)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        VerificationView(phoneNumber: "+82010XXXXXXXX")
            .environment(ViewRouter())
            .environment(UserSettingViewModel(checkNameUseCase: CheckNameUseCase(repository: RegisterRepositoryImpl()),
                                              registerUserUseCase: RegisterUserUseCase(repository: RegisterRepositoryImpl()),
                                              registerTreeMemberUseCase: RegisterTreeMemberUseCase(repository: RegisterRepositoryImpl()),
                                              acceptInvitationTreeMemberUseCase: AcceptInvitationTreeMemberUseCase(repository: InvitationRepositoryImpl()),
                                              checkInvitationsUseCase: CheckInvitationsUseCase(repository: InvitationRepositoryImpl()), presignedURLUseCase: PresignedURLUseCase(repository: FeedRepositoryImpl()), uploadImageToAWSUseCase: UploadImageToAWSUseCase(repository: AWSImageRepositoryImpl()), registerType: .registerUser
                                             ))
    }
}

// MARK: - Binding <String> Extension

extension Binding where Value == String {
    func limit(_ length: Int) -> Self {
        if self.wrappedValue.count > length {
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.prefix(length))
            }
        }
        return self
    }
}
