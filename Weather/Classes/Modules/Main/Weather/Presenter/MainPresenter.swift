//
//  MainPresenter.swift
//  Weather
//
//  Created by Yerassyl Tynymbay on 05.03.2024
//  
//

import SwiftUI
import CoreLocation

final class MainPresenter: MainPresenterProtocol {
    private let router: MainRouterProtocol
    private let viewState: MainViewStateProtocol
    private let interactor: MainInteractorProtocol
    private let manager = CLLocationManager()
    
    init(router: MainRouterProtocol, interactor: MainInteractorProtocol, viewState: MainViewStateProtocol) {
        self.router = router
        self.interactor = interactor
        self.viewState = viewState
    }
    
    func getWeather(for city: String) {
        interactor.fetchWeather(for: city) { [weak self] (result: Result<WeatherData, Error>) in
            switch result {
            case .success(let weather):
                self?.presentWeather(weather)
            case .failure(let error):
                self?.presentError(error)
            }
        }
    }
    func searchWeather(for city: String) {
        interactor.fetchWeather(for: city) { result in
            switch result {
            case .success(let weatherData):
               
                DispatchQueue.main.async {
                    self.viewState.searchResults = [weatherData]
                }
            case .failure(let error):
                self.presentError(error)
            }
        }
    }

    
    internal func presentWeather(_ weatherData: WeatherData) {
        let temperature = "\(Int(weatherData.main.temp))°C"
        let humidity = "\(weatherData.main.humidity)%"
        let description = weatherData.weather.first?.description ?? "No description"
        
        DispatchQueue.main.async {
            self.viewState.updateWeatherView(temperature: temperature, humidity: humidity, description: description)
        }
    }
    
    internal func presentError(_ error: Error) {
        let errorMessage: String
        if let networkError = error as? NetworkError {
            switch networkError {
            case .invalidURL:
                errorMessage = "Invalid URL"
            case .invalidResponse:
                errorMessage = "Invalid server response"
            case .noData:
                errorMessage = "No data available"
            case .invalidCity:
                errorMessage = "Invalid city"
            }
        } else {
            errorMessage = error.localizedDescription
        }
        
        DispatchQueue.main.async {
            self.viewState.displayError(errorMessage)
        }
    }
}
