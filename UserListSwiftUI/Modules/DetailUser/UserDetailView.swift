//
//  UserDetailView.swift
//  UserListSwiftUI
//
//  Created by Yurii Chudnovets on 27.01.2020.
//  Copyright © 2020 Yurii Chudnovets. All rights reserved.
//

import SwiftUI

struct UserDetailView: View {
    
    @EnvironmentObject var viewModel: UserDetailViewModel
    @Binding var isActive: Bool
    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false
    
    var body: some View {
        List {
            Section {
                AvatarView(showingImagePicker: $showingImagePicker)
                    .environmentObject(viewModel)
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
                self.isActive = false
            }
        )
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        //viewModel.urlImageModel.image = inputImage
    }
    
}

struct UserDetailView_Previews: PreviewProvider {
        
    static var previews: some View {
        PreviewWrapper()
    }
    
    struct PreviewWrapper: View {
        @State(initialValue: false) var isActive: Bool
        
        var body: some View {
            UserDetailView(isActive: $isActive).environmentObject(UserDetailViewModel(user: User.example))
        }
    }
    
}
