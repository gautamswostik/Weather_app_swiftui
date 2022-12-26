//
//  CurrentInfo.swift
//  WeatherAppSwiftUi
//
//  Created by swostik gautam on 24/12/2022.
//

import SwiftUI

struct CurrentWeatherInfo : View {
    var currentTemp : String
    var currentLocation : String
    var currentTime : String
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                Text("\(currentTemp)°c")
                    .font(.system(size: 80 , weight: .bold))
                    .foregroundColor(.white)
                
                Spacer()
                Image(systemName: getCurrentDaySymbol())
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio( contentMode: .fit)
                    .frame(width:60 ,height:60)
                    .foregroundColor(getCurrentDaySymbol())
                
            }
            Text(currentLocation)
                .foregroundColor(.white)
                .font(.system(size: 30 , weight: .medium))
            
            Text(currentTime)
                .foregroundColor(.white)
                .font(.system(size: 20 , weight: .medium))
        }
    }
}
