//
//  ContentView.swift
//  Contacts
//
//  Created by Sree on 03/01/22.
//

import SwiftUI

struct ContentView: View {
    @State var showImagePicker = false;
    @State private var inputImage: UIImage?
    @State private var outPutImage =  UIImage(systemName: "person.circle")
    @State  var newIded = UUID()
    @State private var contacts = [Contact]()
    
    let savePath = FileManager.doucmentsDir.appendingPathComponent("contacts")
    
    func save(){
        do {
            let data = try JSONEncoder().encode(contacts)
            try data.write(to: savePath,options: [.atomic,.completeFileProtection])
        } catch {
            print("Unable to save data")
        }
    }
    
    func loadData() {
        do{
            let data = try Data(contentsOf: savePath)
            let contacts = try JSONDecoder().decode([Contact].self, from: data)
            self.contacts = contacts
        } catch {
            print("Unable to load data")
           
        }
    }
    
    
    
    var body: some View {
        NavigationView {
            List(contacts) { contact in
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
                    showImagePicker = true
                })
        }
        .onAppear {
            loadData()
        }
        .sheet(isPresented: $showImagePicker){
            AddView(){ contact in
                print(contact)
                contacts.append(contact)
                save()
            }
        }
}
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
