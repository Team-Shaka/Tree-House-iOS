//
//  SetMemberProfileImage.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 4/14/24.
//

import SwiftUI

struct SetMemberProfileImage: View {

    // MARK: - State Property
    
    @Environment(UserSettingViewModel.self) private var viewModel
    @Environment(ViewRouter.self) private var viewRouter
    
    @State var isProfileImage: Bool = false
    
    // MARK: - View
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text(StringLiterals.Register.registerTitle7)
                    .fontWithLineHeight(fontLevel: .heading1)
                    .padding(.bottom, SizeLiterals.Screen.screenHeight * 22 / 852)
                
                Text(StringLiterals.Register.guidanceTitle7)
                    .fontWithLineHeight(fontLevel: .body3)
                    .foregroundStyle(.gray5)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, SizeLiterals.Screen.screenHeight * 22 / 852)
            .padding(.bottom, SizeLiterals.Screen.screenHeight * 15 / 852)
            
            ZStack(alignment: .bottom) {
                memberProfileImage
                
                Button(action: {
                    
                }) {
                    Text(StringLiterals.Register.buttonTitle13)
                        .fontWithLineHeight(fontLevel: .body2)
                        .padding(.vertical, 9)
                        .padding(.horizontal, 18)
                        .frame(height: 42)
                        .foregroundStyle(.treeGreen)
                        .background(.clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 42)
                                .stroke(.treeGreen, lineWidth: 1.5)
                        )
                }
                .padding(.bottom, SizeLiterals.Screen.screenHeight * 44 / 852)
            }
            
            Spacer()
            
            Button(action: {
                viewRouter.push(RegisterRouter.setMemberBioView)
            }) {
                Text(StringLiterals.Register.buttonTitle10)
                    .fontWithLineHeight(fontLevel: .body2)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .foregroundStyle(.gray1)
                    .background(.treeBlack)
                    .cornerRadius(12)
            }
            .padding(.bottom, SizeLiterals.Screen.screenHeight * 30 / 852)
        }
        .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .background(.grayscaleWhite)
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
    }
}

// MARK: - ViewBuilder

private extension SetMemberProfileImage {
    @ViewBuilder
    var memberProfileImage: some View {
        ZStack {
            Image(.imgBackground)
                .aspectRatio(contentMode: .fill)

            if isProfileImage {
                ZStack {
                    Image(.imgUserRing)
                    
                    Image(.imgDummy)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                        .frame(width: SizeLiterals.Screen.screenWidth * 130.24 / 393, height: SizeLiterals.Screen.screenHeight * 130.24 / 852)
                }
            } else {
                Image(.imgUser2)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        SetMemberProfileImage()
            .environment(ViewRouter())
            .environment(UserSettingViewModel(checkNameUseCase: CheckNameUseCase(repository: RegisterRepositoryImpl()),           registerUserUseCase: RegisterUserUseCase(repository: RegisterRepositoryImpl())))
    }
}
