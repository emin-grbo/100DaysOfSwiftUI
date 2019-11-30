//
//  ContentView.swift
//  Instafilter
//
//  Created by roblack on 11/28/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 0.5
    @State private var showingImagePicker = false
    @State private var showingFilterSheet = false
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    @State private var showError: Bool = false
    @State private var currentFilterName: String = "Sepia"
    
    @State var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()

    var body: some View {
        
        let intensity = Binding<Double>(
            get: {
                self.filterIntensity
            },
            set: {
                self.filterIntensity = $0
                self.applyProcessing()
            }
        )
        
        let radius = Binding<Double>(
            get: {
                self.filterRadius
        },
            set: {
                self.filterRadius = $0
                self.applyProcessing()
        }
        )
        
        return NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)

                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                    
                }
                .onTapGesture {
                    self.showingImagePicker = true
                }
                VStack{
                    HStack {
                        Text("Intensity")
                        Slider(value: intensity)
                    }.padding(.vertical)
                    HStack {
                        Text("Radius")
                        Slider(value: radius)
                    }.padding(.vertical)
                    
                }

                HStack {
                    Button(currentFilterName) {
                        self.showingFilterSheet = true
                    }

                    Spacer()

                    Button("Save") {
                        guard let processedImage = self.processedImage else {
                            self.showError.toggle()
                            return }
                        let imageSaver = ImageSaver()

                        imageSaver.successHandler = {
                            print("Success!")
                        }

                        imageSaver.errorHandler = {
                            self.showError.toggle()
                            print("Oops: \($0.localizedDescription)")
                        }
                        imageSaver.writeToPhotoAlbum(image: processedImage)
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
            .alert(isPresented: $showError) {
                Alert(title: Text("NO"), message: Text("That is not how this works."), dismissButton: .default(Text("Well, ok")))
            }
            .actionSheet(isPresented: $showingFilterSheet) {
                ActionSheet(title: Text("Select a filter"), buttons: [
                    .default(Text("Crystallize")) {
                        self.currentFilterName = "Crystallize"
                        self.setFilter(CIFilter.crystallize()) },
                    .default(Text("Edges")) {
                        self.currentFilterName = "Edges"
                        self.setFilter(CIFilter.edges()) },
                    .default(Text("Gaussian Blur")) {
                        self.currentFilterName = "Gaussian Blur"
                        self.setFilter(CIFilter.gaussianBlur()) },
                    .default(Text("Pixellate")) {
                        self.currentFilterName = "Pixellate"
                        self.setFilter(CIFilter.pixellate()) },
                    .default(Text("Sepia Tone")) {
                        self.currentFilterName = "Sepia Tone"
                        self.setFilter(CIFilter.sepiaTone()) },
                    .default(Text("Unsharp Mask")) {
                        self.currentFilterName = "Unsharp Mask"
                        self.setFilter(CIFilter.unsharpMask()) },
                    .default(Text("Vignette")) {
                        self.currentFilterName = "Vignette"
                        self.setFilter(CIFilter.vignette()) },
                    .cancel()
                ])
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }

        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
}

extension ContentView {
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        print(inputKeys)
        
        if inputKeys.contains(kCIInputIntensityKey)
        { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        
        if inputKeys.contains(kCIInputRadiusKey)
        { currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey) }
        
        if inputKeys.contains(kCIInputScaleKey)
        { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }

        guard let outputImage = currentFilter.outputImage else { return }

        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
    
}
