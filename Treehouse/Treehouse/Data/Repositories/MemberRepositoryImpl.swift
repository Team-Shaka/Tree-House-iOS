//
//  MemberRepositoryImpl.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/24/24.
//

import Foundation

final class MemberRepositoryImpl: MemberRepositoryProtocol {
    private var memberService = MemberService()
    
    func getReadMemberInfo(treehouseId: Int, memberId: Int) async -> Result<ReadMemberInfoResponseEntity, NetworkError> {
        do {
            let response = try await memberService.getReadMemberInfo(treehouseId: treehouseId, memberId: memberId)
            return .success(response.toDomain())
        } catch let error as NetworkError {
            return .failure(error)
        } catch {
            return .failure(NetworkError.unknown)
        }
    }
    
    func getReadMemberFeed(treehouseId: Int, memberId: Int) async -> Result<ReadMemberFeedResponseEntity, NetworkError> {
//        do {
//            let response = try await memberService.getReadMemberFeed(treehouseId: treehouseId, memberId: memberId)
//            return .success(response.toDomain())
//        } catch let error as NetworkError {
//            return .failure(error)
//        } catch {
//            return .failure(NetworkError.unknown)
//        }
    }
    
    func getReadMyProfileInfo(treehouseId: Int) async -> Result<ReadMyProfileInfoResponseEntity, NetworkError> {
        do {
            let response = try await memberService.getReadMyProfileInfo(treehouseId: treehouseId)
            return .success(response.toDomain())
        } catch let error as NetworkError {
            return .failure(error)
        } catch {
            return .failure(NetworkError.unknown)
        }
    }
    
    func patchModifyMyProfile(treehouseId: Int, requsetBody: PatchModifyMyProfileRequestDTO) async -> Result<PatchModifyMyProfileResponseEntity, NetworkError> {
        do {
            let response = try await memberService.patchModifyMyProfile(treehouseId: treehouseId, requsetBody: requsetBody)
            return .success(response.toDomain())
        } catch let error as NetworkError {
            return .failure(error)
        } catch {
            return .failure(NetworkError.unknown)
        }
    }
}
