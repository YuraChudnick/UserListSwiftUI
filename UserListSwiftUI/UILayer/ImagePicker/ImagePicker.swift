//
//  ImagePicker.swift
//  UserListSwiftUI
//
//  Created by Yurii Chudnovets on 03.03.2020.
//  Copyright © 2020 Yurii Chudnovets. All rights reserved.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }
    
    func makeCoordinator() -> ImagePickerCoordinator {
        ImagePickerCoordinator(self)
    }

}
