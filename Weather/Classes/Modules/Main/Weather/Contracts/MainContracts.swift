//
//  MainContracts.swift
//  Weather
//
//  Created by Yerassyl Tynymbay on 05.03.2024
//  
//

import SwiftUI


// Router
protocol MainRouterProtocol: RouterProtocol {
    func navigateToDetailView(with weather: WeatherData)
}

// Presenter
protocol MainPresenterProtocol: PresenterProtocol {
    func getWeather(for city: String)
    func presentWeather(_ weatherData: WeatherData)
    func presentError(_ error: Error)
    func searchWeather(for city: String)
}

// Interactor
protocol MainInteractorProtocol {
    func fetchWeather(for city: String, completion: @escaping (Result<WeatherData, Error>) -> Void)
}



// ViewState
protocol MainViewStateProtocol: ViewStateProtocol {
    var currentTemperature: String { get set }
    var currentHumidity: String { get set }
    var weatherDescription: String { get set }
    var errorMessage: String { get set }
    var weatherData: WeatherData? { get set }
    var searchResults: [WeatherData]? { get set }
    
    func updateWeatherView(temperature: String, humidity: String, description: String)
    func displayError(_ message: String)
    func set(with presenter: MainPresenterProtocol)
}
