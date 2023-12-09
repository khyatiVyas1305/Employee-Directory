//
//  EmployeeListViewModel.swift
//  Employee Directory
//
//  Created by Khyati Vyas on 2023-12-07.
//

import SwiftUI
import Observation

@Observable
final class EmployeeListViewModel: ObservableObject {
    private let service: EmployeeServiceType
    private(set) var employees: [Employee] = []
    private(set) var isLoading: Bool = false
    var searchResults: [Employee] = []
    var searchTerm: String = ""
    
    init(service: EmployeeServiceType = EmployeeServices()) {
        self.service = service
    }
    
    var employeeResults: [Employee] {
        return searchTerm.isEmpty ? employees : searchResults
    }
    
    @MainActor
    func fetchEmployees() async {
        do{
            isLoading = true
            employees = try await service.fetchEmployees() 
            isLoading = false
        }catch{
            print("Error: \(error)")
        }
    }
    
    //Filters search result
    func filterSearchResults(){
        searchResults = employees.filter({
            $0.full_name.localizedCaseInsensitiveContains(searchTerm)
        })
    }
}
