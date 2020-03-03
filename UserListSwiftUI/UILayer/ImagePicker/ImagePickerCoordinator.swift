//
//  ImagePickerCoordinator.swift
//  UserListSwiftUI
//
//  Created by Yurii Chudnovets on 03.03.2020.
//  Copyright © 2020 Yurii Chudnovets. All rights reserved.
//

import UIKit

class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var parent: ImagePicker

    init(_ parent: ImagePicker) {
        self.parent = parent
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let uiImage = info[.originalImage] as? UIImage {
            parent.image = uiImage
        }

        parent.presentationMode.wrappedValue.dismiss()
    }
    
}
