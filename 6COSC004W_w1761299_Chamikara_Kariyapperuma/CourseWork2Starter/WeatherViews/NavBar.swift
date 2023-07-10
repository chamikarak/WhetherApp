//
//  NavBar.swift
//  Coursework2
//
//  Created by G Lukka.
//

import SwiftUI

struct NavBar: View {
        
    var body: some View {
        TabView{
           Home()
                .tabItem{
                    Label("City", systemImage: "magnifyingglass")
                }
            
            CurrentWeatherView()
                .tabItem {
                    Label("Weather Now", systemImage: "sun.max.fill")
                }
            
            NewForecasetView()
                .tabItem{
                    Label("Hourly Data", systemImage: "clock.fill")
                }
            
            PollutionView()
                .tabItem {
                    Label("Pollution Data", systemImage: "aqi.high")
                }
        }.onAppear {
            UITabBar.appearance().isTranslucent = false
        }
        
    }
        
}

