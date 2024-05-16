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
    @State var viewModel = UserSettingViewModel()
    
    @State var userId: String = ""
    @State var textFieldState: TextFieldStateType = .notFocused
    @FocusState private var focusedField: SetUserIdField?
    
    // MARK: - View
    
    var body: some View {
        @Bindable var viewRouter = viewRouter
        
        NavigationStack(path: $viewRouter.path) {
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
                .padding(.bottom, 26)
                
                userNameTextField
                
                Spacer()
                
                Button(action: {
                    if viewModel.isButtonEnabled {
                        viewModel.userId = userId
                        viewRouter.push(RegisterRouter.showUserProfileView)
                    }
                }) {
                    Text(StringLiterals.Register.buttonTitle5)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .foregroundStyle(viewModel.isButtonEnabled ? .gray1 : .gray6)
                        .background(viewModel.isButtonEnabled ? .treeBlack : .gray2)
                        .cornerRadius(10)
                        .padding(.trailing, 1)
                }
            }
            .padding(EdgeInsets(top: 22, leading: 24, bottom: 30, trailing: 24))
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.treeBlack)
                    }
                    .padding(.top, 5)
                }
            }
            .navigationDestination(for: RegisterRouter.self) { router in
                viewRouter.buildScene(inputRouter: router, viewModel: viewModel)
            }
        }
        .onAppear {
            UITextField.appearance().clearButtonMode = .whileEditing
        }
        .onChange(of: userId) { _, newValue in
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
                .fontWithLineHeight(fontLevel: .body2)
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
            
            if textFieldState == .unable {
                Text(StringLiterals.Register.indicatorTitle3)
                    .fontWithLineHeight(fontLevel: .caption1)
                    .foregroundStyle(.error)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        SetUserIdView(viewModel: UserSettingViewModel())
            .environment(ViewRouter())
    }
}
