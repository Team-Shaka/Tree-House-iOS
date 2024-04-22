//
//  ReceivedInvitationView.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 4/17/24.
//

import SwiftUI

enum ReceivedInvitationViewStateType {
    case loading
    case unInvitation
    case invitation
}

struct ReceivedInvitationView: View {
    
    // MARK: - Property
    
    var viewModel = ReceivedInvitationViewModel()
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            NavigationStack {
                contentView(viewState: viewModel.viewState)
                    .padding(.top, 14)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                                // MARK: - TODO
                            }) {
                                HStack {
                                    Image(systemName: "chevron.left")
                                        .foregroundColor(.black)
                                        .frame(width: 24, height: 24)
                                    
                                    Text("받은 초대장")
                                        .fontWithLineHeight(fontLevel: .heading3)
                                        .foregroundStyle(.grayscaleBlack)
                                }
                            }
                            .padding(.top, 11)
                        }
                    }.background(.grayscaleWhite)
            }
            
            if viewModel.presentAlert {
                if let tapInvitationData = viewModel.tapInvitationData {
                    InvitationAlertView(invitationType: .received,
                                        treehouseName: tapInvitationData.treehouseName,
                                        invitedMember: tapInvitationData.senderName,
                                        memberNum: tapInvitationData.treehouseCount,
                                        leftButtonAction:  {
                                            viewModel.presentAlert.toggle()
                                        },
                                        rightButtonAction: {
                                                // MARK: - TODO
                                        },
                                        cancelButtonAction: {
                                            viewModel.presentAlert.toggle()
                                        })
                }
            }
        }
    }
}

// MARK: - ViewBuilder

private extension ReceivedInvitationView {
    @ViewBuilder
    func contentView(viewState: ReceivedInvitationViewStateType) -> some View {
        switch viewState {
        case .loading:
            EmptyView()
        case .unInvitation:
            EmptyReceivedInvitationView
        case .invitation:
            ReceivedInvitationView
        }
    }
    
    @ViewBuilder
    var EmptyReceivedInvitationView: some View {
        VStack(spacing: 12) {
            Spacer(minLength: SizeLiterals.Screen.screenHeight * 246 / 852)
            
            Image(.imgInvitationempty)
            
            Text("아직 받은 초대장이 없어요")
                .fontWithLineHeight(fontLevel: .heading4)
                .foregroundStyle(.gray5)
            
            Spacer(minLength: SizeLiterals.Screen.screenHeight * 327 / 852)
        }
    }
    
    @ViewBuilder
    var ReceivedInvitationView: some View {
        List {
            ForEach(viewModel.receivedInvitations, id: \.self) { data in
                ReceivedInvitationRowView(image: data.senderProfileImageUrl,
                                          title: data.treehouseName,
                                          count: data.treehouseCount)
                .onTapGesture(perform: {
                    viewModel.tapInvitationData = data
                    viewModel.presentAlert.toggle()
                    print(data.treehouseName)
                })
            }
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowSeparator(.hidden)
        }
        .listStyle(PlainListStyle())
        .background(.grayscaleWhite)
        .scrollContentBackground(.hidden)
    }
}

// MARK: - Preview

#Preview {
    ReceivedInvitationView()
}
