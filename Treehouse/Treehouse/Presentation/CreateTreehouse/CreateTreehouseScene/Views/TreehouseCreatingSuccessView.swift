////
////  TreehouseCreatingSuccessView.swift
////  Treehouse
////
////  Created by 윤영서 on 6/21/24.
////
//
//import SwiftUI
//
//struct TreehouseCreatingSuccessView: View {
//
//    // MARK: - View
//    
//    var body: some View {
//        VStack(spacing: 0) {
//            FeedHeaderView()
//            
//            noAcceptationView
//                .padding(.top, -40)
//        }
//    }
//}
//
//private extension TreehouseCreatingSuccessView {
//    
//    // MARK: - ViewBuilder
//    
//    @ViewBuilder
//    var noAcceptationView: some View {
//        VStack(spacing: 24) {
//            Image(.imgFeedempty)
//            
//            Text(StringLiterals.CreateTreehouse.createTreehouseTitle1)
//                .foregroundStyle(.gray5)
//                .multilineTextAlignment(.center)
//            
//            Spacer()
//            
//            ZStack {
//                RoundedRectangle(cornerRadius: 10.0)
//                    .foregroundStyle(.treePale)
//                    .frame(width: 351, height: 70)
//                
//                Text(StringLiterals.CreateTreehouse.createTreehouseTitle2)
//                    .fontWithLineHeight(fontLevel: .body3)
//                    .foregroundStyle(.treeGreen)
//            }
//        }
//    }
//}
//
//// MARK: - Preview
//
//#Preview {
//    TreehouseCreatingSuccessView()
//}
