//
//  PhoneNumberInsertView.swift
//  Treehouse
//
//  Created by 윤영서 on 4/11/24.
//

import SwiftUI

enum Field {
    case phoneNumber
}

enum TextFieldType {
    case focused
    case unFocused
    
    var borderColor: Color {
        switch self {
        case .focused:
            return .gray7
        case .unFocused:
            return .clear
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .focused:
            return .grayscaleWhite
        case .unFocused:
            return .gray1
        }
    }
}

struct SetPhoneNumberView: View {
    
    // MARK: - State Property
    
    @State private var phoneNumber: String = ""
    @State private var errorMessage: String? = nil
    @State private var textFieldState: TextFieldType = .unFocused
    @State private var isButtonEnabled: Bool = false
    
    @FocusState private var focusedField: Field?
    
    // MARK: - View
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Text(StringLiterals.Register.registerTitle1)
                    .font(.fontGuide(.heading1))
                    .fontWithLineHeight(fontLevel: .heading1)
                    .foregroundColor(.treeBlack)
                    .padding(EdgeInsets(top: 34, leading: 0, bottom: 36, trailing: 100))
                
                VStack(alignment: .leading, spacing: 8) {
                    phoneNumberTextField
                    
                    if errorMessage == errorMessage {
                        Text(errorMessage ?? "")
                            .foregroundColor(.error)
                            .font(.fontGuide(.caption1))
                    }
                }
                
                Text(StringLiterals.Register.guidanceTitle1)
                    .font(.fontGuide(.body5))
                    .foregroundColor(.gray5)
                    .padding(.top, errorMessage == nil ? 0 : 14)
                
                Spacer()
                
                Button(action: {
                    
                }) {
                    Text(StringLiterals.Register.buttonTitle1)
                        .frame(width: 344, height: 56)
                        .font(.fontGuide(.body2))
                        .foregroundColor(isButtonEnabled ? .gray1 : .gray6)
                        .background(isButtonEnabled ? .treeBlack : .gray2)
                        .cornerRadius(12)
                        .padding(.horizontal, 24)
                }
                
                .navigationBarItems(leading: Button(action: {
                    // 돌아가기 버튼 액션
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.treeBlack)
                })
            }
        }
        
        .onAppear {
            UITextField.appearance().clearButtonMode = .whileEditing
        }
        
        
        .onChange(of: focusedField) { _, newValue in
            if newValue == .phoneNumber {
                textFieldState = .focused
            } else {
                textFieldState = .unFocused
            }
        }
        
        .onChange(of: phoneNumber) { _, newValue in
            if newValue.validatePhoneNumber() {
                errorMessage = nil
                isButtonEnabled = true
            } else if newValue.isEmpty {
                errorMessage = nil
                isButtonEnabled = false
            } else {
                errorMessage = StringLiterals.Register.indicatorTitle1
                isButtonEnabled = false
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
        .frame(width: 345, height: 62)
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
}
