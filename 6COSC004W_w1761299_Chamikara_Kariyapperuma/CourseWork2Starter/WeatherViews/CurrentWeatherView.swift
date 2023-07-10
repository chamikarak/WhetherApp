//
//  Conditions.swift
//  Coursework2
//
//  Created by G Lukka.
//

import SwiftUI

struct CurrentWeatherView: View {
    @EnvironmentObject var modelData: ModelData
    @State var locationString: String = "No location"
    
    var body: some View {
        ZStack {
            // Background Image rendering code here
            Image("Image 3")
                .resizable()
                .ignoresSafeArea()
        
            VStack(spacing: 20) {
                VStack {
                    HStack {
                        Image(systemName: "location.fill")
                            .font(.system(size: 50))
                            
                        Text(modelData.userLocation)
                            .font(.system(size: 40))
                            .bold()
                        
                        
                    }
                    .foregroundColor(.white)
                    
                    Text("\((Int)(modelData.forecast!.current.temp))ºC")
                        .font(.system(size: 150))
                        .foregroundColor(.white)
                    
                    HStack {
                        AsyncImage(url: URL(string: modelData.generateWeatherIconURL(icon: modelData.forecast!.current.weather[0].icon))) { image in
                            if let image = image.image {
                                image.resizable().frame(width: 50, height: 50)
                            }
                        }
                        
                        Text(modelData.forecast!.current.weather[0].weatherDescription.rawValue.capitalized)
                    }
                }
                
                VStack(spacing: 20) {
                    HStack(spacing: 20) {
                        HStack {
                            Image(systemName: "sunrise.fill")
                                .foregroundColor(.yellow)
                            
                            Text("\(Date(timeIntervalSince1970: TimeInterval(((Int)(modelData.forecast?.current.sunrise ?? 0)))).formatted(.dateTime.hour().minute()))")
                        }
                        
                        HStack {
                            Image(systemName: "sunset.fill")
                                .foregroundColor(.yellow)
                            
                            Text("\(Date(timeIntervalSince1970: TimeInterval(((Int)(modelData.forecast?.current.sunset ?? 0)))).formatted(.dateTime.hour().minute()))")
                        }
                    }
                    
                    Text("Feels Like: \((Int)(modelData.forecast!.current.feelsLike))ºC")
                    
                    Text("Wind Speed: \((Int)(modelData.forecast!.current.windSpeed))m/s")
                    
                    Text("Direction: \(convertDegToCardinal(deg: modelData.forecast!.current.windDeg))")
                    
                    Text("Humidity: \(modelData.forecast!.current.humidity)%")
                    
                    Text("Pressure: \(modelData.forecast!.current.pressure) hPa")
                    
                }
                .padding()
                .background(.white.opacity(0.3))
                .cornerRadius(20)
                .frame(width: UIScreen.main.bounds.width*0.7, height: UIScreen.main.bounds.height*0.3)
                
                Spacer()
            }
        }
    }
}

struct Conditions_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherView()
            .environmentObject(ModelData())
    }
}
