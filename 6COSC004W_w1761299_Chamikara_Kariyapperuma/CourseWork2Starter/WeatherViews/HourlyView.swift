//
//  Hourly.swift
//  Coursework2
//
//  Created by G Lukka.
//

import SwiftUI

struct HourlyView: View {
    
   @EnvironmentObject var modelData: ModelData

    var body: some View {
        ZStack {
            Image("Image 1")
                .resizable()
                .ignoresSafeArea()
            
            VStack{
//                Text("\(modelData.userLocation)")
//                    .font(.largeTitle)
//                    .bold()
                
               
                
                List {
                    ForEach(modelData.forecast!.hourly) { hour in
                        HourCondition(current: hour)
                            .listRowBackground(Color.white.opacity(0.3))
                    }
                }
                .background(Color.white.opacity(0.3))
                .scrollContentBackground(.hidden)
            }
        }
    }
}

struct Hourly_Previews: PreviewProvider {
    static var previews: some View {
        HourlyView().environmentObject(ModelData())
    }
}
