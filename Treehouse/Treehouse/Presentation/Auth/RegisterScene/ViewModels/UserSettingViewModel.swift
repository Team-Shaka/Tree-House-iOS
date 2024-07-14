//
//  UserSettingViewModel.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 5/12/24.
//

import Foundation
import Observation
import SwiftUI

enum UserAuthentication {
    case notInvitation
    case notSignUp
    case comebackUser
    case error
}

protocol BaseViewModel: AnyObject {}

@Observable
final class UserSettingViewModel: BaseViewModel {
    
    var isSignUp = false
    
    // MARK: - UserSetting Property
    
    var userName: String = ""
    var userId: Int?
    var memberName: String?
    var bio: String?
    var profileImageURL: String?
    var phoneNumber: String?
    var treehouseId: Int?

    var errorMessage: String? = nil {
        didSet {
            print(errorMessage)
        }
    }
    
    // MARK: - Invitation Property
    
    var invitationId: Int?
    var treehouseName: String = ""
    var invitedMember: String = ""
    var memberNum: Int = 0
    var memberProfileImages: [String?] = []
    
    var profileImage: [UIImage]?
    
    // MARK: - State Property
    
    var isPresentedView = false
    var isDuplicateID: Bool = false
    var isButtonEnabled: Bool = false
    var isUserNameDuplicated: Bool = false
    var isAuthentication: UserAuthentication = .error
    
    var isPresignedURL = false
    var isloadImageAWS = false
    
    // MARK: - image upload Property
    
    var presignedUrlImage = [String]()
    var accessUrlImage = [String]()
    
    // MARK: - UseCase Property
    
    @ObservationIgnored
    private let checkUserNameUseCase: PostCheckNameUseCaseProtocol
    
    @ObservationIgnored
    private let registerUserUseCase: PostRegisterUserUseCaseProtocol
    
    @ObservationIgnored
    private let registerTreeMemberUseCase: PostRegisterTreeMemberUseCaseProtocol
    
    @ObservationIgnored
    private let acceptInvitationTreeMemberUseCase: PostAcceptInvitationTreeMemberUseCaseProtocol
    
    @ObservationIgnored
    private let checkInvitationsUseCase: GetCheckInvitationsUseCaseProtocol
    
    @ObservationIgnored
    private let presignedURLUseCase: PostPresignedURLUseCaseProtocol
    
    @ObservationIgnored
    private let uploadImageToAWSUseCase: PutUploadImageToAWSUseCaseProtocol
    
    // MARK: - init
    
    init(checkNameUseCase: PostCheckNameUseCaseProtocol,
         registerUserUseCase: PostRegisterUserUseCaseProtocol,
         registerTreeMemberUseCase: PostRegisterTreeMemberUseCaseProtocol,
         acceptInvitationTreeMemberUseCase: PostAcceptInvitationTreeMemberUseCaseProtocol,
         checkInvitationsUseCase: GetCheckInvitationsUseCaseProtocol,
         presignedURLUseCase: PostPresignedURLUseCaseProtocol,
         uploadImageToAWSUseCase: PutUploadImageToAWSUseCaseProtocol
    ) {
        self.checkUserNameUseCase = checkNameUseCase
        self.registerUserUseCase = registerUserUseCase
        self.registerTreeMemberUseCase = registerTreeMemberUseCase
        self.acceptInvitationTreeMemberUseCase = acceptInvitationTreeMemberUseCase
        self.checkInvitationsUseCase = checkInvitationsUseCase
        self.presignedURLUseCase = presignedURLUseCase
        self.uploadImageToAWSUseCase = uploadImageToAWSUseCase
    }
    
    deinit {
        print("Deinit UserSettingViewModel")
    }
    
    func createUserInfoData() -> UserInfoData? {
        guard let userId = userId,
              let treehouseId = treehouseId,
              let memberName = memberName,
              let bio = bio else {
            return nil
        }
        
        if let profileImageData = profileImage?.first?.pngData() {
            return UserInfoData(userId: userId, userName: userName, treeMemberName: memberName, treehouseId: [treehouseId: treehouseName], bio: bio, profileImageData: profileImageData)
        } else {
            guard let imageData = UIImage(resource: .imgUser).pngData() else {
                return nil
            }
             
            return UserInfoData(userId: userId, userName: userName, treeMemberName: memberName, treehouseId: [treehouseId: treehouseName], bio: bio, profileImageData: imageData)
        }
    }
}

// MARK: - Register API Extension

