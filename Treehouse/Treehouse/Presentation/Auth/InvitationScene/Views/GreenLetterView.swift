//
//  GreenLetterView.swift
//  Treehouse
//
//  Created by 티모시 킴 on 4/17/24.
//

import SwiftUI

struct GreenLetterView: View {
    
    // MARK: - View
    
    var body: some View {
        Path { path in
            path.move(to: .zero)
            path.addLine(to: CGPoint(x: 0, y: 121))
            path.addQuadCurve(to: CGPoint(x: 15, y: 136), control: CGPoint(x: 0, y: 136))
            path.addLine(to: CGPoint(x: 346, y: 136))
            path.addQuadCurve(to: CGPoint(x: 361, y: 121), control: CGPoint(x: 361, y: 136))
            path.addLine(to: CGPoint(x: 361, y: 0))
            path.addLine(to: CGPoint(x: 361 / 2, y: 95))
            path.closeSubpath()
        }
        .fill(.treeGreen)
        .frame(width: 361, height: 136)
        
    }

}

// MARK: - Preview

#Preview {
    GreenLetterView()
}
