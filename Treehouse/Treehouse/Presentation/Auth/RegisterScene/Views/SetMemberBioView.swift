//
//  SetMemberBioView.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 4/14/24.
//

import SwiftUI

struct SetMemberBioView: View {
    
    // MARK: - State Property
    
    @Environment(UserSettingViewModel.self) private var viewModel
    @Environment(ViewRouter.self) private var viewRouter
    
    @State var memberBio: String = ""
    @State var isButtonEnabled: Bool = false
    @State var textFieldState: TextFieldStateType = .notFocused
    @FocusState private var focusedField: Bool
    
    // MARK: - View
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text(StringLiterals.Register.registerTitle8)
                    .fontWithLineHeight(fontLevel: .heading1)
                    .padding(.bottom, SizeLiterals.Screen.screenHeight * 18 / 852)
                
                Text(StringLiterals.Register.guidanceTitle8)
                    .fontWithLineHeight(fontLevel: .body3)
                    .foregroundStyle(.gray5)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, SizeLiterals.Screen.screenHeight * 39/852)
            .fixedSize(horizontal: false, vertical: true)
            
            Image(uiImage: viewModel.profileImage?[0] ?? .imgUser1)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
                .frame(width: 42, height: 42)
                .padding(.bottom, SizeLiterals.Screen.screenHeight * 19/852)
            
            memberBioTextField
            
            Spacer()
            
            Button(action: {
                if isButtonEnabled {
                    viewModel.bio = memberBio
                    viewRouter.push(RegisterRouter.showMemberProfileView)
                }
            }) {
                Text(StringLiterals.Register.buttonTitle11)
                    .fontWithLineHeight(fontLevel: .body2)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .foregroundStyle(isButtonEnabled == false ? .gray6 : .gray1)
                    .background(isButtonEnabled == false ? .gray2 : .treeBlack)
                    .cornerRadius(12)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(EdgeInsets(top: 30, leading: 24, bottom: 30, trailing: 24))
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(StringLiterals.Register.navigationTitle1)
                    .fontWithLineHeight(fontLevel: .body2)
            }
            
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
        .onAppear {
            UITextField.appearance().clearButtonMode = .whileEditing
            UIApplication.shared.hideKeyboard()
        }
        .onChange(of: memberBio) { _, newValue in
            if memberBio.count >= 4 && memberBio.count <= 20  {
                textFieldState = .enable
                isButtonEnabled = true
            } else if newValue.isEmpty {
                isButtonEnabled = false
                textFieldState = .enable
            } else {
                textFieldState = .unable
                isButtonEnabled = false
            }
        }
        .onChange(of: focusedField) { _, newValue in
            if newValue == true {
                textFieldState = .enable
            } else {
                textFieldState = .notFocused
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}

// MARK: - ViewBuilder

private extension SetMemberBioView {
    @ViewBuilder
    var memberBioTextField: some View {
        VStack(alignment: .trailing, spacing: 8) {
            TextField(StringLiterals.Register.placeholderTitle4, text: $memberBio)
                .fontWithLineHeight(fontLevel: .body1)
                .foregroundStyle(textFieldState.fontColor)
                .tint(.treeGreen)
                .focused($focusedField)
                .padding(EdgeInsets(top: 18, leading: 22, bottom: 18, trailing: 10))
                .frame(height: 62)
                .background(textFieldState.backgroundColor)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(textFieldState.borderColor, lineWidth: 1.5)
                )
                .cornerRadius(12)
            
            HStack(spacing: 0) {
                if textFieldState == .unable {
                    Text(StringLiterals.Register.indicatorTitle5)
                        .fontWithLineHeight(fontLevel: .caption1)
                        .foregroundStyle(.error)
                }
                
                Spacer()
                
                Text("( \(memberBio.count) / 20 )")
                    .fontWithLineHeight(fontLevel: .caption1)
                    .foregroundStyle(.gray6)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        SetMemberBioView()
            .environment(ViewRouter())
            .environment(UserSettingViewModel(checkNameUseCase: CheckNameUseCase(repository: RegisterRepositoryImpl()),
                                              registerUserUseCase: RegisterUserUseCase(repository: RegisterRepositoryImpl()),
                                              registerTreeMemberUseCase: RegisterTreeMemberUseCase(repository: RegisterRepositoryImpl()),
                                              acceptInvitationTreeMemberUseCase: AcceptInvitationTreeMemberUseCase(repository: InvitationRepositoryImpl()),
                                              checkInvitationsUseCase: CheckInvitationsUseCase(repository: InvitationRepositoryImpl()), presignedURLUseCase: PresignedURLUseCase(repository: FeedRepositoryImpl()), uploadImageToAWSUseCase: UploadImageToAWSUseCase(repository: AWSImageRepositoryImpl())
                                             ))
    }
}
