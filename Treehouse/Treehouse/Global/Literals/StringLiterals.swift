//
//  StringLiterals.swift
//  Treehouse
//
//  Created by 티모시 킴 on 4/7/24.
//

import Foundation

enum StringLiterals {
    enum Register {
        static let buttonTitle1 = "인증번호 보내기"
        static let buttonTitle2 = "인증하기"
        static let buttonTitle3 = "돌아가기"
        static let buttonTitle4 = "로그인"
        static let buttonTitle5 = "내 프로필 보러가기"
        static let buttonTitle6 = "좋아요!"
        static let buttonTitle7 = "거절하기"
        static let buttonTitle8 = "초대 수락하기"
        static let buttonTitle9 = "프로필 사진 설정하러 가기"
        static let buttonTitle10 = "바이오 설정하러 가기"
        static let buttonTitle11 = "내 프로필 보러가기"
        static let buttonTitle12 = "다시 작성할게요"
        static let buttonTitle13 = "사진 변경하기"
        
        static let guidanceTitle1 = "당신의 전화번호는 기기에서 암호화되어 서버로 전송됩니다. 트리하우스는 당신의 개인정보를 소중하게 여기며, 당신의 전화번호는 저희가 확인할 수 없습니다."
        static let guidanceTitle2 = "트리하우스는 원활한 서비스 제공과\n내부 커뮤니티 유지를 위해 초대된 전화번호에\n대해서만 가입이 가능하도록 제공됩니다."
        static let guidanceTitle3 = "유저 아이디는 한번 정해지면 바꿀 수 없습니다. 가입되는 모든 트리하우스에서 보이는 아이디이니 꼭 신중히 작성해주세요."
        static let guidanceTitle4 = "앞의 멤버 이름은 당신이 트리하우스 커뮤니티에\n소속될 때마다 새로 만들거니 조금만 기다려주세요!"
        static let guidanceTitle5 = "가입이 가능하도록 초대된 첫 번째 초대장은 거부할 수 없어요. 앞으로 받을 다른 초대장은 거부할 수 있어요."
        static let guidanceTitle6 = "멤버 이름은 추후에 바꿀 수 있어요."
        static let guidanceTitle7 = "이 사진은 이 트리하우스 멤버에게만 보여요."
        static let guidanceTitle8 = "이 바이오는 트리하우스 멤버에게만 보여요."
        static let guidacneTitel9 = "멤버이름과 바이오는 곧 설정할 예정이에요."
        static let guidacneTitle10 = "멤버 이름은 추후에 바꿀 수 있어요."
        
        static let indicatorTitle1 = "*전화번호 구조가 맞지 않습니다."
        static let indicatorTitle2 = "*인증번호가 맞지 않습니다."
        static let indicatorTitle3 = "*아이디 양식과 맞지 않습니다.(숫자, 소문자 영어, _, . 사용 가능)"
        static let indicatorTitle4 = "*중복된 아이디입니다. 다른 아이디를 입력해주세요."
        static let indicatorTitle5 = "*글자수가 맞지 않습니다(4자 이상, 20자 이하)"
        static let indicatorTitle6 = "*중복된 이름입니다. 다른 트리하우스 이름를 입력해주세요."
        static let indicatorTitle7 = "*글자수가 맞지 않습니다(2자 이상, 20자 이하)"
        
        static let placeholderTitle1 = "전화번호 입력"
        static let placeholderTitle2 = "유저아이디 입력"
        static let placeholderTitle3 = "멤버 이름 입력"
        static let placeholderTitle4 = "바이오 입력"
        
        static let registerTitle1 = "만나서 반가워요!\n가입과 로그인을 위해\n전화번호를 입력해주세요!"
        static let registerTitle2 = "죄송합니다.\n아직 초대받지 못한 전화번호입니다."
        static let registerTitle3 = "돌아오셨군요!\n아래 버튼을 눌러 트리하우스에\n입장해주세요!"
        static let registerTitle4 = "새로오셨군요, 반가워요!\n당신의 유저 아이디를 작성해주세요."
        static let registerTitle5 = "축하합니다!\n이제 받은 초대장을 볼까요?"
        static let registerTitle6 = "당신의 멤버 이름을 작성해주세요."
        static let registerTitle7 = "당신의 프로필 사진을 설정해주세요!"
        static let registerTitle8 = "마지막으로 짧은 바이오를\n작성해주세요."
        static let registerTitle9 = "님 반갑습니다!\n아마 다른 트리 멤버에게는\n당신이 이렇게 보일거에요!"
        static let registerTitle10 = "멋진데요!\n이 트리하우스에서\n당신은 이렇게 보일거에요!"
        
        static let etcTitle1 = "추후 누구나 가입이 가능하도록\n변경할 예정이니 기다려주세요!"
        
        static let navigationTitle1 = "멤버 프로필 설정"
    }
    
    enum Invitation {
        static let buttonTitle1 = "확인하기 >"
        static let buttonTitle2 = "초대하기"
        
        static let guidanceTitle1 = "가진 초대장을 소모해서 친구를 트리하우스에\n초대할 수 있어요!"
        static let guidanceTitle2 = "만 더 채우면 초대장 한 장을 받아요."
        
        static let placeholderTitle1 = "전화번호 검색"
        
        static let sectionTitle1 = "새로운 초대"
        static let sectionTitle2 = "초대장 보내기"
        
        static let tooltipTitle1 = "게시글, 댓글 작성 등\n활발한 활동을 하면 그래프가 늘어나요!"
    }
    
    enum Notification {
        static let notificationTitle1 = "아직 받은 알림이 없어요."
    }
    
    enum Profile {
        static let buttonLabel1 = "프로필 편집하기"
        static let buttonLabel2 = "브랜치 보기"
        static let buttonLabel3 = "다른 트리에 초대하기"
        
        static let profileBranchCountTitle = "총 Branch"
        static let profileTreeHouseCountTitle = "소속 트리하우스"
        static let profileRootTitle = "나로부터"
    }
    
    enum MemberProfile {
        static let bottomSheetLabel1 = "초대하기"
        static let bottomSheetLabel2 = "초대할 트리하우스 선택"
    }
    
    enum EditProfile {
        static let editProfileTitle = "멤버 프로필 변경"
    }
    
    enum CreateTreehouse {
        static let createTreehouseTitle1 = "아직 상대가 초대장을 수락하지 않았어요.\n수락이 완료되면 새로운 트리하우스가 개설됩니다!"
        static let createTreehouseTitle2 = "15일 안에 수락하지 않을 경우 \n트리하우스 개설이 취소됩니다."
        static let createTreehouseTitle3 = "새롭게 만든 트리하우스예요. \n어떤가요?"
        static let createTreehouseTitle4 = "새로운 트리하우스의 트리홀 이름을 정해주세요!"
        static let createTreehouseTitle5 = "트리홀은 트리하우스의 음성 채팅 채널로, \n언제 어디서든 이야기를 나눌 수 있는 곳이에요!"
    }
}
