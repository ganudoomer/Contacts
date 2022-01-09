//
//  AddView.swift
//  Contacts
//
//  Created by Sree on 08/01/22.
//

import SwiftUI
import MapKit

struct AddView: View {
    @Environment(\.dismiss) var dismiss
      @State  var  annotations = [
        Annotation(cordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275)),
    ]
    var onSave: (Contact)->Void
    let locationFetcher = LocationFetcher()
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    @State private var name: String = ""
    @State private var isShowing = false
    @State private var pickedImage: UIImage?
    @State private var latitude: Double = 0.0
    @State private var longitude: Double = 0.0
    
    let contacts = Contact( name: "Cool", longitude: 11.279250047153653, latiude:  75.7770214204051, image: UUID().uuidString)


    
    init(onSave: @escaping (Contact)->Void) {
        self.onSave = onSave
    }
    
    var body: some View {
        
        
        Form {
            Section {
                (pickedImage != nil) ?  Image(uiImage: pickedImage!)
                    .resizable().padding(.horizontal)
                    .clipShape(Circle())
                    .frame(width: 100, height: 90)
                    .multilineTextAlignment(.center)
                    .padding(.leading, 120.0)
                    .onTapGesture {
                        isShowing = true
                    } :   Image(systemName: "person.circle")
                    .resizable().padding(.horizontal)
                    .clipShape(Circle())
                    .frame(width: 100, height: 90)
                    .multilineTextAlignment(.center)
                    .padding(.leading, 120.0)
                    .onTapGesture {
                        isShowing = true
                    }
            }
            Section{
                TextField("Name",text: $name)
                   
            }
        
                ZStack{
                    Map(coordinateRegion:$region,annotationItems: annotations){
                        MapPin(coordinate: $0.cordinate)
                    }.onAppear{
                        self.locationFetcher.start()
                    }
                        .frame(height: 350 )
            Circle().fill(.blue).opacity(0.3).frame(width: 35, height: 35)
                    VStack{
                     Spacer()
                        HStack{
                            Spacer()
                            Button {
                                latitude = region.center.latitude
                                longitude = region.center.longitude
                            let newCity = Annotation( cordinate: CLLocationCoordinate2D(
                                latitude: region.center.latitude, longitude: region.center.longitude
                            ))
                            annotations = [newCity]
                        
                                
                            } label: {
                                Image(systemName: "plus").padding()
                                    .background(.black.opacity(0.75))
                                    .foregroundColor(.white)
                                    .font(.title)
                                    .clipShape(Circle())
                                    .padding(.trailing)
                            }
                        }
                
                    }
                
            }
            Button("Use current location"){
                self.locationFetcher.start()
                if let location = self.locationFetcher.lastKnownLocation {
                                   print("Your location is \(location)")
                    latitude = location.latitude
                    longitude = location.longitude
                    let newLocation =   MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
                    region = newLocation
                            
                               } else {
                                   print("Your location is unknown")
                               }
            }
          
            Section {
                
                Button("Save"){
                        let imageId = UUID()
                     if let jpegData =
                            pickedImage?.jpegData(compressionQuality: 0.8) {
                       let url = FileManager.getUrl()
                      let filePath = url.appendingPathComponent("\(imageId).jpeg")
                        print(filePath)
                        if  let saved =  try? jpegData.write(to: filePath, options: [.atomic, .completeFileProtection]) {
                            print("Saved \(saved)")
                        } else {
                            print("No saved")
                        }
                    }
                   let newContact = Contact(name: name, longitude: longitude, latiude: latitude, image: "\(imageId).jpeg")
                    onSave(newContact)
                    dismiss()
                }
            }
            
            
        }.sheet(isPresented:$isShowing){
            ImagePicker(image: $pickedImage)
        }
       
        
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(){ _ in
            
        }
    }
}
