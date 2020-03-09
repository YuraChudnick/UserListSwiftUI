//
//  ParameterView.swift
//  UserListSwiftUI
//
//  Created by Yurii Chudnovets on 02.03.2020.
//  Copyright © 2020 Yurii Chudnovets. All rights reserved.
//

import SwiftUI

struct ParameterView: View {
    
    @ObservedObject var viewModel: ParameterViewModel
    
    var body: some View {
        HStack {
            Text(viewModel.type.rawValue)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
            TextField("Enter " + viewModel.type.rawValue.lowercased(), text: $viewModel.value)
                .disableAutocorrection(true)
                .multilineTextAlignment(.trailing)
                .lineLimit(1)
                .font(Font.headline)
        }
    }
}

struct ParameterView_Previews: PreviewProvider {
    static var previews: some View {
        ParameterView(viewModel: ParameterViewModel(type: .firstName, value: "Yurii"))
    }
}
