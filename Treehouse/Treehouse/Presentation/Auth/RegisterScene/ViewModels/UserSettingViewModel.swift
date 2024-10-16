//
//  UserSettingViewModel.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 5/12/24.
//

import Foundation
import Observation
import SwiftUI
import FirebaseAuth
import FirebaseCrashlytics

enum UserAuthentication {
    case notInvitation
    case notSignUp
    case comebackUser
    case error
}

enum RegisterType {
    case registerUser // 일반적인 회원가입
    case registerTreehouse // treehouse 를 만들고 회원가입
}

enum PhoneNumberAuthState {
    case error(title: String)
    case success
    
    var title: String {
        switch self {
        case .success:
            return "인증에 성공했습니다"
        case .error(let title):
            return title
        }
    }
}

protocol BaseViewModel: AnyObject {}

@Observable
final class UserSettingViewModel: BaseViewModel {
    
    var isSignUp = false
    
    // MARK: - UserSetting Property
    
    var userName: String = ""
    var userId: Int?
    var memberId: Int?
    var memberName: String?
    var bio: String?
    var profileImageURL: String?
    var phoneNumber: String?
    var treehouseId: Int?

    var errorMessage: String?
    
    // MARK: - Invitation Property
    
    var invitationId: Int?
    var treehouseName: String = ""
    var invitedMember: String = ""
    var memberNum: Int = 0
    var memberProfileImages: [String?] = []
    
    var profileImage: UIImage?
    var senderProfileImageUrl = ""
    
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
    
    // MARK: - Firebase Authentication
    
    @ObservationIgnored
    var verificationID: String?
    
    @ObservationIgnored
    var verificationCode: String?
    
    var isVerificationID = false
    var isCheckVerification = false
    var isCallCehckVerification = false
    
    var isSendAuthMessageState: PhoneNumberAuthState?
    var isAuthAlert: Bool = false
 
    var errorKey: String = ""
    var errorValue: String = ""
    
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
    
    var registerType: RegisterType
    
    // MARK: - init
    
    init(checkNameUseCase: PostCheckNameUseCaseProtocol,
         registerUserUseCase: PostRegisterUserUseCaseProtocol,
         registerTreeMemberUseCase: PostRegisterTreeMemberUseCaseProtocol,
         acceptInvitationTreeMemberUseCase: PostAcceptInvitationTreeMemberUseCaseProtocol,
         checkInvitationsUseCase: GetCheckInvitationsUseCaseProtocol,
         presignedURLUseCase: PostPresignedURLUseCaseProtocol,
         uploadImageToAWSUseCase: PutUploadImageToAWSUseCaseProtocol,
         registerType: RegisterType
    ) {
        self.checkUserNameUseCase = checkNameUseCase
        self.registerUserUseCase = registerUserUseCase
        self.registerTreeMemberUseCase = registerTreeMemberUseCase
        self.acceptInvitationTreeMemberUseCase = acceptInvitationTreeMemberUseCase
        self.checkInvitationsUseCase = checkInvitationsUseCase
        self.presignedURLUseCase = presignedURLUseCase
        self.uploadImageToAWSUseCase = uploadImageToAWSUseCase
        self.registerType = registerType
        
        print("Init UserSettingViewModel")
    }
    
    deinit {
        print("Deinit UserSettingViewModel")
    }
    
    func createUserInfoData() -> UserInfoData? {
        guard let userId = userId,
              let treehouseId = treehouseId,
              let profileImage = accessUrlImage.first,
              let treehouseData = createMemberInfoData() else {
            return nil
        }
        
        let userData = UserInfoData(userId: userId, userName: userName, profileImageUrl: profileImage, treehouses: [treehouseId], treehouseInfo: [treehouseData])
        return userData
    }
    
