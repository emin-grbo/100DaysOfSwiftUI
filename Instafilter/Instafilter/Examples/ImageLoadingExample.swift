//
//  ImageLoadingExample.swift
//  Instafilter
//
//  Created by roblack on 11/29/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct ImageLoadingExample: View {
    
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()

            Button("Select Image") {
               self.showingImagePicker = true
            }
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePickerExample(image: self.$inputImage)
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        let imageSaver = ImageSaverExample()
        imageSaver.writeToPhotoAlbum(image: inputImage)
    }
    
}

class ImageSaverExample: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }

    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
    }
}

struct ImageLoadingExample_Previews: PreviewProvider {
    static var previews: some View {
        ImageLoadingExample()
    }
}
