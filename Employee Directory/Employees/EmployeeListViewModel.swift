//
//  EmployeeListViewModel.swift
//  Employee Directory
//
//  Created by Khyati Vyas on 2023-12-07.
//

import SwiftUI

final class EmployeeListViewModel: ObservableObject {
    private let service: EmployeeServiceType
    @Published private(set) var employees: [Employee] = []
    @Published private(set) var isLoading: Bool = false
    
    init(service: EmployeeServiceType = EmployeeServices()) {
        self.service = service
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
}
