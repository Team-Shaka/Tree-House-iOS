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

struct PhoneNumberInsertView: View {
    
    // MARK: - State Property
    
    @FocusState private var focusField: Field?
    @State private var phoneNumber: String = ""
    
    // MARK: - View
    
    var body: some View {
        NavigationView {
            VStack {
                Text(StringLiterals.Register.registerTitle1)
                    .font(.fontGuide(.heading1))
                    .fontWithLineHeight(fontLevel: .heading1)
                    .foregroundColor(.treeBlack)
                    .padding(.trailing, 100)
                    .padding(.top, 34)
                    .padding(.bottom, 36)
                
                HStack {
                    Text("+82")
                        .font(.fontGuide(.body3))
                        .foregroundColor(.gray7)
                        .padding(.leading)
                    
                    TextField("전화번호 입력", text: $phoneNumber)
                        .keyboardType(.numberPad)
                        .padding()
                        .tint(.treeGreen)
                        .focused($focusField, equals: .phoneNumber)
                }
                .frame(width: 345, height: 62)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.gray7, lineWidth: 1)
                    )
                
                Text(StringLiterals.Register.guidanceTitle1)
                    .font(.fontGuide(.body5))
                    .foregroundColor(.gray5)
                    .padding()
                
                Spacer()
                
                Button("인증번호 보내기") {
                    if phoneNumber.isEmpty {
                        focusField = .phoneNumber
                    }
                    print("send code button tapped")
                }
                .frame(width: 344, height: 56)
                .font(.fontGuide(.body2))
                .foregroundColor(.gray6)
                .background(.gray2)
                .cornerRadius(12)
                .padding(.horizontal, 24)
                
                // 네비게이션 바 설정
                .navigationBarItems(leading: Button(action: {
                    // 돌아가기 버튼의 액션
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.treeBlack)
                })
            }
        }
        
        .onAppear {
            UITextField.appearance().clearButtonMode = .whileEditing
        }
        
        .onTapGesture {
            hideKeyboard()
        }
    }
}


// MARK: - View Builder

extension 

// MARK: - Preview

#Preview {
    PhoneNumberInsertView()
}
