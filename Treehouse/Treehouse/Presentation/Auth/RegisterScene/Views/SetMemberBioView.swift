//
//  SetMemberBioView.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 4/14/24.
//

import SwiftUI

enum SetMemberBioField {
    case memberBio
}

struct SetMemberBioView: View {
    
    // MARK: - State Property
    
    @Environment(UserSettingViewModel.self) private var viewModel
    @Environment(ViewRouter.self) private var viewRouter
    
    @State var memberBio: String = ""
    @State var isButtonEnabled: Bool = false
    @State var textFieldState: TextFieldStateType = .notFocused
    @FocusState private var focusedField: SetMemberBioField?
    
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
            
            Image(.imgDummy)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
                .frame(width: 42, height: 42)
                .padding(.bottom, SizeLiterals.Screen.screenHeight * 19/852)
            
            memberBioTextField
            
            Spacer()
            
            Button(action: {
                
            }) {
                Text(StringLiterals.Register.buttonTitle11)
                    .fontWithLineHeight(fontLevel: .body2)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .foregroundStyle(.gray1)
                    .background(.treeBlack)
                    .cornerRadius(12)
            }
        }
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
        }
        .onChange(of: focusedField) { _, newValue in
            if newValue == .memberBio {
                textFieldState = .enable
            } else {
                textFieldState = .notFocused
            }
        }
    }
}

// MARK: - ViewBuilder

private extension SetMemberBioView {
    @ViewBuilder
    var memberBioTextField: some View {
        VStack(alignment: .trailing, spacing: 8) {
            TextField(StringLiterals.Register.placeholderTitle4, text: $memberBio)
                .maxLength(text: $memberBio, 20)
                .fontWithLineHeight(fontLevel: .body1)
                .foregroundStyle(textFieldState.fontColor)
                .tint(.treeGreen)
                .focused($focusedField, equals: .memberBio)
                .padding(EdgeInsets(top: 18, leading: 22, bottom: 18, trailing: 10))
                .frame(height: 62)
                .background(textFieldState.backgroundColor)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(textFieldState.borderColor, lineWidth: 1.5)
                )
                .cornerRadius(12)
            
            Text("( \(memberBio.count) / 20 )")
                .fontWithLineHeight(fontLevel: .caption1)
                .foregroundStyle(.gray6)
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        SetMemberBioView()
            .environment(ViewRouter())
            .environment(UserSettingViewModel(checkNameUseCase: CheckNameUseCase(repository: RegisterRepositoryImpl())))
    }
}
