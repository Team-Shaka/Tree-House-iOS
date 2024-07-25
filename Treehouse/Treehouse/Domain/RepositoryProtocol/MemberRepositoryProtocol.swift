//
//  MemberRepositoryProtocol.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/24/24.
//

import Foundation

protocol MemberRepositoryProtocol {
    func getReadMemberInfo(treehouseId: Int, memberId: Int) async -> Result<ReadMemberInfoResponseEntity, NetworkError>
    func getReadMemberFeed(treehouseId: Int, memberId: Int) async -> Result<ReadMemberFeedResponseEntity, NetworkError>
    func getReadMyProfileInfo(treehouseId: Int) async -> Result<ReadMyProfileInfoResponseEntity, NetworkError>
    func patchModifyMyProfile(treehouseId: Int, requsetBody: PatchModifyMyProfileRequestDTO) async -> Result<PatchModifyMyProfileResponseEntity, NetworkError>
}
