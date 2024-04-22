//
//  DrawingView.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 4/13/24.
//

import SwiftUI

struct DrawingView: View {
    var body: some View {
        Path { path in
            let startHeight = SizeLiterals.Screen.screenHeight * (139)/852
            let centerHeight = SizeLiterals.Screen.screenHeight * (89)/852
            
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: startHeight))
            path.addLine(to: CGPoint(x: SizeLiterals.Screen.screenWidth, y: startHeight))
            path.addLine(to: CGPoint(x: SizeLiterals.Screen.screenWidth, y: 0))
            path.addLine(to: CGPoint(x: SizeLiterals.Screen.screenWidth / 2, y: centerHeight))
            path.closeSubpath()
        }
        .fill(.treeGreen)
        .frame(width: SizeLiterals.Screen.screenWidth, height: SizeLiterals.Screen.screenHeight * 139 / 852)
    }
}

#Preview {
    DrawingView()
}
