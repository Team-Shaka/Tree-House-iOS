//
//  CreateTreehouseNameView.swift
//  Treehouse
//
//  Created by 윤영서 on 6/21/24.
//

import SwiftUI

struct CreateTreehouseNameView: View {
    
    // MARK: - State Property
    
    @State var treehouseName: String = ""
    @State var textFieldState: TextFieldStateType = .notFocused
    @FocusState private var focusedField: Bool
    
    @State var isLengthValid = false
    @State var isValidInput = false
    @State var isButtonEnabled = false
    
    @State var errorMessage = ""
    
    // MARK: - View
    
    var body: some View {
        NavigationStack {
            
            VStack(alignment: .leading, spacing: 22) {
                ProgressView(value: 0.33)
                    .tint(.treeGreen)
                    .padding(.bottom, 14)
                    .padding(.top, 14)
                
                Text("새로운 트리하우스의 이름을 만들어주세요!")
                    .fontWithLineHeight(fontLevel: .heading1)
                    .foregroundStyle(.treeBlack)
                    .padding(.leading, 8)
                
                Text("트리하우스의 이름은 중복될 수 없어요.")
                    .fontWithLineHeight(fontLevel: .body3)
                    .foregroundStyle(.gray5)
                    .padding(.leading, 8)
                
                treehouseNameTextField
                    .padding(.top, 32)
                
                Spacer()
                
                Button(action: {
                    
                }) {
                    Text("트리하우스 이름 정하기")
                        .font(.fontGuide(.body2))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .foregroundStyle(isButtonEnabled ? .gray1 : .gray6)
                        .background(isButtonEnabled ? .treeBlack : .gray2)
                        .cornerRadius(10)
                        .padding(.trailing, 1)
                }
            }
            .padding(.leading, 16)
            .padding(.trailing, 16)
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        // TODO: - 뒤로 가기 액션
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.treeBlack)
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("트리하우스 만들기")
                        .font(.fontGuide(.body2))
                        .foregroundStyle(.treeBlack)
                }
            }
            .onAppear {
                UITextField.appearance().clearButtonMode = .whileEditing
                UIApplication.shared.hideKeyboard()
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
}

private extension CreateTreehouseNameView {
    @ViewBuilder
    var treehouseNameTextField: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextField("트리하우스 이름 입력", text: $treehouseName)
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
    CreateTreehouseNameView()
}
