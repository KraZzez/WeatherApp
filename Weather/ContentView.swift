//
//  ContentView.swift
//  Weather
//
//  Created by Ludvig Krantzén on 2022-11-07.
//

import SwiftUI

let url = "https://open-meteo.com/"

struct ContentView: View {
    
    @StateObject private var gameModel = GameModel()
    @State private var isNight = false
    
    var body: some View {
        ZStack {
            BackgroundView(isNight: $isNight)
             //   .overlay(isNight ? .ultraThinMaterial : .ultraThinMaterial)
            VStack {
                PlaceTextView(cityName: "Jönköping", country: "Sweden")
                
                MainWeatherStatusView(imageName: "cloud.sun.fill", temperature: 16)
                
                HStack(spacing: 10) {
                    
                    WeatherDayView(dayOfWeek: "Mon", imageName: "cloud.sun.fill", temperature: 16)
                    WeatherDayView(dayOfWeek: "Tue", imageName: "sun.max.fill", temperature: 20)
                    WeatherDayView(dayOfWeek: "Wed", imageName: "cloud.sun.fill", temperature: 15)
                    WeatherDayView(dayOfWeek: "Thu", imageName: "cloud.sun.fill", temperature: 16)
                    WeatherDayView(dayOfWeek: "Fri", imageName: "sun.max.fill", temperature: 19)
                    WeatherDayView(dayOfWeek: "Sat", imageName: "cloud.sun.fill", temperature: 14)
                    WeatherDayView(dayOfWeek: "Sun", imageName: "wind.snow", temperature: 9)
                }
                Spacer()
                
                Button {
                    isNight.toggle()
                    print(isNight)
                } label: {
                    WeatherButton(title: "Change Day Time", textColor: .blue, backgroundColor: .white, isNight: isNight)
                }
                
                Spacer()
            }
        }
        .onAppear{
            gameModel.loadQuestions()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct WeatherDayView: View {
    
    var dayOfWeek: String
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack {
            Text(dayOfWeek)
                .font(.system(size: 16, weight: .medium, design: .default))
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            
            Text("\(temperature)°")
                .font(.system(size: 28, weight: .medium))
                .foregroundColor(.white)
            
        }
    }
}

struct BackgroundView: View {
    
    @Binding var isNight: Bool
    
    var body: some View {
        
        LinearGradient(gradient: Gradient(colors: [isNight ? .white : .yellow, isNight ? .black : .blue, isNight ? .gray : .blue]),
                       startPoint: .topTrailing,
                       endPoint: .bottomLeading)
        .ignoresSafeArea()

        
/*        Image("ball")
            .resizable()
            .ignoresSafeArea()
            .overlay(.ultraThinMaterial)
 */
    }
}

struct PlaceTextView: View {
    
    var cityName: String
    var country: String
    
    var body: some View {
        Text(cityName + ", " + country)
            .foregroundColor(.white)
            .font(.system(size:37, weight: .medium, design: .default))
            .padding()
    }
}

struct MainWeatherStatusView: View {
    
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
            
            Text("\(temperature)°")
                .font(.system(size: 70, weight: .medium))
                .foregroundColor(.white)
        }
        .padding(.bottom, 40)
    }
}
