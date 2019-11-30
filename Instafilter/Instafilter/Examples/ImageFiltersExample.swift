//
//  ImageFiltersExample.swift
//  Instafilter
//
//  Created by roblack on 11/29/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ImageFiltersExample: View {
    @State private var image: Image?

        var body: some View {
            VStack {
                image?
                    .resizable()
                    .scaledToFit()
            }
            .onAppear(perform: loadImage)
        }

        func loadImage() {
            guard let inputImage = UIImage(named: "Example") else { return }
            let beginImage = CIImage(image: inputImage)
            
            let context = CIContext()
            let currentFilter = CIFilter.pixellate()
            
            currentFilter.inputImage = beginImage
            currentFilter.scale = 100
            
            // get a CIImage from our filter or exit if that fails
            guard let outputImage = currentFilter.outputImage else { return }

            // attempt to get a CGImage from our CIImage
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                // convert that to a UIImage
                let uiImage = UIImage(cgImage: cgimg)

                // and convert that to a SwiftUI image
                image = Image(uiImage: uiImage)
        }
    }
}

struct ImageFiltersExample_Previews: PreviewProvider {
    static var previews: some View {
        ImageFiltersExample()
    }
}
