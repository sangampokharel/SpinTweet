//
//  ImagePickerHandler.swift
//  SpinTweet
//
//  Created by sangam pokharel on 25/03/2024.
//

import Foundation
import SwiftUI

struct ImagePickerHandler: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Binding var isShowingImagePicker: Bool

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        imagePicker.sourceType = .photoLibrary
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePickerHandler

        init(parent: ImagePickerHandler) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }

            parent.isShowingImagePicker = false
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isShowingImagePicker = false
        }
    }
}
