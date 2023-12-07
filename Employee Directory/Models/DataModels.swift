//
//  DataModels.swift
//  Employee Directory
//
//  Created by Khyati Vyas on 2023-12-06.
//

import Foundation

struct Employee: Decodable, Identifiable{
    var id: String
    var full_name: String
    var phone_number: String?
    var email_address: String
    var biography: String?
    var photo_url_small: String?
    var photo_url_large: String?
    var team: String
    var employee_type: EmployeeType
    
    enum EmployeeType: String, Decodable{
        case FULL_TIME
        case PART_TIME
        case CONTRACTOR
    }
}

struct EmployeeList: Decodable{
    let employees: [Employee]
}