extension UserSettingViewModel {
    func checkUserName(userName: String) async {
        do {
            let response = try await checkUserNameUseCase.excute(userName: userName)
            
            if response.isDuplicated == false {
                self.userName = userName
            }
            await MainActor.run {
                self.isUserNameDuplicated = response.isDuplicated
            }
        } catch let error as NetworkError {
            self.errorMessage = error.localizedDescription
        } catch {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func formatPhoneNumber(_ phoneNumber: String) -> String? {
        // 전화번호가 11자리인지 확인
        guard phoneNumber.count == 11 else {
            return nil
        }
        
        // 정규식 패턴을 사용하여 전화번호를 형식에 맞게 변환
        let pattern = "(\\d{3})(\\d{4})(\\d{4})"
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        
        let range = NSRange(location: 0, length: phoneNumber.count)
        
        if let match = regex?.firstMatch(in: phoneNumber, options: [], range: range) {
            let part1 = (phoneNumber as NSString).substring(with: match.range(at: 1))
            let part2 = (phoneNumber as NSString).substring(with: match.range(at: 2))
            let part3 = (phoneNumber as NSString).substring(with: match.range(at: 3))
            
            return "\(part1)-\(part2)-\(part3)"
        }
        
        return nil
    }
    
    func registerUser() async -> Bool {
        guard let phoneNumber = self.phoneNumber else {
            return false
        }
        
        let formattedPhoneNumber = formatPhoneNumber(phoneNumber)
        
        guard let formattedPhoneNumber = formattedPhoneNumber else { return false }
        
        print(formattedPhoneNumber)
        
        let result = await registerUserUseCase.execute(phoneNumber: formattedPhoneNumber, userName: self.userName)
        
        switch result {
        case .success(let response):
            KeychainHelper.shared.save(response.accessToken, for: Config.accessTokenKey)
            KeychainHelper.shared.save(response.refreshToken, for: Config.refreshTokenKey)
            
            return true
        case .failure(let error):
            await MainActor.run {
                self.errorMessage = error.localizedDescription
            }
            
            return false
        }
    }
    
    func registerTreeMember() async -> Bool {
        guard let treehouseId = treehouseId,
              let memberName = memberName,
              let bio = bio else {
            return false
        }
        
        let result = await registerTreeMemberUseCase.execute(requestDTO: PostRegisterTreeMemberRequestDTO(treehouseId: treehouseId, userName: userName, memberName: memberName, bio: bio, profileImageURL: accessUrlImage[0]))
        
        switch result {
        case .success(let response):
            self.userId = response.userId
            self.treehouseId = response.treehouseId
            
            return true
        case .failure(let error):
            await MainActor.run {
                self.errorMessage = error.localizedDescription
            }
            return false
        }
    }
    
    func acceptInvitationTreeMember(acceptDecision: Bool) async -> Bool {
        guard let invitationId = invitationId else { return false }
        
        let result = await acceptInvitationTreeMemberUseCase.execute(invitationId: invitationId, acceptDecision: acceptDecision)
        
        switch result {
        case .success(let response):
            // TODO: - invitationid 연결
            
            treehouseId = response.treehouseId
            return true
        case .failure(let error):
            await MainActor.run {
                self.errorMessage = error.localizedDescription
            }
            return false
        }
    }
}

// MARK: - Invitation API Extension

extension UserSettingViewModel {
    func checkInvitations() async {
        let result = await checkInvitationsUseCase.execute()
        
        switch result {
        case .success(let response):
            response.invitations.forEach {
                invitationId = $0.invitationId
                treehouseName = $0.treehouseName
                invitedMember = $0.senderName
                memberNum = $0.treehouseSize
                memberProfileImages = $0.treehouseMemberProfileImages
            }
            
//            await loadImagesAWS(images: memberProfileImages)
        case .failure(let error):
            await MainActor.run {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}

// MARK: - Feed API Extension
extension UserSettingViewModel {
    func presignedURL() async -> Bool {
        
        guard let treehouseId = treehouseId, let imageDataSize = profileImage?.first?.getImageBitSize()else {
            print("treehouseId")
            return false
        }

        let result = await presignedURLUseCase.execute(treehouseId: treehouseId, fileName: "\(userName)_ProfileImage", fileSize: imageDataSize)
        
        switch result {
        case .success(let response):
            presignedUrlImage.append(response.presignedUrl)
            accessUrlImage.append(response.accessUrl)
            
            isPresignedURL = true

            return true
        case .failure(let error):
            await MainActor.run {
                self.errorMessage = error.localizedDescription
            }
            
            return false
        }
    }
    
    func loadImageAWS() async {
        
        guard let uploadImages = profileImage else { return }
        
        let result = await uploadImageToAWSUseCase.execute(presignedUrls: presignedUrlImage, uploadImages: uploadImages)

        switch result {
        case .success(let response):
            break
        case .failure(let error):
            await MainActor.run {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
