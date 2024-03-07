//
//  MainViewState.swift
//  Weather
//
//  Created by Yerassyl Tynymbay on 05.03.2024
//  
//

import SwiftUI

final class MainViewState: ObservableObject, MainViewStateProtocol {
    func set(with presenter: MainPresenterProtocol) {
        self.presenter = presenter
    }
    
    @Published var currentTemperature: String = ""
    @Published var currentHumidity: String = ""
    @Published var weatherDescription: String = ""
    @Published var errorMessage: String = ""
    @Published var weatherData: WeatherData?
    @Published var searchResults: [WeatherData]? 
    func updateWeatherView(temperature: String, humidity: String, description: String) {
        self.currentTemperature = temperature
        self.currentHumidity = humidity
        self.weatherDescription = description
        self.errorMessage = ""
    }
    
    func displayError(_ message: String) {
        self.errorMessage = message
        self.currentTemperature = ""
        self.currentHumidity = ""
        self.weatherDescription = ""
    }
    
    private let id = UUID()
     var presenter: MainPresenterProtocol?
     var interactor: MainInteractorProtocol?
    func set(with presenter: MainPresenterProtocol, interactor: MainInteractorProtocol) {
           self.presenter = presenter
           self.interactor = interactor 
       }
}
