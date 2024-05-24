//
//  ReceivedInvitationViewModel.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 4/22/24.
//

import Observation

@Observable
final class ReceivedInvitationViewModel: BaseViewModel {
    var viewState: ReceivedInvitationViewStateType = .invitation
    var presentAlert: Bool = false
    var tapInvitationData: ReceivedInvitationModel? = nil
    
    var receivedInvitations: [ReceivedInvitationModel] = [ReceivedInvitationModel(treehouseName: "점심팟", senderProfileImageUrl: "img_group", treehouseCount: 20),
                                                     ReceivedInvitationModel(treehouseName: "그룹이름", senderProfileImageUrl: "img_group", treehouseCount: 9),
                                                     ReceivedInvitationModel(treehouseName: "그룹이름", senderProfileImageUrl: "img_group", treehouseCount: 12),
                                                     ReceivedInvitationModel(treehouseName: "점심팟", senderProfileImageUrl: "img_group", treehouseCount: 20),
                                                     ReceivedInvitationModel(treehouseName: "그룹이름", senderProfileImageUrl: "img_group", treehouseCount: 9),
                                                     ReceivedInvitationModel(treehouseName: "그룹이름", senderProfileImageUrl: "img_group", treehouseCount: 12),
                                                     ReceivedInvitationModel(treehouseName: "점심팟", senderProfileImageUrl: "img_group", treehouseCount: 20),
                                                     ReceivedInvitationModel(treehouseName: "그룹이름", senderProfileImageUrl: "img_group", treehouseCount: 9),
                                                     ReceivedInvitationModel(treehouseName: "그룹이름", senderProfileImageUrl: "img_group", treehouseCount: 12)]
}
