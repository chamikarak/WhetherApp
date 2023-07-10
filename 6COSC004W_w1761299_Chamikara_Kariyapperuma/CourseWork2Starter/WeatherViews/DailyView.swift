//
//  DailyView.swift
//  Coursework2
//
//  Created by G Lukka.
//

import SwiftUI

struct DailyView: View {
    
    @EnvironmentObject var modelData: ModelData
    var day : Daily
   
    var body: some View {
        
        HStack {
            AsyncImage(url: URL(string: modelData.generateWeatherIconURL(icon: day.weather[0].icon)))
            
            Spacer()
            
            VStack(alignment: .center) {
                Text("\(day.weather[0].weatherDescription.rawValue.capitalized)")
                    .multilineTextAlignment(.center)
                
                Text(Date(timeIntervalSince1970: TimeInterval(((Int)(day.dt))))
                    .formatted(.dateTime.weekday().day()))
            } 
            
            Spacer()
            
            Text("\((Int)(day.temp.max))ºC / \((Int)(day.temp.min))ºC")
           
        }.padding()
    }
    
}

struct DailyView_Previews: PreviewProvider {
    static var day = ModelData().forecast!.daily
    
    static var previews: some View {
        DailyView(day: day[0])
    }
}
