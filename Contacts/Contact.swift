//
//  Contact.swift
//  Contacts
//
//  Created by Sree on 08/01/22.
//

import Foundation
import UIKit
import MapKit


struct Contact: Codable,Identifiable {
    var id = UUID()
    var name: String
    let longitude: Double
    let latiude: Double
    let image: String
    var profileImage: UIImage  {
        let url = FileManager.getUrl()
        let jepgUrl = url.appendingPathComponent("\(image)")
        if  let data = try? Data(contentsOf: jepgUrl) {
         return  UIImage(data: data)!
        } else {
          return  UIImage(systemName: "person.circle")!
        }
    }
    var region: MKCoordinateRegion {
        return MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latiude, longitude:longitude), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    }
    var annotations: [Annotation] {
        return [Annotation(cordinate:CLLocationCoordinate2D(latitude: latiude, longitude: longitude))]
    }
}
struct Annotation: Identifiable {
    var id = UUID()
    var cordinate: CLLocationCoordinate2D
}
