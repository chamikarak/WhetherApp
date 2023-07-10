//
//  AirPollutionView.swift
//  CourseWork2Starter
//
//  Created by Amani Peris on 2023-03-31.
//

import SwiftUI

struct AirPollutionView: View {
    
    var imageName: String?
    var airQualityData: Double?
    
    var body: some View {
        VStack {
            Image("\(imageName!)")
                .resizable()
                .frame(width: 50, height: 50)
            
            Text("\(String(format: "%.2f", airQualityData ?? 0))")
                .bold()
        }
        
    }
}

struct AirPollutionView_Previews: PreviewProvider {
    static var previews: some View {
        AirPollutionView()
    }
}
