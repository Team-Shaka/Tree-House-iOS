//
//  EditProfileView.swift
//  Treehouse
//
//  Created by 티모시 킴 on 6/13/24.
//

import SwiftUI

struct EditProfileView: View {
    
    // MARK: - State Property
    
    @Environment(ViewRouter.self) var viewRouter: ViewRouter
    @Environment(UserInfoViewModel.self) var userInfoViewModel: UserInfoViewModel
    
    @State private var profileImage: UIImage = UIImage(resource: .imgUser)
    @State private var memberName: String = ""
    @State private var bio: String = ""
    @State private var isEditing: Bool = false
    @ObservedObject private var photoPickerManager = PhotoPickerManager(type: .profileImage)
    @State private var isPhotoPickerPresented: Bool = false
    
    // MARK: - View
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Image(uiImage: profileImage)
                    .resizable()
                    .frame(width: 98, height: 98)
                    .clipShape(Circle())
                
                Button(action: {
                    isPhotoPickerPresented.toggle()
                }) {
                    Image(isEditing ? .btnProfileimg2 : .btnProfileimg1)
                        .resizable()
                        .frame(width: 32, height: 32)
                        .offset(x: 40, y: 33)
                }
                .disabled(!isEditing)
                .sheet(isPresented: $isPhotoPickerPresented) {
                    photoPickerManager.presentPhotoPicker(selectionLimit: 1)
                        .ignoresSafeArea(edges: .bottom)
                }
                .onReceive(photoPickerManager.$selectedImages) { selectedImages in
                    if let selectedImage = selectedImages.first {
                        profileImage = selectedImage
                    }
                }
            }
            .padding(.top, 15)
            
            HStack {
                Text("이름")
                    .fontWithLineHeight(fontLevel: .body4)
                    .foregroundColor(.gray6)
                
                Spacer()
            }
            .padding(.top, 17)
            .padding(.leading, SizeLiterals.Screen.screenWidth * 16 / 393)
            
            TextField(memberName, text: $memberName)
                .disabled(!isEditing)
                .padding()
                .background(isEditing ? .grayscaleWhite : .gray1)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(isEditing ? .gray8 : .clear, lineWidth: 1)
                )
                .padding(.top, 1)
                .padding(.horizontal, 16)
            
            HStack {
                Spacer()
                
                Text("( \(memberName.count) / 20 )")
                    .fontWithLineHeight(fontLevel: .caption1)
                    .foregroundColor(isEditing ? .gray6 : .grayscaleWhite)
            }
            .padding(.top, 8)
            .padding(.trailing, SizeLiterals.Screen.screenWidth * 16 / 393)
            
            HStack {
                Text("바이오")
                    .fontWithLineHeight(fontLevel: .body4)
                    .foregroundColor(.gray6)
                
                Spacer()
            }
            .padding(.top, 10)
            .padding(.leading, SizeLiterals.Screen.screenWidth * 16 / 393)
            
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(isEditing ? Color.grayscaleWhite : Color.gray1)
                    .frame(height: 76)
                
                TextEditor(text: $bio)
                    .disabled(!isEditing)
                    .frame(height: 60)
                    .padding(.all, 8)
                    .scrollContentBackground(.hidden)
                    .background(.clear)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(isEditing ? Color.gray8 : Color.clear, lineWidth: 1)
                    )
            }
            .padding(.top, 1)
            .padding(.horizontal, 16)
            
            HStack {
                Spacer()
                
                Text("( \(bio.count) / 20 )")
                    .fontWithLineHeight(fontLevel: .caption1)
                    .foregroundColor(isEditing ? .gray6 : .grayscaleWhite)
            }
            .padding(.top, 8)
            .padding(.trailing, SizeLiterals.Screen.screenWidth * 16 / 393)
            
            Spacer()
            
            Button(action: {
                if isEditing  {
                    //TODO: - 프로필 수정 API 연결
                    let nameResult = userInfoViewModel.modifyMemberName(memberName: memberName)
                    let bioResult = userInfoViewModel.modifyBio(bio: bio)
                    let imageResult = userInfoViewModel.modifyProfileImage(imageData: profileImage)
                    
                    if nameResult && bioResult && imageResult {
                        viewRouter.pop()
                    }
                }
                
                isEditing = true
            }) {
                Text(isEditing ? "저장하기" : "수정하기")
                    .font(.fontGuide(.body2))
                    .foregroundStyle(.gray1)
                    .frame(width: SizeLiterals.Screen.screenWidth * 360 / 393, height: 56)
                    .background(isEditing ? .treeGreen : .treeBlack)
                    .cornerRadius(12)
            }
            .padding(.bottom, SizeLiterals.Screen.screenHeight * 30 / 852)
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    viewRouter.pop()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.treeBlack)
                }
                .padding(.top, 5)
            }
            
            ToolbarItem(placement: .principal) {
                Text(StringLiterals.EditProfile.editProfileTitle)
                    .fontWithLineHeight(fontLevel: .body2)
            }
        }
        .onAppear {
            memberName = userInfoViewModel.safeUserInfo.treeMemberName
            profileImage = UIImage(data: userInfoViewModel.safeUserInfo.profileImageData) ?? UIImage(resource: .imgUser)
            bio = userInfoViewModel.safeUserInfo.bio
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        EditProfileView()
            .environment(ViewRouter())
            .environment(UserInfoViewModel())
    }
}
