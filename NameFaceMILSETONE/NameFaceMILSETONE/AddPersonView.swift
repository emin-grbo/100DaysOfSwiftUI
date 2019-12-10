//
//  AddPersonView.swift
//  NameFaceMILSETONE
//
//  Created by roblack on 12/10/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import CoreData
import SwiftUI

struct AddPersonView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var personName = ""
    @State private var showingImagePicker = false
    @State private var importedImage: UIImage?
    @State private var image: Image?
    @State private var currentUserImgID: String?
    @State var person: Person?
    
    var body: some View {
        VStack {
            if person != nil {
             Text("Edit a friend")
                .font(.system(size: 40, weight: .bold))
                .padding()
            } else {
            Text("Add a new friend")
                .font(.system(size: 40, weight: .bold))
                .padding()
            }
            ZStack {
            Circle()
                .foregroundColor(.gray)
                .frame(width: 120, height: 120, alignment: .center)
                if image != nil {
                    image?
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120, alignment: .center)
                    .clipShape(Capsule())
                } else if person != nil {
                    self.loadUserImage(uuidString: person!.imgID!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120, alignment: .center)
                    .clipShape(Capsule())
                } else {
                    Text("Select\nImage")
                }
            }
            .onTapGesture {
                self.showingImagePicker.toggle()
            }
            TextField("Name", text: $personName)
                .padding()

            Button("SAVE") {
                if self.person != nil {
                    self.person?.name = self.personName
                    FileManager().savePhoto(self.importedImage!, withName: self.currentUserImgID!)
                } else {
                    let newPerson = Person(context: self.moc)
                    newPerson.imgID = UUID().uuidString
                    newPerson.name = self.personName
                    FileManager().savePhoto(self.importedImage!, withName: newPerson.imgID!)
                }
                try? self.moc.save()
                self.presentationMode.wrappedValue.dismiss()
            }
            .frame(width: 200, height: 50, alignment: .center)
            .foregroundColor(.white)
            .background(Color.black)
            .font(.system(size: 12, weight: .bold))
            .cornerRadius(25)
            Spacer()
            }.onAppear(perform: loadUser)
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$importedImage)
        }
    }
    
    func loadUser() {
        if person != nil {
            currentUserImgID = person?.imgID ?? ""
            personName = person?.name ?? ""
            importedImage = self.loadUIImage(uuidString: self.person!.imgID!)
        }
    }
    
    func loadImage() {
        guard let inputImage = importedImage else { return }
        image = Image(uiImage: inputImage)
    }
    
    func loadUIImage(uuidString: String) -> UIImage {
        return FileManager().loadPhoto(withName: uuidString)!
    }
    
    func loadUserImage(uuidString: String) -> Image {
        if let uiImage = FileManager().loadPhoto(withName: uuidString){
            return Image(uiImage: uiImage)
        } else {
            return Image(systemName: "person.crop.circle.fill")
        }
    }
}
