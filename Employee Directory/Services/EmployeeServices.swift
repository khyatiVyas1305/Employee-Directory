//
//  EmployeeServices.swift
//  Employee Directory
//
//  Created by Khyati Vyas on 2023-12-06.
//

import Foundation

protocol EmployeeServiceType{
    
    /// This method is responsible for fetching data of type T from a given URL asynchronously
    /// - Parameters:
    ///   - type: Decodable
    ///   - urlString: String, URL to pass
    /// - Returns: Decodable
    func fetch<T: Decodable>(type: T.Type, from urlString: String) async -> T?
    
    /// This method fetches collection of  employees asynchronously
    /// - Returns: An array of employees
    func fetchEmployees() async throws -> [Employee]
}

final class EmployeeServices: EmployeeServiceType{
    
    struct Paths{
        static let employeeURL = "https://s3.amazonaws.com/sq-mobile-interview/employees.json"
    }
    
    func fetch<T>(type: T.Type, from urlString: String) async -> T? where T : Decodable {
        guard let url = URL(string: urlString) else{
            return nil
        }
        
        do{
            let (data, _) = try await URLSession
                .shared
                .data(from: url)
            
            let decoder = JSONDecoder()
            
            return try decoder.decode(type, from: data)
        }catch{
            print("Error: \(error)")
            return nil
        }
    }
    
    func fetchEmployees() async throws -> [Employee] {
        let employees = await fetch(type: EmployeeList.self, from: Paths.employeeURL)
        return employees?.employees ?? []
    }
    
    
}
