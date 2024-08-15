//
//  CreateTreeHallNameView.swift
//  Treehouse
//
//  Created by 윤영서 on 6/21/24.
//

import SwiftUI

struct CreateTreeHallNameView: View {
    
    // MARK: - State Property
    @Environment(ViewRouter.self) var viewRouter
    @Environment(CreateTreehouseViewModel.self) var createTreehouseViewModel
    
    @State var textFieldState: TextFieldStateType = .notFocused
    @FocusState private var focusedField: Bool
    @State var isButtonEnabled = false
    @State var isLengthValid = false
    @State var treeHallName: String = ""
    @State var errorMessage = ""
    
    // MARK: - View
    
    var body: some View {
        VStack(alignment: .leading, spacing: 22) {
            ProgressView(value: 0.66)
                .tint(.treeGreen)
                .padding(.bottom, 14)
                .padding(.top, 14)
            
            Text(StringLiterals.CreateTreehouse.createTreehouseTitle4)
                .fontWithLineHeight(fontLevel: .heading1)
                .foregroundStyle(.treeBlack)
                .padding(.leading, 8)
            
            Text(StringLiterals.CreateTreehouse.createTreehouseTitle5)
                .fontWithLineHeight(fontLevel: .body3)
                .foregroundStyle(.gray5)
                .padding(.leading, 8)
            
            treeHallNameTextField
                .padding(.top, 6)
            
            Spacer()
            
            Button(action: {
                createTreehouseViewModel.treehouseHallName = treeHallName
                viewRouter.push(CreateTreehouseRouter.previewCreatedTreehouseView)
            }) {
                Text("트리홀 이름 정하기")
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
        .onChange(of: treeHallName) { _, newValue in
            if treeHallName.count >= 2 && treeHallName.count <= 20  {
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
//        .onChange(of: focusedField) { _, newValue in
//            if newValue == true {
//                textFieldState = .enable
//            } else {
//                textFieldState = .notFocused
//            }
//        }
//        .onChange(of: treeHallName) { _, newValue in
//            if newValue.isEmpty {
//                isButtonEnabled = false
//            } else {
//                isButtonEnabled = true
//            }
//        }
    }
}

private extension CreateTreeHallNameView {
    @ViewBuilder
    var treeHallNameTextField: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextField("트리홀 이름 입력", text: $treeHallName)
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
                
                Text("( \(treeHallName.count) / 20 )")
                    .fontWithLineHeight(fontLevel: .caption1)
                    .foregroundStyle(.gray6)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    CreateTreeHallNameView()
}
