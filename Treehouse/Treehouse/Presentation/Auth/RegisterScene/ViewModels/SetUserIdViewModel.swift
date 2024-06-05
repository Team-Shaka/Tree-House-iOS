//
//  SetUserIdViewModel.swift
//  Treehouse
//
//  Created by 윤영서 on 5/17/24.
//

import Observation
import Foundation

@Observable
class SetUserIdViewModel {
    var isUserNameDuplicated: Bool = false
    var errorMessage: String? = nil
    private var registerService: RegisterService
    
    init(registerService: RegisterService = RegisterService()) {
        self.registerService = registerService
    }
    
    func checkUserName(userName: String) async {
        do {
            let response = try await registerService.postCheckName(userName: userName)
            
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
}
