import Foundation

class ApiManager {
    static let shared = ApiManager()
    
    private var baseURL: String = ""
    private var defaultHeaders: [String: String] = ["Content-Type": "application/json"]
    
    private init() {}
    
    func configure(baseURL: String, headers: [String: String] = [:]) {
        self.baseURL = baseURL
        self.defaultHeaders.merge(headers) { (_, new) in new }
    }
    
    func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod,
        body: Encodable? = nil,
        headers: [String: String] = [:]
    ) async throws -> T {
        let (data, _) = try await doRequest(endpoint: endpoint, method: method, body: body, headers: headers)
        
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    func request(
        endpoint: String,
        method: HTTPMethod,
        body: Encodable? = nil,
        headers: [String: String] = [:]
    ) async throws {
        let (_, _) = try await doRequest(endpoint: endpoint, method: method, body: body, headers: headers)
    }
    
    private func doRequest(
        endpoint: String,
        method: HTTPMethod,
        body: Encodable? = nil,
        headers: [String: String] = [:]
    ) async throws -> (Data, HTTPURLResponse) {
        guard let url = URL(string: baseURL + endpoint) else {
            throw RestError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        let allHeaders = defaultHeaders.merging(headers) { (_, new) in new }
        allHeaders.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        if let body = body {
            request.httpBody = try JSONEncoder().encode(body)
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw RestError.invalidResponse
        }
        
        return (data, httpResponse)
    }
}

// MARK: - HTTPMethod
enum HTTPMethod: String {
    case GET, POST, PUT, DELETE
}

// MARK: - RestError
enum RestError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
}
