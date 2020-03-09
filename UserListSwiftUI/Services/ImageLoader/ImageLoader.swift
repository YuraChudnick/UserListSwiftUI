//
//  ImageLoader.swift
//  UserListSwiftUI
//
//  Created by yura on 09.03.2020.
//  Copyright © 2020 Yurii Chudnovets. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    
    private var cancelable: AnyCancellable?
    
    @Published var image: UIImage?
    private let url: URL?
    private var cancellable: AnyCancellable?
    private var cache: ImageCache?
    private(set) var isLoading = false
    private static let imageProcessingQueue = DispatchQueue(label: "image-processing")

    init(url: URL?, cache: ImageCache? = nil) {
        self.url = url
        self.cache = cache
        bindInput()
    }
    
    private func bindInput() {
        cancelable = $image.sink(receiveValue: { [weak self] (newImage) in
            self?.cache(newImage)
        })
    }
    
    func load() {
        guard let url = url else { return }
        guard !isLoading else { return }
        if let image = cache?[url] {
            self.image = image
        } else {
            cancellable = URLSession.shared.dataTaskPublisher(for: url)
                .subscribe(on: Self.imageProcessingQueue)
                .map { UIImage(data: $0.data) }
                .replaceError(with: nil)
                .handleEvents(receiveSubscription: { [unowned self] _ in self.onStart() },
                              //receiveOutput: { [unowned self] in self.cache($0) },
                              receiveCompletion: { [unowned self] _ in self.onFinish() },
                              receiveCancel: { [unowned self] in self.onFinish() })
                .receive(on: DispatchQueue.main)
                .assign(to: \.image, on: self)
        }
    }
    
    private func onStart() {
        isLoading = true
    }
    
    private func onFinish() {
        isLoading = false
    }
    
    func cache(_ image: UIImage?) {
        guard let url = url else { return }
        image.map { cache?[url] = $0 }
    }
    
    func cancel() {
        cancellable?.cancel()
    }
    
}
