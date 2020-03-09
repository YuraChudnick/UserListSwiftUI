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
    @Binding var inputImage: UIImage?
    @State private var showingImagePicker = false
    
    var body: some View {
        List {
            Section {
                AvatarView(newImage: $inputImage, showingImagePicker: $showingImagePicker)
                    .environmentObject(viewModel)
                    .frame(height: 202)
            }
            Section {
                ForEach(viewModel.paramaterViewModels, id: \.type) { vm in
                    ParameterView(viewModel: vm)
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
        .gesture(DragGesture().onChanged {_ in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)})
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Edit profile")
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: self.$inputImage)
        }
        .navigationBarItems(trailing:
            Button("Save") {
                self.viewModel.apply(.onSave)
                self.isActive = false
            }
        )
    }
    
}

struct UserDetailView_Previews: PreviewProvider {
        
    static var previews: some View {
        PreviewWrapper()
    }
    
    struct PreviewWrapper: View {
        @State(initialValue: false) var isActive: Bool
        @State(initialValue: nil) var newImage: UIImage?
        
        var body: some View {
            UserDetailView(isActive: $isActive, inputImage: $newImage).environmentObject(UserDetailViewModel(user: User.example))
        }
    }
    
}
