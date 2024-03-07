//
//  NavigationServiceType.swift
//  Weather
//
//  Created by Yerassyl Tynymbay on 05.03.2024
//  
//

import Foundation

protocol NavigationServiceType: ObservableObject, Identifiable {
    var items:[Views] { get set }
    var modalView: Views? { get set }
    var alert: CustomAlert? { get set }
    func pushView(_ view: Views)
}
