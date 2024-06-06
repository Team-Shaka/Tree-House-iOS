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
    
    func presentPhotoPicker() -> PhotoPicker {
        PhotoPicker(selectedImages: makeBinding())
    }
}

struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var selectedImages: [UIImage]
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 10
        
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
            
            parent.selectedImages = []
            for result in results {
                if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, _ in
                        guard let self = self, let image = image as? UIImage else { return }
                        DispatchQueue.main.async {
                            self.parent.selectedImages.append(image)
                        }
                    }
                }
            }
        }
    }
}
