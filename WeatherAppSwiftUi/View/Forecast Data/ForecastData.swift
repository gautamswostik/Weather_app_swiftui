//
//  ForecastData.swift
//  WeatherAppSwiftUi
//
//  Created by swostik gautam on 24/12/2022.
//

import SwiftUI

struct ForecastData: View {
    var hourData: [Hour]
    var body: some View {
        ForeCastDataCard(hourData: hourData)
    }
}

struct ForeCastDataCard: View {
    var hourData: [Hour]
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .shadow(radius: 8)
            VStack {
                HStack {
                    Image(systemName: "clock")
                        .aspectRatio( contentMode: .fit)
                        .foregroundColor(.white)
                    Spacer()
                    Spacer()
                    Image(systemName: "thermometer.sun")
                        .aspectRatio( contentMode: .fit)
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "wind")
                        .aspectRatio( contentMode: .fit)
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "humidity")
                        .aspectRatio( contentMode: .fit)
                        .foregroundColor(.white)
                }.padding(.horizontal , 20)
                    .padding(.vertical , 20)
                
                ForEach(hourData , id: \.time_epoch) { hour in
                    HStack{
                        Text(getCurrentDateInTimeFormat(date: hour.time ?? ""))
                            .foregroundColor(.white)
                        Spacer()
                        Spacer()
                        Text(String(format: "%.00f", hour.temp_c ?? 0.0) + "°c")
                            .foregroundColor(.white)
                        
                        Spacer()
                        Text(String(format: "%.00f", hour.wind_kph ?? 0.0) + " " + "km/s")
                            .foregroundColor(.white)
                        Spacer()
                        Text("\(hour.humidity ?? 0 ) %")
                            .foregroundColor(.white)
                        
                    }.padding(.horizontal , 10)
                        .padding(.vertical , 5)
                }
            }.padding(.bottom , 20)
        }
    }
}

