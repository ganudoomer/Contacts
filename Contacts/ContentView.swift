//
//  ContentView.swift
//  Contacts
//
//  Created by Sree on 03/01/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    var body: some View {
        NavigationView {
            List(viewModel.contacts) { contact in
                NavigationLink(destination : DetailView(contact: contact, region: contact.region ) ){
                    VStack {
                        HStack {
                            Image(uiImage: contact.profileImage).resizable()
                                .scaledToFit()
                                .clipShape(Circle()).frame(width: 70, height: 70)
                            Text(contact.name).font(.headline)
                            
                        }
                    }
                }
               
            }.navigationTitle("Contacts")
                .navigationBarItems(trailing: Button("Add"){
                    viewModel.showImagePicker = true
                })
        }
        .sheet(isPresented: $viewModel.showImagePicker){
            AddView(){ contact in
                viewModel.addNewContact(contact: contact)
            }
        }
}
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
