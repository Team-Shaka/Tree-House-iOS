//
//  PreviewCreatedTreehouseView.swift
//  Treehouse
//
//  Created by 윤영서 on 6/21/24.
//

import SwiftUI

struct PreviewCreatedTreehouseView: View {
    
    // MARK: - State Property
    
    @Environment(ViewRouter.self) var viewRouter
    @Environment(CreateTreehouseViewModel.self) var createTreehouseViewModel
    @State private var userInfoViewModel = UserInfoViewModel()
    
    @State var treehallParticipantsCount: Int = 0
    
    // MARK: - View
    
    var body: some View {
        VStack(alignment: .leading, spacing: 22) {
            ProgressView(value: 0.66)
                .tint(.treeGreen)
                .padding(.vertical, SizeLiterals.Screen.screenHeight * 14 / 852)
            
            Text(StringLiterals.CreateTreehouse.createTreehouseTitle3)
                .fontWithLineHeight(fontLevel: .heading1)
                .foregroundStyle(.treeBlack)
                .padding(.leading, 8)
                .padding(.bottom, SizeLiterals.Screen.screenHeight * 33 / 852)
            
            ZStack {
                HStack(spacing: 10) {
                    Image(.imgUser)
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 36, height: 36)
                    
                    Text(createTreehouseViewModel.treehouseName)
                        .fontWithLineHeight(fontLevel: .heading4)
                        .foregroundStyle(.treeBlack)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 46)
                .padding(.bottom, SizeLiterals.Screen.screenHeight * 200 / 852)
                
                Image(.imgCreatetreehouse)
                
                TreeHallView(groupName: createTreehouseViewModel.treehouseName,
                             subject: createTreehouseViewModel.treehouseHallName,
                             personnel: treehallParticipantsCount)
                .padding(.bottom, SizeLiterals.Screen.screenHeight * 30 / 852)
            }
            
            Spacer()
            
            VStack(spacing: 12) {
                Button(action: {
                    Task {
                        let result = await performAsyncTasks()
                        
                        if result {
                            viewRouter.push(CreateTreehouseRouter.sendInvitationView)
                        }
                    }
                }) {
                    Text("좋아요!")
                        .fontWithLineHeight(fontLevel: .body2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .foregroundStyle(.grayscaleWhite)
                        .background(.grayscaleBlack)
                        .cornerRadius(10)
                        .padding(.trailing, 1)
                }
                .padding(.horizontal, 8)
                
                Button(action: {
                    viewRouter.popMultiple(count: 2)
                }) {
                    Text("다시 작성하고 싶어요")
                        .fontWithLineHeight(fontLevel: .body2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .foregroundStyle(.gray5)
                        .background(.grayscaleWhite)
                        .cornerRadius(10)
                        .padding(.trailing, 1)
                }
                .padding(.horizontal, 8)
            }
        }
        .padding(.horizontal, 16)
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
    }
    
    func performAsyncTasks() async -> Bool {
        let treehouseId = await createTreehouseViewModel.createTreehouse()
        
        if let id = treehouseId {
            let result = userInfoViewModel.modifyTreehouse(treehouseId: id)
            print("정보 저장 결과:", result)
            return result
        }
        
        return false
    }
}

// MARK: - Preview

#Preview {
    PreviewCreatedTreehouseView()
        .environment(ViewRouter())
        .environment(CreateTreehouseViewModel(
            checkTreehouseNameUseCase: CheckTreehouseNameUseCase(repository: TreehouseRepositoryImpl()),
            createTreehouseUseCase: CreateTreehouseUseCase(repository: TreehouseRepositoryImpl())
        ))
}
