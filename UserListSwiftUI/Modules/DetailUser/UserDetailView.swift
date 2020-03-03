//
//  UserDetailView.swift
//  UserListSwiftUI
//
//  Created by Yurii Chudnovets on 27.01.2020.
//  Copyright © 2020 Yurii Chudnovets. All rights reserved.
//

import SwiftUI

struct UserDetailView: View {
    
    @ObservedObject var viewModel: UserDetailViewModel
    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false
    
    var body: some View {
        List {
            Section {
                AvatarView(urlImageModel: viewModel.urlImageModel,
                           showingImagePicker: $showingImagePicker)
                    .frame(height: 202)
            }
            Section {
                ParameterView(viewModel: viewModel.paramaterViewModels[0])
                ParameterView(viewModel: viewModel.paramaterViewModels[1])
                ParameterView(viewModel: viewModel.paramaterViewModels[2])
                ParameterView(viewModel: viewModel.paramaterViewModels[3])
            }
        }
        .buttonStyle(PlainButtonStyle())
        .gesture(DragGesture().onChanged {_ in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)})
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Edit profile")
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
        .navigationBarItems(trailing:
            Button("Save") {
                self.viewModel.apply(.onSave)
            }
        )
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        viewModel.urlImageModel.image = inputImage
    }
    
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(viewModel: UserDetailViewModel(user: User.example))
    }
}
