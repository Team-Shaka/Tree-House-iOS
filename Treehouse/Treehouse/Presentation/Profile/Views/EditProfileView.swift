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
    
    @State var modifyMyProfileViewModel = ModifyMyProfileViewModel(modifyMyProfileUseCase: ModifyMyProfileUseCase(repository: MemberRepositoryImpl()))
    @State var presingedURLViewModel = PresingedURLViewModel(presignedURLUseCase: PresignedURLUseCase(repository: FeedRepositoryImpl()))
    @State var loadImageAWSViewModel = LoadImageAWSViewModel(uploadImageToAWSUseCase: UploadImageToAWSUseCase(repository: AWSImageRepositoryImpl()))
    
    @State private var profileImage: UIImage = UIImage(resource: .imgUser)
    
    @State var profileUrl: String = ""
    @State var memberName: String = ""
    @State var bio: String = ""
    @State private var isEditing: Bool = false
    
    @ObservedObject private var photoPickerManager = PhotoPickerManager(type: .profileImage)
    @State private var isPhotoPickerPresented: Bool = false
    
    var treehouseId: Int
    var memberId: Int
    @State var isSelectImage: Bool = false
    
    // MARK: - View
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                if !(profileUrl.isEmpty) && isSelectImage == false {
                    CustomAsyncImage(url: profileUrl,
                                     type: .postMemberProfileImage,
                                     width: 98,
                                     height: 98)
                        .clipShape(Circle())
                } else if isSelectImage {
                    Image(uiImage: profileImage)
                        .resizable()
                        .frame(width: 98, height: 98)
                        .clipShape(Circle())
                } else {
                    Image(uiImage: profileImage)
                        .resizable()
                        .frame(width: 98, height: 98)
                        .clipShape(Circle())
                }
                
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
                        self.isSelectImage = true
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
            
            TextField(modifyMyProfileViewModel.memberName, text: $modifyMyProfileViewModel.memberName)
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
                
                Text("( \(modifyMyProfileViewModel.memberName.count) / 20 )")
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
                
                TextEditor(text: $modifyMyProfileViewModel.memberBio)
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
                
                Text("( \(modifyMyProfileViewModel.memberBio.count) / 20 )")
                    .fontWithLineHeight(fontLevel: .caption1)
                    .foregroundColor(isEditing ? .gray6 : .grayscaleWhite)
            }
            .padding(.top, 8)
            .padding(.trailing, SizeLiterals.Screen.screenWidth * 16 / 393)
            
            Spacer()
            
            Button(action: {
                if isEditing  {
                    //TODO: - 프로필 수정 API 연결
                    Task {
                        
                        if isSelectImage {
                            let presingedResult = await presingedURLViewModel.presignedURL(
                                treehouseId: treehouseId,
                                memberId: memberId,
                                selectImage: photoPickerManager.selectedImages
                            )
                            
                            if let result = presingedResult {
                                let _ = await loadImageAWSViewModel.loadImageAWS(uploadImages: photoPickerManager.selectedImages, ImageUrl: result)
                                modifyMyProfileViewModel.memberProfileUrl = result.first?.accessUrl ?? ""
                                await modifyMyProfileViewModel.modifyMyProfile(treehouseId: treehouseId)
                            }
                        } else {
                            await modifyMyProfileViewModel.modifyMyProfile(treehouseId: treehouseId)
                        }
                    }

                    let nameResult = userInfoViewModel.modifyMemberName(treehouseId: treehouseId, memberName: memberName)
                    let bioResult = userInfoViewModel.modifyBio(treehouseId: treehouseId, bio: bio)
                    let imageResult = userInfoViewModel.modifyProfileImage(treehouseId: treehouseId, imageUrl: profileUrl)
                    
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
//            memberName = userInfoViewModel.safeUserInfo.treeMemberName
//            profileImage = UIImage(data: userInfoViewModel.safeUserInfo.profileImageData) ?? UIImage(resource: .imgUser)
//            bio = userInfoViewModel.safeUserInfo.bio
            
            modifyMyProfileViewModel.memberProfileUrl = profileUrl
            modifyMyProfileViewModel.memberName = memberName
            modifyMyProfileViewModel.memberBio = bio
        }
    }
    
//    func bindData(memberProfileUrl: String, memberName: String, bio: String) {
//        modifyMyProfileViewModel.memberProfileUrl = memberProfileUrl
//        modifyMyProfileViewModel.memberName = memberName
//        modifyMyProfileViewModel.memberBio = bio
//    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        EditProfileView(treehouseId: 0, memberId: 0)
            .environment(ViewRouter())
            .environment(UserInfoViewModel())
    }
}
