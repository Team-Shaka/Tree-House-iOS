//
//  ShowMemberProfileView.swift
//  Treehouse
//
//  Created by 윤영서 on 4/14/24.
//

import SwiftUI

struct ShowMemberProfileView: View {
    
    // MARK: - TODO
    // userId, bio, profileImg 서버 통신
    
    // MARK: - State Property
    
    @State var userId: String = "younkyum"
    @State var bio: String = "안녕하세요, 진윤겸입니다!"
    @State var isRetryButtonDisabled = false
    
    // MARK: - View
    
    var body: some View {
        NavigationStack {
            Text("\(userId)\(StringLiterals.Register.registerTitle10)")
                .foregroundColor(.treeBlack)
                .font(.fontGuide(.heading1))
                .fontWithLineHeight(fontLevel: .heading1)
                .padding(.top, 30)
                .padding(.leading, 25)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            profileView
            
            Spacer()
            
            Button(action: {
                // MARK: - TODO
                // lottie 추가
                isRetryButtonDisabled = true
            }) {
                Text(StringLiterals.Register.buttonTitle6)
                    .frame(width: 344, height: 56)
                    .font(.fontGuide(.body2))
                    .foregroundColor(.gray1)
                    .background(.treeBlack)
                    .cornerRadius(12)
                    .padding(.horizontal, 24)
            }
            
            Button(action: {
                // MARK: - TODO
                // 뷰 연결 - SetMemberProfileName
            }) {
                Text(StringLiterals.Register.buttonTitle12)
                    .fontWithLineHeight(fontLevel: .body5)
                    .foregroundStyle(.gray6)
                    .underline()
                    .padding(EdgeInsets(top: 15, leading: 17, bottom: 19, trailing: 17))
            }
            .disabled(isRetryButtonDisabled)
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        // MARK: - TODO
                        // 뷰 연결 - SetProfileBio
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text(StringLiterals.Register.navigationTitle1)
                        .font(.fontGuide(.body2))
                }
            }
        }
    }
}

// MARK: - View Builder

extension ShowMemberProfileView {
    @ViewBuilder
    var profileView: some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 12.0)
                .stroke(.gray3, lineWidth: 1)
                .padding(.top, 56)
            
            profileImageView
            
            VStack(spacing: 0) {
                VStack(spacing: 2) {
                    Text(userId)
                        .fontWithLineHeight(fontLevel: .heading3)
                        .foregroundStyle(.black)
                    
                    Text("@\(userId)")
                        .fontWithLineHeight(fontLevel: .body3)
                        .foregroundStyle(.gray5)
                }
                Text(bio)
                    .font(.fontGuide(.body5))
                    .foregroundColor(.gray7)
                    .padding(.top, 22)
                    .padding(.bottom, 27)
            }
            .padding(.top, 124)
        }
        .padding(EdgeInsets(top: 48, leading: 23, bottom: 125, trailing: 24))
    }
    
    @ViewBuilder
    var profileImageView: some View {
        Circle()
            .frame(width: 112, height: 112)
        
            .overlay {
                Circle().stroke(LinearGradient(gradient: Gradient(colors: [.treeGreen, .treeBlack]),
                                               startPoint: .top,
                                               endPoint: .bottom),
                                lineWidth: 4)
                
                Circle().fill(.treePale)
                
                Image(.imgDummy)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 99, height: 99)
                    .clipShape(Circle())
            }
    }
}

// MARK: - Preview

#Preview {
    ShowMemberProfileView()
}
