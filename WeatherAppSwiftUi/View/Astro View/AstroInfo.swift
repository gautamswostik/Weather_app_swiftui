//
//  AstroInfo.swift
//  WeatherAppSwiftUi
//
//  Created by swostik gautam on 24/12/2022.
//

import SwiftUI

struct AstroCardView : View {
    var sunRiseTime : String
    var sunSetTime : String
    var loadingAstrology : Bool
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .shadow(radius: 8)
            NavigationLink(destination: SecondScreen()) {
                HStack {
                    if(loadingAstrology){
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    }else {
                        AstroInfo(
                            title: "Sunrise",
                            time: sunRiseTime,
                            icon: "sunrise"
                        )
                        
                    }
                    
                    Spacer()
                    if(loadingAstrology){
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    }else {
                        AstroInfo(
                            title: "Sunset",
                            time: sunSetTime,
                            icon: "sunset"
                        )
                    }
                }.padding(.horizontal , 40)
                    .padding(.vertical , 20)
            }
        }
    }
}

struct AstroInfo : View {
    var title: String
    var time : String
    var icon : String
    var body: some View {
        VStack {
            Text(title)
                .font(.system(size: 20 , weight: .medium))
                .foregroundColor(.white)
            Spacer()
            Text(time)
                .font(.system(size: 20 , weight: .medium))
                .foregroundColor(.white)
            Spacer()
            Image(systemName: icon)
                .renderingMode(.original)
                .resizable()
                .aspectRatio( contentMode: .fit)
                .frame(width:60 ,height:60)
                .foregroundColor(.yellow)
            
        }
    }
}
