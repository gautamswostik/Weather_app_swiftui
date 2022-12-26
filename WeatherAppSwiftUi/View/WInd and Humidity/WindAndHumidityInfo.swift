//
//  WindAndHumidityInfo.swift
//  WeatherAppSwiftUi
//
//  Created by swostik gautam on 24/12/2022.
//

import SwiftUI

struct WindAndHumidityInfo: View {
    var windInfo : String
    var humidityInfo : String
    var pressure : String
    var body: some View {
        WindAndHumidityInfoCard(windInfo: windInfo, humidityInfo: humidityInfo, pressure: pressure)
    }
}

struct WindAndHumidityInfoCard : View {
    var windInfo : String
    var humidityInfo : String
    var pressure : String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .shadow(radius: 8)
            HStack {
                WindAndHumidityInfoView(iconName: "wind" ,currentInfo: "\(windInfo) km/s" , infoTitle: "Wind")
                Spacer()
                WindAndHumidityInfoView(iconName: "humidity" ,currentInfo: "\(humidityInfo) %" ,infoTitle: "Humidity")
                Spacer()
                WindAndHumidityInfoView(iconName: "thermometer.sun", currentInfo: "\(pressure) mb" ,infoTitle: "Pressure")
            }.padding(.horizontal , 40)
                .padding(.vertical , 20)
        }
        
    }
}


struct WindAndHumidityInfoView : View {
    var iconName : String
    var currentInfo : String
    var infoTitle : String
    var body: some View {
        VStack {
            Image(systemName: iconName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio( contentMode: .fit)
                .frame(width:30 ,height:30)
                .foregroundColor(.white)
            Spacer()
            Text(currentInfo)
                .font(.system(size: 20 , weight: .medium))
                .foregroundColor(.white)
            Spacer()
            Text(infoTitle)
                .font(.system(size: 20 , weight: .thin))
                .foregroundColor(.white)
        }
    }
}
