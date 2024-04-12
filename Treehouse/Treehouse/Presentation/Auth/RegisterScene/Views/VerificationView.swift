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
    
    @State private var verificationCode: String = ""
    @State private var isCodeCorrect = true
    @FocusState private var isKeyboardShowing: Bool
    
    // MARK: - View
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 0) {
                    Text("\(phoneNumber ?? "nil")")
                        .font(.fontGuide(.heading1))
                        .foregroundStyle(.treeGreen)
                    +
                    Text("로 전송된\n6자리 인증번호를 입력해주세요.")
                        .font(.fontGuide(.heading1))
                        .foregroundStyle(.treeBlack)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 72)
                
                Spacer(minLength: SizeLiterals.Screen.screenHeight * 50 / 852)
                
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
                .padding(.bottom, 20)
                .padding(.top, 10)
                
                Spacer(minLength: SizeLiterals.Screen.screenHeight * 8 / 852)
                
                Text("*인증번호가 맞지 않습니다.")
                    .font(.fontGuide(.caption1))
                    .foregroundStyle(isCodeCorrect ? .grayscaleWhite : .error)
                
                Spacer(minLength: SizeLiterals.Screen.screenHeight * 24 / 852)
                
                Text(StringLiterals.Register.guidanceTitle1)
                    .font(.fontGuide(.body5))
                    .foregroundStyle(.gray5)
                    .frame(height: 60)
            }
            .padding(.top, SizeLiterals.Screen.screenHeight * 66 / 852)
            
            Spacer(minLength: SizeLiterals.Screen.screenHeight * 335 / 852)
            
            Button {
                print("다음으로 버튼 탭했음")
            } label: {
                Text("다음으로")
                    .font(.fontGuide(.body2))
                    .frame(width: SizeLiterals.Screen.screenWidth * 344 / 393, height: 56)
                    .disableWithOpacity(verificationCode.count < 6)
                    .cornerRadius(12)
            }
            .padding(.bottom, SizeLiterals.Screen.screenHeight * 30 / 852)
        }
        .padding(.horizontal, SizeLiterals.Screen.screenWidth * 24 / 393)
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                Button("완료"){
                    isKeyboardShowing.toggle()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }
    
    // MARK: Verification Code Box
    
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
    VerificationView(phoneNumber: "+82010XXXXXXXX")
}

// MARK: View Extensions

extension View{
    func disableWithOpacity(_ condition: Bool) -> some View {
        self
            .disabled(condition)
            .foregroundStyle(condition ? Color.gray6 : Color.gray1)
            .background(condition ? Color.gray2 : Color.treeBlack)
    }
}

// MARK: Binding <String> Extension

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
