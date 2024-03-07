//
//  DetailWeatherView.swift
//  Weather
//
//  Created by Yerassyl Tynymbay on 05.03.2024.
//

import Foundation
import SwiftUI

struct DetailWeatherView: View {
    var weatherData: WeatherData
    
    var body: some View {
        ZStack(alignment : .leading) {
            Color.blue.opacity(0.5)
                .ignoresSafeArea(.all)
            VStack{
                VStack(alignment: .leading, spacing: 5) {
                    Text(weatherData.name)
                        .bold()
                        .font(.title)
                    
                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .fontWeight(.light)
                }.frame(maxWidth: .infinity, alignment: .leading)
               Spacer()
                
                VStack{
                    HStack{
                        VStack(spacing : 20) {
                            Image(systemName: "cloud")
                                .font(.system(size: 40))
                            Text("\(weatherData.weather.first?.description ?? "No description")")

                        }.frame(width: 150, alignment: .leading)
                        Spacer()
                        let celsiusTemperature = weatherData.main.temp - 273.15
                        Text("\(celsiusTemperature, specifier: "%.0f")°C")
                            .font(.system(size: 50))
                            .fontWeight(.bold)
                            .padding()
                    }
                    Spacer().frame(height:  80)
                    AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350)
                    } placeholder: {
                        ProgressView()
                    }
                    Spacer()
                    
                }.frame(maxWidth: .infinity, alignment: .trailing)
            }.padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            VStack{
                Spacer()
                VStack(alignment: .leading,spacing: 20){
                    HStack{
                        
                        WeatherRow(logo: "thermometer", name: "Min temp", value: formattedTemperature(weatherData.main.tempMin))
                         Spacer()
                        
                        WeatherRow(logo: "thermometer", name: "Max temp", value: formattedTemperature(weatherData.main.tempMax))
                    }
                    HStack{
                        WeatherRow(logo: "wind", name: "Wind speed", value: formattedWindSpeed(weatherData.wind.speed))
                        Spacer()
                        WeatherRow(logo: "humidity", name: "Humidity", value: formattedHumidity(weatherData.main.humidity))
                    }
                }.frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .padding(.bottom, 20)
                    .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
                    .background(.white)
                    .cornerRadius(20)
            }
        }.edgesIgnoringSafeArea(.bottom)
           
            .preferredColorScheme(.light)
    }
}
private func formattedTemperature(_ temperature: Double) -> String {
        let celsiusTemperature = temperature - 273.15
        return String(format: "%.0f°C", celsiusTemperature)
    }
private func formattedWindSpeed(_ speed: Double) -> String {
        return String(format: "%.1f m/s", speed)
    }
private func formattedHumidity(_ humidity : Int) -> String {
     return "\(humidity)%"
}


struct DetailWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleData = """
        {
            "coord": {"lon":76.95,"lat":43.25},
            "weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],
            "base":"stations",
            "main":{"temp":271.1,"feels_like":268.31,"temp_min":271.1,"temp_max":271.1,"pressure":1018,"humidity":74},
            "visibility":5000,
            "wind":{"speed":2,"deg":270},
            "clouds":{"all":75},
            "dt":1709731437,
            "sys":{"type":1,"id":8818,"country":"KZ","sunrise":1709688005,"sunset":1709729226},
            "timezone":21600,
            "id":1526384,
            "name":"Almaty",
            "cod":200
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let weatherData = try decoder.decode(WeatherData.self, from: sampleData)
            return AnyView(DetailWeatherView(weatherData: weatherData))
        } catch {
            print("Error decoding sample data: \(error)")
            return AnyView(Text("Failed to decode sample data"))
        }
    }
}



