//
//  DetailView.swift
//  Contacts
//
//  Created by Sree on 08/01/22.
//

import SwiftUI
import MapKit


struct DetailView: View {
    @State var  contact: Contact
    @State var  region: MKCoordinateRegion
    var body: some View {
        Form {
                
            Section {
                Image(uiImage: contact.profileImage)
                    .resizable().padding(.horizontal)
                    .clipShape(Circle())
                    .frame(width: 200, height: 190)
                    .multilineTextAlignment(.center)
                    .padding(.leading, 70.0)
                  
                    
            }
            Section{
                Text("\(contact.name)")  .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
            }
            Section {
                Map(coordinateRegion:$region, annotationItems: contact.annotations)
                    {
                        MapPin(coordinate: $0.cordinate)
                       }
                    .frame(height: 400 )
                
         
            }
        }
    }
}

