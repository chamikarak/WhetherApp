//
//  SearchView.swift
//  CWK2_23_GL
//
//  Created by GirishALukka on 11/03/2023.
//

import SwiftUI
import CoreLocation

struct SearchView: View {
    @EnvironmentObject var modelData: ModelData
    @Binding var isSearchOpen: Bool
    @State var location = ""
    @Binding var userLocation: String
    
    var body: some View {
        ZStack {
            Image("Image2")
                .resizable()
                .ignoresSafeArea()
            
            VStack{
                HStack {
                    Text("Please enter new location below")
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Button {
                        isSearchOpen.toggle()
                    } label: {
                        Text("X")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .padding(10)
                            .background(.red)
                    }

                }
                
//                Spacer()
                
                TextField("New location", text: self.$location, onCommit: {
                    CLGeocoder().geocodeAddressString(location) { (placemarks, error) in
                        if let lat = placemarks?.first?.location?.coordinate.latitude,
                           let lon = placemarks?.first?.location?.coordinate.longitude {
                            Task {
                                let _ = try await modelData.loadData(lat: lat, lon: lon)
                                userLocation = location
                                modelData.userLocation = location
                            }
                            isSearchOpen.toggle()
                        }
                    }//GEOCorder
                } //Commit
                )// TextField
                .textFieldStyle(OutlinedTextFieldStyle(icon: Image(systemName: "magnifyingglass")))
                .autocorrectionDisabled()
                .font(.system(size: 20))
                .foregroundColor(.white)
                
                Spacer()
                
            }//VStak
            .padding()
            
            
        }// Zstack
    }// Some
} //View
