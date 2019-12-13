//
//  AddPersonView.swift
//  NameFaceMILSETONE
//
//  Created by roblack on 12/10/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import CoreData
import SwiftUI
import CoreLocation
import MapKit

struct AddPersonView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State var currentUserLocation: CLLocationCoordinate2D?
    
    @State private var personName = ""
    @State private var showingImagePicker = false
    @State private var importedImage: UIImage?
    @State private var image: Image?
    @State private var currentUserImgID: UUID?
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
                    self.loadUserImage(uuid: person!.imgID!)
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
                    self.person?.imgID = self.currentUserImgID
                    self.person?.name = self.personName
                    FileManager().savePhoto(self.importedImage!, withName: self.person!.imgID!.uuidString)
                } else {
                    let newPerson = Person(context: self.moc)
                    newPerson.imgID = UUID()
                    newPerson.name = self.personName
                    FileManager().savePhoto(self.importedImage!, withName: newPerson.imgID!.uuidString)
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
            
            Group {
                UserMapView(currentUserLocation: currentUserLocation ?? CLLocationCoordinate2D(latitude: 51.5, longitude: 0.13))
            }
            
            }.onAppear(perform: loadUser)
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$importedImage)
        }
        
    }
    
    func loadUser() {
        if person != nil {
            self.importedImage = self.loadUIImage(uuid: self.person!.imgID!)
            currentUserImgID = person?.imgID ?? UUID()
            personName = person?.name ?? ""
            print(currentUserLocation)
        }
    }
    
    func loadImage() {
        guard let inputImage = importedImage else { return }
        image = Image(uiImage: inputImage)
    }
    
    func loadUIImage(uuid: UUID) -> UIImage {
        return FileManager().loadPhoto(withName: uuid.uuidString)!
    }
    
    func loadUserImage(uuid: UUID) -> Image {
        if let uiImage = FileManager().loadPhoto(withName: uuid.uuidString){
            return Image(uiImage: uiImage)
        } else {
            return Image(systemName: "person.crop.circle.fill")
        }
    }
}
