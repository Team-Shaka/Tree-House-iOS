//
//  CreateTreehouseNameView.swift
//  Treehouse
//
//  Created by 윤영서 on 6/21/24.
//

import SwiftUI

struct CreateTreehouseNameView: View {
    
    // MARK: - State Property
    
    @Environment(ViewRouter.self) var viewRouter
    @Environment(CreateTreehouseViewModel.self) var createTreehouseViewModel
//    @State var createTreehouseViewModel: CreateTreehouseViewModel
    
    @State var treehouseName: String = ""
    @State var textFieldState: TextFieldStateType = .notFocused
    @FocusState private var focusedField: Bool
    @State var isLengthValid = false
    @State var isButtonEnabled = false
    @State var errorMessage = ""
    
    // MARK: - View
    
    var body: some View {
        @Bindable var createTreehouseViewModel = createTreehouseViewModel
        
        VStack(alignment: .leading, spacing: 0) {
            ProgressView(value: 0.33)
                .tint(.treeGreen)
                .padding(.top, 14)
                .padding(.bottom, SizeLiterals.Screen.screenHeight * 36 / 852)
            
            Text("새로운 트리하우스의\n이름을 만들어주세요!")
                .fontWithLineHeight(fontLevel: .heading1)
                .foregroundStyle(.treeBlack)
                .padding(.leading, 8)
                .padding(.bottom, SizeLiterals.Screen.screenHeight * 22 / 852)
            
            Text("트리하우스의 이름은 중복될 수 없어요.")
                .fontWithLineHeight(fontLevel: .body3)
                .foregroundStyle(.gray5)
                .padding(.leading, 8)
                .padding(.bottom, SizeLiterals.Screen.screenHeight * 54 / 852)
            
            treehouseNameTextField
                .padding(.horizontal, 8)
            
            Spacer()
            
            Button(action: {
                createTreehouseViewModel.treehouseName = treehouseName
                
                Task {
                    await createTreehouseViewModel.postCheckTreehouseName()
                    
                    if createTreehouseViewModel.isAvailable == true {
                        viewRouter.push(CreateTreehouseRouter.createTreeHallNameView)
                    } else {
                        textFieldState = .duplicated
                        errorMessage = StringLiterals.Register.indicatorTitle6
                    }
                }
            }) {
                Text("트리하우스 이름 정하기")
                    .fontWithLineHeight(fontLevel: .body2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .foregroundStyle(isButtonEnabled ? .gray1 : .gray6)
                    .background(isButtonEnabled ? .treeBlack : .gray2)
                    .cornerRadius(10)
                    .padding(.trailing, 1)
            }
            .disabled(!(isButtonEnabled))
            .padding(.bottom, SizeLiterals.Screen.screenHeight * 30 / 852)
            .padding(.horizontal, 8)
        }
        .padding(.leading, 16)
        .padding(.trailing, 16)
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    viewRouter.pop()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.treeBlack)
                }
            }
            ToolbarItem(placement: .principal) {
                Text("트리하우스 만들기")
                    .fontWithLineHeight(fontLevel: .body2)
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
            } else if isLengthValid == false {
                textFieldState = .unable
            } else {
                textFieldState = .notFocused
            }
        }
        .onChange(of: treehouseName) { _, newValue in
            if treehouseName.count >= 2 && treehouseName.count <= 20  {
                isLengthValid = true
                textFieldState = .enable
                errorMessage = ""
                isButtonEnabled = true
            } else if newValue.isEmpty {
                isButtonEnabled = false
                errorMessage = ""
                textFieldState = .enable
            } else {
                isLengthValid = false
                textFieldState = .unable
                errorMessage = StringLiterals.Register.indicatorTitle7
                isButtonEnabled = false
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
            
            HStack(spacing: 0) {
                if textFieldState == .unable || textFieldState == .duplicated {
                    Text(errorMessage)
                        .fontWithLineHeight(fontLevel: .caption1)
                        .foregroundStyle(.error)
                }
                
                Spacer()
                
                Text("( \(treehouseName.count) / 20 )")
                    .fontWithLineHeight(fontLevel: .caption1)
                    .foregroundStyle(.gray6)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    CreateTreehouseNameView()
        .environment(ViewRouter())
}
