//
//  HomeView.swift
//  CWK2_23_GL
//
//  Created by GirishALukka on 10/03/2023.
//

import SwiftUI
import CoreLocation

struct Home: View {
    
    @EnvironmentObject var modelData: ModelData
    @State var isSearchOpen: Bool = false
    @State  var userLocation: String = ""
    
    
    var body: some View {
        ZStack {
            Image("Image2")
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                HStack {
                    Image(systemName: "location.fill")
                        .font(.system(size: 50))
                        
                    Text(userLocation)
                        .font(.system(size: 40))
                        .bold()
                    
                    
                }
                .foregroundColor(.white)
                
                
                HStack {
                    Text(Date(timeIntervalSince1970: TimeInterval(((Int)(modelData.forecast?.current.dt ?? 0))))
                        .formatted(.dateTime.year().hour().month().day()))
                    .font(.system(size: 30))
                    
                    
                }
                .foregroundColor(.white)
                
                Text("\((Int)(modelData.forecast!.current.temp))ºC")
                    .font(.system(size: 150))
                    .foregroundColor(.white)
                
                
                ScrollView(.horizontal) {
                    HStack {
                        ZStack {
                            Color(.white)
                                .opacity(0.3)
                            
                            VStack {
                                AsyncImage(url: URL(string: modelData.generateWeatherIconURL(icon: modelData.forecast!.current.weather[0].icon))) { image in
                                    if let image = image.image {
                                        image.resizable().frame(width: 50, height: 50)
                                    }
                                }
                                
                                
                                Text("\(modelData.forecast!.current.weather[0].weatherDescription.rawValue.capitalized)")
                                    .font(.system(size: 30))
                                
                                Text("Cloud Condition")
                            }
                            
                        }
                        .frame(width: UIScreen.main.bounds.width - 50, height: 200)
                        .cornerRadius(20)
                        
                        ZStack {
                            Color(.white)
                                .opacity(0.3)
                            
                            VStack {
                                Image(systemName: "location.fill")
                                    .font(.system(size: 50))
                                
                                Text("\(modelData.forecast!.current.humidity)%")
                                    .font(.system(size: 30))
                                
                                Text("Humidity")
                            }
                            
                        }
                        .frame(width: UIScreen.main.bounds.width - 50, height: 200)
                        .cornerRadius(20)
                        
                        ZStack {
                            Color(.white)
                                .opacity(0.3)
                            
                            VStack {
                                Image(systemName: "location.fill")
                                    .font(.system(size: 50))
                                
                                Text("\(modelData.forecast!.current.pressure) hPa")
                                    .font(.system(size: 30))
                                
                                Text("Pressure")
                            }
                            
                        }
                        .frame(width: UIScreen.main.bounds.width - 50, height: 200)
                        .cornerRadius(20)
                    }
                }
                
                
                
                Button("Change Location") {
                    self.isSearchOpen.toggle()
                }
                .sheet(isPresented: $isSearchOpen) {
                    SearchView(isSearchOpen: $isSearchOpen, userLocation: $userLocation)
                }
                .buttonStyle(BlueButton())
                
                
                Spacer()
                
            }
            .padding(.horizontal)
            .padding(.top)
            .onAppear {
                Task.init {
                    self.userLocation = await getLocFromLatLong(lat: modelData.forecast!.lat, lon: modelData.forecast!.lon)
                    self.modelData.userLocation = userLocation
                }
                
            }
            
        }
        
    }
}
