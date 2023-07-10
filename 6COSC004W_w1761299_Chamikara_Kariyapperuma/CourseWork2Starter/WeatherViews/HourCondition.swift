//
//  HourCondition.swift
//  Coursework2
//
//  Created by G Lukka.
//


import SwiftUI

struct HourCondition: View {
    
    @EnvironmentObject var modelData: ModelData
    var current : Current
  
    var body: some View {
        HStack {
            Text(Date(timeIntervalSince1970: TimeInterval(((Int)(current.dt)))).formatted(.dateTime.hour().weekday()))
            
            Spacer()
            
            AsyncImage(url: URL(string: modelData.generateWeatherIconURL(icon: current.weather[0].icon)))
            
            Spacer()
            
            Text("\((Int)(current.temp))ºC")
            
            Spacer()
            
            Text("\(current.weather[0].weatherDescription.rawValue.capitalized)")
        }.padding()
    }
}

struct HourCondition_Previews: PreviewProvider {
    static var hourly = ModelData().forecast!.hourly
    
    static var previews: some View {
        HourCondition(current: hourly[0])
    }
}
