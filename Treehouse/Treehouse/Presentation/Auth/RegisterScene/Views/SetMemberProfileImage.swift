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
    
    @StateObject private var photoPickerManager = PhotoPickerManager(type: .profileImage)
    @State private var isPickerPresented = false
    
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
                    isPickerPresented = true
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
                Task {
                    if await viewModel.presignedURL() {
                        await viewModel.loadImageAWS()
                    }
                }
                
                if viewModel.isPresignedURL == viewModel.isloadImageAWS {
                    viewRouter.push(RegisterRouter.setMemberBioView)
                }
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
        .sheet(isPresented: $isPickerPresented) {
            photoPickerManager.presentPhotoPicker(selectionLimit: 1)
                .ignoresSafeArea(edges: .bottom)
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

            if let selecteImage = photoPickerManager.selectedImages.first {
                ZStack {
                    Image(.imgUserRing)
                    
                    Image(uiImage: selecteImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                        .frame(width: SizeLiterals.Screen.screenWidth * 130.24 / 393, height: SizeLiterals.Screen.screenHeight * 130.24 / 852)
                }
                .onAppear {
                    viewModel.profileImage = selecteImage
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
            .environment(UserSettingViewModel(checkNameUseCase: CheckNameUseCase(repository: RegisterRepositoryImpl()),
                                              registerUserUseCase: RegisterUserUseCase(repository: RegisterRepositoryImpl()),
                                              registerTreeMemberUseCase: RegisterTreeMemberUseCase(repository: RegisterRepositoryImpl()),
                                              acceptInvitationTreeMemberUseCase: AcceptInvitationTreeMemberUseCase(repository: InvitationRepositoryImpl()),
                                              checkInvitationsUseCase: CheckInvitationsUseCase(repository: InvitationRepositoryImpl()), presignedURLUseCase: PresignedURLUseCase(repository: FeedRepositoryImpl()), uploadImageToAWSUseCase: UploadImageToAWSUseCase(repository: AWSImageRepositoryImpl()), registerType: .registerUser
                                             ))
    }
}
