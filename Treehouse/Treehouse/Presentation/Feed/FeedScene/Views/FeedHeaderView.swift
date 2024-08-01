////
////  FeedHeaderView.swift
////  Treehouse
////
////  Created by 티모시 킴 on 5/23/24.
////
//
//import SwiftUI
//
//struct FeedHeaderView: View {
//    
//    // MARK: - Property
//    
//    let groupList = GroupStruct.groupStructDummyData
//    
//    // MARK: - State Property
//    
//    @State var isPresent = false
//    @State private var groupName: String = "groupname"
//    @State private var subject: String = "오늘 점심 뭐 먹지?"
//    @State private var personnel: Int = 30
//    
//    // MARK: - View
//    
//    var body: some View {
//        ZStack {
//            VStack(spacing: 0) {
//                HeaderView(groupName: groupName, isPresent: $isPresent)
//                    .frame(height: 56)
//                    .frame(maxWidth: .infinity)
//                    .background(.grayscaleWhite)
//                
//                ScrollView {
//                    VStack {
//                        TreeHallView(groupName: groupName, subject: subject, personnel: personnel)
//                    }
//                }
//                .padding(.top, 10)
//                .padding(.bottom, 16)
//            }
//            
//            ZStack(alignment: .bottom) {
//                Color.black.opacity(0.5)
//                    .edgesIgnoringSafeArea(.top)
//                    .opacity(isPresent ? 1 : 0)
//                    .onTapGesture {
//                        isPresent = false
//                    }
//                
//                if self.isPresent {
//                    BottomSheet($isPresent, height: calculateBottomSheetHeight(groupCount: groupList.count)) {
//                        VStack {
//                            Spacer()
//                            
//                            if groupList.count > (SizeLiterals.Screen.screenHeight/2 > 400 ? 3 : 2) {
//                                ScrollView {
//                                    ForEach(groupList) { group in
//                                        GroupRow(group: group)
//                                    }
//                                }
//                                .scrollIndicators(.never)
//                            } else {
//                                ForEach(groupList) { group in
//                                    GroupRow(group: group)
//                                }
//                            }
//                            
//                            Button {
//                                print("탭 수행")
//                            } label: {
//                                Text("+ 새로운 트리 만들기")
//                                    .font(.fontGuide(.body2))
//                                    .foregroundStyle(.gray1)
//                                    .frame(width: SizeLiterals.Screen.screenWidth * 360 / 393, height: 56)
//                                    .background(.treeBlack)
//                                    .cornerRadius(12)
//                            }
//                            .padding(.top, 8)
//                            .padding(.bottom, SizeLiterals.Screen.screenHeight * 64 / 852)
//                        }
//                        .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    }
//                }
//            }
//            .edgesIgnoringSafeArea(.all)
//            .animation(.interactiveSpring(), value: isPresent)
//        }
//    }
//    
//    // 바텀 시트 높이 조절 함수(디바이스의 세로 길이, 그룹의 개수별 높이 조절)
//    private func calculateBottomSheetHeight(groupCount: Int) -> CGFloat {
//        switch groupCount {
//        case 1:
//            return 220
//        case 2:
//            return 310
//        case 3:
//            return (SizeLiterals.Screen.screenHeight/2 > 400 ? 400 : 310)
//        default:
//            return (SizeLiterals.Screen.screenHeight/2 > 400 ? 400 : 310)
//        }
//    }
//}
//
//// MARK: - Preview
//
//#Preview {
//    FeedHeaderView()
//}
