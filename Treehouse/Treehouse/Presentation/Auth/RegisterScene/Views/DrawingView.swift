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
            let bothEndsHeight = SizeLiterals.Screen.screenHeight * (145)/852
            let centerHeight = SizeLiterals.Screen.screenHeight * (56)/852
            let safeAreaHeight = self.safeAreaHeight()
            
            path.move(to: CGPoint(x: 0, y: SizeLiterals.Screen.screenHeight - bothEndsHeight - safeAreaHeight))
            path.addLine(to: CGPoint(x: 0, y: SizeLiterals.Screen.screenHeight))
            path.addLine(to: CGPoint(x: SizeLiterals.Screen.screenWidth, y: SizeLiterals.Screen.screenHeight))
            path.addLine(to: CGPoint(x: SizeLiterals.Screen.screenWidth, y: SizeLiterals.Screen.screenHeight - bothEndsHeight - safeAreaHeight))
            path.addLine(to: CGPoint(x: SizeLiterals.Screen.screenWidth / 2, y: SizeLiterals.Screen.screenHeight - centerHeight - safeAreaHeight))
            path.closeSubpath()
        }
        .fill(.treeGreen)
    }
}

#Preview {
    DrawingView()
}
