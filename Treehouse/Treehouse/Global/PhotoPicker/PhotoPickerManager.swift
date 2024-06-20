//
//  PhotoPickerManager.swift
//  Treehouse
//
//  Created by 윤영서 on 6/3/24.
//

import SwiftUI
import PhotosUI

enum PhotoType {
    case profileImage
    case postImage
    case notImage
    
    var imageSize: CGSize {
        switch self {
        case .profileImage:
            return CGSize(width: SizeLiterals.Screen.screenWidth * 130.24 / 393, height: SizeLiterals.Screen.screenHeight * 130.24 / 852)
        case .postImage:
            return CGSize(width: SizeLiterals.Screen.screenWidth * 54 / 393, height: SizeLiterals.Screen.screenHeight * 54 / 852)
        case .notImage:
            return CGSize(width: SizeLiterals.Screen.screenWidth * 70 / 393, height: SizeLiterals.Screen.screenHeight * 70 / 852)
        }
    }
}

class PhotoPickerManager: ObservableObject {
    @Published var selectedImages: [UIImage] = []
    
    private var type: PhotoType?
    
    init(type: PhotoType) {
        self.type = type
    }
    
    func makeBinding() -> Binding<[UIImage]> {
        Binding(
            get: { self.selectedImages },
            set: { self.selectedImages = $0 }
        )
    }
    
    func presentPhotoPicker(selectionLimit: Int = 10) -> PhotoPicker {
        PhotoPicker(selectedImages: makeBinding(), selectionLimit: selectionLimit, type: type ?? .notImage)
    }
}

struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var selectedImages: [UIImage]
    let selectionLimit: Int
    let type: PhotoType
    
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
        Coordinator(self, type: type)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: PhotoPicker
        let type: PhotoType
        
        init(_ parent: PhotoPicker, type: PhotoType) {
            self.parent = parent
            self.type = type
        }
        
        func resizeImage(image: UIImage) async -> UIImage {
            guard let imageData = image.pngData() else { return image }
            
            if let downsampledImage = UIImage.downsample(imageData: imageData, to: self.type.imageSize, scale: UIScreen.main.scale) {
                return downsampledImage
            } else {
                return image
            }
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
                } else {
                    group.leave()
                }
            }
            
            group.notify(queue: DispatchQueue.main) {
                self.parent.selectedImages = images
            }
        }
    }
}
