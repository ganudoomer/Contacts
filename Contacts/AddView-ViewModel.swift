//
//  AddView-ViewModel.swift
//  Contacts
//
//  Created by Sree on 09/01/22.
//

import Foundation
import MapKit

extension AddView {
    @MainActor  class ViewModel: ObservableObject {
        @Published  var  annotations = [
          Annotation(cordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275)),
      ]
     
      let locationFetcher = LocationFetcher()
        @Published  var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
      
        @Published  var name: String = ""
        @Published  var isShowing = false
        @Published  var pickedImage: UIImage?
        @Published  var latitude: Double = 0.0
        @Published  var longitude: Double = 0.0
        
        func useCurrentLocation() {
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
        func save()-> Contact {
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
           return newContact
        }
        
        
        
    }
}
