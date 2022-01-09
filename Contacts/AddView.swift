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
    var onSave: (Contact)->Void
    @StateObject private var viewModel = ViewModel()
    
    init(onSave: @escaping (Contact)->Void) {
        self.onSave = onSave
    }
    
    var body: some View {
        Form {
            Section {
                (viewModel.pickedImage != nil) ?  Image(uiImage: viewModel.pickedImage!)
                    .resizable().padding(.horizontal)
                    .clipShape(Circle())
                    .frame(width: 100, height: 90)
                    .multilineTextAlignment(.center)
                    .padding(.leading, 120.0)
                    .onTapGesture {
                        viewModel.isShowing = true
                    } :   Image(systemName: "person.circle")
                    .resizable().padding(.horizontal)
                    .clipShape(Circle())
                    .frame(width: 100, height: 90)
                    .multilineTextAlignment(.center)
                    .padding(.leading, 120.0)
                    .onTapGesture {
                        viewModel.isShowing = true
                    }
            }
            Section{
                TextField("Name",text: $viewModel.name)
                   
            }
        
                ZStack{
                    Map(coordinateRegion:$viewModel.region,annotationItems: viewModel.annotations){
                        MapPin(coordinate: $0.cordinate)
                    }.onAppear{
                       viewModel.locationFetcher.start()
                    }
                        .frame(height: 350 )
            Circle().fill(.blue).opacity(0.3).frame(width: 35, height: 35)
                    VStack{
                     Spacer()
                        HStack{
                            Spacer()
                            Button {
                                viewModel.useCurrentLocation()
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
                viewModel.useCurrentLocation()
            }
          
            Section {
                Button("Save"){
                    let contact = viewModel.save()
                    onSave(contact)
                    dismiss()
                }
            }
        }.sheet(isPresented:$viewModel.isShowing){
            ImagePicker(image: $viewModel.pickedImage)
        }
       
        
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(){ _ in
            
        }
    }
}
