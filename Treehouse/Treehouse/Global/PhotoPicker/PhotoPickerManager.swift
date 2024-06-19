//
//  PhotoPickerManager.swift
//  Treehouse
//
//  Created by 윤영서 on 6/3/24.
//

import SwiftUI
import PhotosUI

class PhotoPickerManager: ObservableObject {
    @Published var selectedImages: [UIImage] = []
    
    func makeBinding() -> Binding<[UIImage]> {
        Binding(
            get: { self.selectedImages },
            set: { self.selectedImages = $0 }
        )
    }
    
    func presentPhotoPicker(selectionLimit: Int = 10) -> PhotoPicker {
        PhotoPicker(selectedImages: makeBinding(), selectionLimit: selectionLimit)
    }
}

struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var selectedImages: [UIImage]
    let selectionLimit: Int
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = selectionLimit
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: PhotoPicker
        
        init(_ parent: PhotoPicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true, completion: nil)
            
            var images: [UIImage] = []
            let group = DispatchGroup()
            
            for result in results {
                group.enter()
                if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    result.itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                        defer { group.leave() }
                        if let image = image as? UIImage {
                            images.append(image)
                        }
                    }
                }
            }
            
            group.notify(queue: DispatchQueue.main) {
                self.parent.selectedImages = images
            }
        }
    }
}
