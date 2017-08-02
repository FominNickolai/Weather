//
//  TodayViewController.swift
//  Weather Widget
//
//  Created by Fomin Mykola on 8/2/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import UIKit
import NotificationCenter
import WeatherInfoKit

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var tmperatureLabel: UILabel!
    
    var location = "Paris, France"
        
    override func viewDidLoad() {
        super.viewDidLoad()
        cityLabel.text = location
        
        //Invoke weather service to get the weather data
        WeatherService.sharedWeatherService().getCurrentWeather(location: location) { (data) in
            OperationQueue.main.addOperation({
                if let weatherData = data {
                    self.weatherLabel.text = weatherData.weather.capitalized
                    self.tmperatureLabel.text = String(format: "%d", weatherData.temperature) + "\u{00B0}"
                }
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        
        cityLabel.text = location
        WeatherService.sharedWeatherService().getCurrentWeather(location: location) { (data) in
            guard let weatherData = data else {
                completionHandler(NCUpdateResult.noData)
                return
            }
            OperationQueue.main.addOperation({
                self.weatherLabel.text = weatherData.weather.capitalized
                self.tmperatureLabel.text = String(format: "%d", weatherData.temperature) + "\u{00B0}"
            })
            
            completionHandler(NCUpdateResult.newData)
        }
        
    }
    
}
