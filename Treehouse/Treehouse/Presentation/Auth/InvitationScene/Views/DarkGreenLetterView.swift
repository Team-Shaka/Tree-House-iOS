//
//  DarkGreenLetterView.swift
//  Treehouse
//
//  Created by 티모시 킴 on 4/22/24.
//

import SwiftUI

struct DarkGreenLetterView: View {
    
    // MARK: - Property
    
    let drawingWidth1 = SizeLiterals.Screen.screenWidth * 361/393
    let drawingWidth2 = SizeLiterals.Screen.screenWidth * 15/393
    let drawingWidth3 = SizeLiterals.Screen.screenWidth * 346/393
    
    let drawingHeight1 = SizeLiterals.Screen.screenHeight * 136/852
    let drawingHeight2 = SizeLiterals.Screen.screenHeight * 121/852
    
    // MARK: - View
    
    var body: some View {
        Path { path in
            path.move(to: .zero)
            path.addLine(to: CGPoint(x: 0, y: drawingHeight2))
            path.addQuadCurve(to: CGPoint(x: drawingWidth2, y: drawingHeight1), control: CGPoint(x: 0, y: drawingHeight1))
            path.addLine(to: CGPoint(x: drawingWidth3, y: drawingHeight1))
            path.addQuadCurve(to: CGPoint(x: drawingWidth1, y: drawingHeight2), control: CGPoint(x: drawingWidth1, y: drawingHeight1))
            path.addLine(to: CGPoint(x: drawingWidth1, y: 0))
            path.closeSubpath()
        }
        .fill(.treeDarkgreen)
        .frame(width: drawingWidth1, height: drawingHeight1)
        
    }

}

// MARK: - Preview

#Preview {
    DarkGreenLetterView()
}
