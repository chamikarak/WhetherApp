//
//  PollutionView.swift
//  Coursework2
//
//  Created by GirishALukka on 30/12/2022.
//

import SwiftUI

struct PollutionView: View {
    
    // @EnvironmentObject and @State varaibles here
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        
        ZStack {
            // Use ZStack for background images
            Image("Image 1")
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
                
                VStack(spacing: 20)  {
                    HStack(spacing: 20) {
                        AirPollutionView(imageName: "so2", airQualityData: modelData.airQualityData?.list[0].components.so2)
                            .frame(width: 100, height: 100)
                            .background(.white.opacity(0.3))
                            .cornerRadius(20)
                        
                        
                        
                        AirPollutionView(imageName: "no", airQualityData: modelData.airQualityData?.list[0].components.no2)
                            .frame(width: 100, height: 100)
                            .background(.white.opacity(0.3))
                            .cornerRadius(20)
                    }
                    
                    HStack(spacing: 20) {
                        AirPollutionView(imageName: "voc", airQualityData: modelData.airQualityData?.list[0].components.co)
                            .frame(width: 100, height: 100)
                            .background(.white.opacity(0.3))
                            .cornerRadius(20)
                        
                        
                        
                        AirPollutionView(imageName: "pm", airQualityData: modelData.airQualityData?.list[0].components.pm10)
                            .frame(width: 100, height: 100)
                            .background(.white.opacity(0.3))
                            .cornerRadius(20)
                    }
                }
                
                Spacer()
            }
            .padding()
        }
        
        .onAppear {
            Task {
                try await modelData.loadAirQualitynData()
            }
        }
    }
}



