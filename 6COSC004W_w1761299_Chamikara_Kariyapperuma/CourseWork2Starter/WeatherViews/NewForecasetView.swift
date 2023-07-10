//
//  NewForecasetView.swift
//  CourseWork2Starter
//
//  Created by Pubudu Mihiranga on 2023-05-06.
//

import SwiftUI

enum ConditionType {
    case hourlyForecast, dailyForecast
}

struct NewForecasetView: View {
    
    @EnvironmentObject var modelData: ModelData
    @State private var conditionType = ConditionType.hourlyForecast
    
    var body: some View {
        ZStack {
            Image("Image 1")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    Image(systemName: "location.fill")
                        .font(.system(size: 50))
                        
                    Text("\(modelData.userLocation)")
                        .font(.system(size: 40))
                        .bold()
                    
//                    Spacer()
                }
                .foregroundColor(.white)
                
                Picker("", selection: $conditionType) {
                    Text("Hourly Forecast Details")
                        .tag(ConditionType.hourlyForecast)
                    Text("Daily Forecast Details")
                        .tag(ConditionType.dailyForecast)
                }
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 6))
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                if conditionType == .hourlyForecast {
                    ForecastView()
                } else {
                    HourlyView()
                }
                
                Spacer()
            }
        }
    }
}

struct NewForecasetView_Previews: PreviewProvider {
    static var previews: some View {
        NewForecasetView()
    }
}
