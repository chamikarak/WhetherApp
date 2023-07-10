import Foundation

class ModelData: ObservableObject {
    @Published var forecast: Forecast?
    @Published var userLocation: String = ""
    @Published var airQualityData: AirQualityModelData?
    
    private var API_KEY = "6148de8cca6a6d04f7c000f0d10dbf8c"
    
    init() {
        self.forecast = load("london.json")
    }
    
    func loadData(lat: Double, lon: Double) async throws -> Forecast {
        let url = URL(string: "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&units=metric&appid=\(API_KEY)")
        let session = URLSession(configuration: .default)
        
        let (data, _) = try await session.data(from: url!)
        
        do {
            //print(data)
            let forecastData = try JSONDecoder().decode(Forecast.self, from: data)
            DispatchQueue.main.async {
                self.forecast = forecastData
            }
            
            return forecastData
        } catch {
            throw error
        }
    }
    
    func load<Forecast: Decodable>(_ filename: String) -> Forecast {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(Forecast.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(Forecast.self):\n\(error)")
        }
    }
    
    func loadAirQualitynData() async throws {
        guard let lat = forecast?.lat, let lon = forecast?.lon else {
            fatalError("Couldn't find in lat & lon values for given location.")
        }
        
        let urlString = "https://api.openweathermap.org/data/2.5/air_pollution?lat=\(lat)&lon=\(lon)&units=metric&appid=\(API_KEY)"
        
        let url = URL(string: urlString)
        
        let session = URLSession(configuration: .default)
        
        let (data, _) = try await session.data(from: url!)
        
        do {
            let polltionData = try JSONDecoder().decode(AirQualityModelData.self, from: data)
            DispatchQueue.main.async {
                self.airQualityData = polltionData
            }
        } catch {
            throw error
        }
    }
    
    func generateWeatherIconURL(icon: String) -> String {
        return "https://openweathermap.org/img/wn/\(icon)@2x.png"
    }
}
