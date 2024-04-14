//
//  MaxLengthModifier.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 4/14/24.
//

import SwiftUI

// TextField 에서 최대 글자수를 정하기 위한 Modifier
struct MaxLengthModifier: ViewModifier {
    @Binding var text: String
    let maxLength: Int

    func body(content: Content) -> some View {
        content
            .onChange(of: text) { _, newValue in
                print(newValue)
                if newValue.count > maxLength {
                    text = String(newValue.prefix(maxLength))
                }
            }
    }
}
