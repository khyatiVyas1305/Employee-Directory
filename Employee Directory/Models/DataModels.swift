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
    var photo_url_small: String
    var photo_url_large: String?
    var team: String
    var employee_type: EmployeeType
    
    enum EmployeeType: String, Decodable{
        case FULL_TIME
        case PART_TIME
        case CONTRACTOR
    }
    
    enum CodingKeys: String, CodingKey{
        case id = "uuid"
        case full_name
        case phone_number
        case email_address
        case biography
        case photo_url_small
        case photo_url_large
        case team
        case employee_type
    }
}

struct EmployeeList: Decodable{
    let employees: [Employee]
}
