//
//  ContentView-ViewModel.swift
//  Contacts
//
//  Created by Sree on 09/01/22.
//

import Foundation

extension ContentView {
    @MainActor  class ViewModel: ObservableObject {
        @Published var showImagePicker = false;
        @Published  var contacts = [Contact]()
            
        init() {
            loadData()
        }
        
        
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
        
        
        func addNewContact(contact: Contact) {
            contacts.append(contact)
            save()

        }
    
    }
}
