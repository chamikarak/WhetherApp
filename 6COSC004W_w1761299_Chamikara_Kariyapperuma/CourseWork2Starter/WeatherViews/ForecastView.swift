//
//  Forecast.swift
//  Coursework2
//
//  Created by G Lukka.
//

import SwiftUI

struct ForecastView: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        ZStack {
            Image("Image 1")
                .resizable()
                .ignoresSafeArea()
        
            VStack {
//                Text("\(modelData.userLocation)")
//                    .font(.largeTitle)
//                    .bold()
                
                
                
                List{
                    ForEach(modelData.forecast!.daily) { day in
                        DailyView(day: day)
                            .listRowBackground(Color.white.opacity(0.3))
                    }
                }
                .background(Color.white.opacity(0.3))
                .scrollContentBackground(.hidden)
            }
        }
    }
}

struct Forecast_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView().environmentObject(ModelData())
    }
}
