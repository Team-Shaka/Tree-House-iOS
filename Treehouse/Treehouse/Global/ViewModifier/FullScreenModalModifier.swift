//
//  FullScreenModalModifier.swift
//  Treehouse
//
//  Created by 윤영서 on 6/18/24.
//

import SwiftUI

struct FullScreenModalModifier<ModalContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    let modalContent: ModalContent

    func body(content: Content) -> some View {
        content
            .background(
                FullScreenModal(isPresented: $isPresented, modalContent: modalContent)
            )
    }
}

extension View {
    func fullScreenModal<ModalContent: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder modalContent: () -> ModalContent
    ) -> some View {
        self.modifier(FullScreenModalModifier(isPresented: isPresented, modalContent: modalContent()))
    }
}

struct FullScreenModal<ModalContent: View>: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    let modalContent: ModalContent

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .clear
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if isPresented {
            if uiViewController.presentedViewController == nil {
                let hostingController = UIHostingController(rootView: modalContent)
                hostingController.modalPresentationStyle = .overFullScreen
                hostingController.modalTransitionStyle = .crossDissolve
                uiViewController.present(hostingController, animated: false, completion: nil)
            }
        } else {
            uiViewController.dismiss(animated: true, completion: nil)
        }
    }
}
