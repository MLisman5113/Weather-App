//
//  WeatherView.swift
//  Weather
//
//  Created by Marcus Lisman on 5/19/23.
//

import SwiftUI

struct WeatherView: View {
    @EnvironmentObject var locationManager: LocationManager
    var weatherManager = WeatherManager()
    
    @Binding var weather: ResponseBody?
    
    var body: some View {
        ZStack(alignment: .leading) {
            LinearGradient(gradient: Gradient(colors: [.blue,.white]),startPoint: .topLeading,endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(weather!.name)
                        .bold().font(.title)
                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .fontWeight(.light)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                
                VStack {
                    HStack {
                        
                        if weather!.weather[0].main == "Clouds"
                        {
                            VStack(spacing: 20) {
                                Image(systemName: "cloud")
                                    .font(.system(size:70))
                                Text(weather!.weather[0].main)
                            }
                            .frame(width: 150, alignment: .leading)
                        }
                        else if weather!.weather[0].main == "Thunderstorm"
                        {
                            VStack(spacing: 20) {
                                Image(systemName: "cloud.bolt.rain")
                                    .font(.system(size:70))
                                Text(weather!.weather[0].main)
                            }
                            .frame(width: 150, alignment: .leading)
                        }
                        else if weather!.weather[0].main == "Mist"
                        {
                            VStack(spacing: 20) {
                                Image(systemName: "cloud.fog")
                                    .font(.system(size:70))
                                Text(weather!.weather[0].main)
                            }
                            .frame(width: 150, alignment: .leading)
                        }
                        else if weather!.weather[0].main == "Snow"
                        {
                            VStack(spacing: 20) {
                                Image(systemName: "cloud.snow")
                                    .font(.system(size:70))
                                Text(weather!.weather[0].main)
                            }
                            .frame(width: 150, alignment: .leading)
                        }
                        else if weather!.weather[0].main == "Rain"
                        {
                            VStack(spacing: 20) {
                                Image(systemName: "cloud.rain")
                                    .font(.system(size:70))
                                Text(weather!.weather[0].main)
                            }
                            .frame(width: 150, alignment: .leading)
                        }
                        else
                        {
                            VStack(spacing: 20) {
                                Image(systemName: "sun.max")
                                    .font(.system(size:40))
                                Text(weather!.weather[0].main)
                            }
                            .frame(width: 150, alignment: .leading)
                        }
                            
                        
                        Spacer()
                        
                        Text(weather!.main.temp.roundDouble() + "º")
                            .font(.system(size: 100))
                            .fontWeight(.bold)
                            .padding()
                    }
                }
                .frame(maxWidth: .infinity)
                
                
                AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png")) {
                    image in image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 350)
                } placeholder: {
                    ProgressView()
                }
                
                Spacer()
                
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                Spacer()
                
                VStack(alignment: .leading, spacing:20) {
                    Text("Weather Overview")
                        .bold().padding(.bottom)
                    
                    HStack {
                        WeatherRow(logo: "info.circle", name: "Description", value: (weather!.weather[0].description).capitalizedSentence)
                    }
                    HStack {
                        Spacer()
                        WeatherRow(logo: "thermometer", name: "Minimum Temperature", value: (weather!.main.temp_min.roundDouble() + "º"))
                        WeatherRow(logo: "thermometer", name: "Maximum Temperature", value: (weather!.main.temp_max.roundDouble() + "º"))
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        WeatherRow(logo: "wind", name: "Wind Speed", value: (weather!.wind.speed.roundDouble())
 + " mph")
                        WeatherRow(logo: "humidity", name: "Humidity", value: (weather!.main.humidity.roundDouble() + "%"))
                        Spacer()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.bottom, 20)
                .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
                .background(.white)
                .cornerRadius(20, corners: [.topLeft, .topRight])
                
            }
            
        }
        .edgesIgnoringSafeArea(.bottom)
        .preferredColorScheme(.dark)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: {
                    Task {
                        do {
                            // Update location
                            try await locationManager.requestLocation()
                            
                            // Then fetch weather
                            if let location = locationManager.location {
                                weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                            }
                        } catch {
                            print("Error refreshing weather: \(error)")
                        }
                    }
                }) {
                    Image(systemName: "arrow.clockwise").foregroundColor(.white)
                        .font(.system(size:25))
                }
            }
        }
    }
}


struct WeatherView_Previews: PreviewProvider {
    static var previewWeather: ResponseBody {
        return ResponseBody(coord: ResponseBody.CoordinatesResponse(lon: -0.13, lat: 51.51),
                            weather: [ResponseBody.WeatherResponse(id: 1, main: "Clear", description: "clear sky", icon: "01d")],
                            main: ResponseBody.MainResponse(temp: 289.92, feels_like: 289.3, temp_min: 288.71, temp_max: 291.15, pressure: 1015, humidity: 67),
                            name: "London",
                            wind: ResponseBody.WindResponse(speed: 1.54, deg: 340))
    }

    static var previews: some View {
        WeatherView(weather: .constant(previewWeather))
    }
}