    func createMemberInfoData() -> TreehouseInfo? {
        guard let treehouseId = treehouseId,
              let memberId = memberId,
              let memberName = memberName,
              let bio = bio,
              let profileImage = accessUrlImage.first else {
            return nil
        }
        
        let url = URL(string: profileImage)
        
        let userData = TreehouseInfo(treehouseId: treehouseId, treehouseMemberId: memberId, treehouseName: memberName, bio: bio, profileImageUrl: url)
        return userData
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
        
        let imageUrl = accessUrlImage.first ?? ""
        
        let result = await registerTreeMemberUseCase.execute(registerType: registerType, requestDTO: PostRegisterTreeMemberRequestDTO(treehouseId: treehouseId, userName: userName, memberName: memberName, bio: bio, profileImageURL: imageUrl))
        
        switch result {
        case .success(let response):
            self.userId = response.userId
            self.memberId = response.memberId
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
                senderProfileImageUrl = $0.senderProfileImageUrl ?? ""
                invitationId = $0.invitationId
                treehouseName = $0.treehouseName
                invitedMember = $0.senderName
                memberNum = $0.treehouseSize
                memberProfileImages = $0.treehouseMemberProfileImages
            }
            
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
        
        guard let treehouseId = treehouseId,
                let imageDataSize = profileImage?.getImageBitSize() else {
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
        
        let result = await uploadImageToAWSUseCase.execute(presignedUrls: presignedUrlImage, uploadImages: [uploadImages])

        switch result {
        case .success(let response):
            response.forEach { data in
                isloadImageAWS = data.result
            }
            break
        case .failure(let error):
            await MainActor.run {
                self.errorMessage = error.localizedDescription
            }
            isloadImageAWS = false
        }
    }
}

// MARK: - Firebase Authentication UserPhoneNum Extension


extension UserSettingViewModel {
    func certificationPhoneNumber() async -> Bool {
        guard let phoneNumber = phoneNumber else { return false }
        
        let fixPhoneNumber = "+82" + phoneNumber.dropFirst(1)

        do {
            self.verificationID = try await PhoneAuthProvider.provider().verifyPhoneNumber(fixPhoneNumber, uiDelegate: nil)
            
            // 서버 통신 성공, verificationID를 저장
            if let verificationID = verificationID {
                // Crashlytics 로그 추가
                Crashlytics.crashlytics().log("Phone authentication successful")
                
                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                print("verificationID 저장 완료")
            }
            
            await MainActor.run {
                self.isVerificationID = true
            }
            
            return true
        } catch let error as NSError {
            // Crashlytics 로그 추가
            Crashlytics.crashlytics().log("Phone authentication failed")
            Crashlytics.crashlytics().setCustomValue(fixPhoneNumber, forKey: "phone_number")
            Crashlytics.crashlytics().setCustomValue(error.localizedDescription, forKey: "error_message")

            // userInfo의 내용을 그대로 저장
            let userInfo = error.userInfo
            
            print(error.domain)
            print(error.code)
            
            switch error.code {
            case 17010:
                isSendAuthMessageState = .error(title: "인증 시도 횟수가 초과되었습니다\n일정 시간 후 다시 시도해주세요")
            default:
                isSendAuthMessageState = .error(title: "알 수 없는 오류가 발생했습니다\n잠시 후 시도해주세요")
            }
            
       
            for (key, value) in userInfo {
                print("Key:\(key), Value: \(value)")
                Crashlytics.crashlytics().setCustomValue(value, forKey: key)
            }

            await MainActor.run {
                isAuthAlert = true
                print(error.userInfo)
                errorMessage = "인증 실패: \(error.localizedDescription)"
            }
            
            return false
        }
    }
    
    func checkVerificationCode() async {
        guard let verificationCode = verificationCode else { return }
        
        guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") else {
                print("No verification ID found.")
                return
            }
        
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: verificationCode
        )
        
        do {
            let authResult = try await Auth.auth().signIn(with: credential)
            
            let user = authResult.user // 인증된 사용자 정보
            print("인증 성공! 사용자 ID: \(user.uid)")
            
            await MainActor.run {
                isSendAuthMessageState = .success
                isAuthAlert = true
                self.isCallCehckVerification = true
                self.isCheckVerification = true
            }
            
        } catch {
            await MainActor.run {
                self.isCheckVerification = false
                self.isCallCehckVerification = true
                errorMessage = "인증 실패: \(error.localizedDescription)"
            }
        }
    }
}
