//
//  SetMemeberProfileNameView.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 4/14/24.
//

import SwiftUI

enum SetMemberNameField {
    case memberName
}

struct SetMemeberProfileNameView: View {
    
    // MARK: - State Property
    
    @State var memberName: String = ""
    @State var isButtonEnabled: Bool = false
    @State var textFieldState: TextFieldStateType = .notFocused
    @FocusState private var focusedField: SetMemberNameField?
    
    // MARK: - View
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(StringLiterals.Register.registerTitle6)
                        .fontWithLineHeight(fontLevel: .heading1)
                        .padding(.bottom, SizeLiterals.Screen.screenHeight * 22/852)
                    
                    Text(StringLiterals.Register.guidacneTitle10)
                        .fontWithLineHeight(fontLevel: .body3)
                        .foregroundStyle(.gray5)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, SizeLiterals.Screen.screenHeight * 30/852)
                .padding(.bottom, SizeLiterals.Screen.screenHeight * 96/852)
                  
                memberNameTextField
                
                Spacer()
                
                Button(action: {
                    
                }) {
                    Text(StringLiterals.Register.buttonTitle9)
                        .fontWithLineHeight(fontLevel: .body2)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .foregroundStyle(isButtonEnabled ? .gray1 : .gray6)
                        .background(isButtonEnabled ? .treeBlack : .gray2)
                        .cornerRadius(10)
                }
            }
            .padding(EdgeInsets(top: 0, leading: 24, bottom: 30, trailing: 24))
            .background(.grayscaleWhite)
            .navigationBarTitleDisplayMode(.inline)
            .background(.grayscaleWhite)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(StringLiterals.Register.navigationTitle1)
                        .fontWithLineHeight(fontLevel: .body2)
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.treeBlack)
                    }
                }
            }
        }
        .onAppear {
            UITextField.appearance().clearButtonMode = .whileEditing
        }
        .onChange(of: memberName) { _, newValue in
            if self.isValidInputUserId(newValue) {
                isButtonEnabled = true
                textFieldState = .enable
            } else {
                isButtonEnabled = false
                textFieldState = .unable
            }
        }
        .onChange(of: focusedField) { _, newValue in
            if newValue == .memberName {
                textFieldState = .enable
            } else {
                textFieldState = .notFocused
            }
        }
    }
}

// MARK: - ViewBuilder

private extension SetMemeberProfileNameView {
    @ViewBuilder
    var memberNameTextField: some View {
        VStack(alignment: .trailing, spacing: 8) {
            TextField(StringLiterals.Register.placeholderTitle2, text: $memberName)
                .fontWithLineHeight(fontLevel: .body1)
                .foregroundStyle(textFieldState.fontColor)
                .tint(.treeGreen)
                .focused($focusedField, equals: .memberName)
                .padding(EdgeInsets(top: 18, leading: 22, bottom: 18, trailing: 10))
                .frame(height: 62)
                .background(textFieldState.backgroundColor)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(textFieldState.borderColor, lineWidth: 1.5)
                )
                .cornerRadius(12)
            
            Text("( \(0) / \(memberName.count) )")
                .fontWithLineHeight(fontLevel: .caption1)
                .foregroundStyle(.gray6)
        }
    }
}

// MARK: - Preview

#Preview {
    SetMemeberProfileNameView()
}
