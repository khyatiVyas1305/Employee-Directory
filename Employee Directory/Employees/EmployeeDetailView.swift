//
//  EmployeeDetailView.swift
//  Employee Directory
//
//  Created by Khyati Vyas on 2023-12-07.
//

import SwiftUI

struct EmployeeDetailView: View {
   
    var employee: Employee
    var body: some View {
        VStack{
            VStack{
                Text(employee.full_name)
                    .padding(.leading,50)
                    .padding(.trailing,50)
                    .frame(alignment: .center)
                    .font(.largeTitle)
                AsyncImage(url: URL(string: employee.photo_url_large!)){ image in
                    image
                        .image?.resizable()
                        .scaledToFit()
                        .frame(width: 360, height: 400)
                        .clipShape(Circle())
                }
            }
            
            Text("\"\(employee.biography!)\"")
                .padding(.leading)
                .padding(.trailing,80)
                .font(.headline)
                .fontDesign(.rounded)
                .foregroundStyle(.brown)
                
            HStack{
                Text(employee.employee_type.rawValue)
                    .foregroundStyle(.white)
                    .background(.blue)
                Text(employee.team)
                    .foregroundStyle(.white)
                    .background(.mint)
            }
            .padding(.leading)
            .padding(.trailing,160)
            .padding(.top,5)
            VStack{
            
                HStack{
                    Image(systemName: "envelope.circle.fill")
                        .foregroundStyle(.primary)
                        .font(.headline)
                    Text(employee.email_address)
                        .foregroundStyle(.primary)
                }
                .padding(.leading)
                .padding(.trailing,90)
                .padding(.top,5)
                
                HStack{
                    Image(systemName: "phone.circle.fill")
                        .foregroundStyle(.primary)
                        .font(.headline)
                    Text(employee.phone_number!)
                        .foregroundStyle(.primary)
                }
                .padding(.leading)
                .padding(.trailing,210)
                .padding(.top,5)
                
            }
                
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            
             
        }
    }
}

#Preview {
    EmployeeDetailView(employee: Employee(id: "", full_name: "", email_address: "", photo_url_small: "", team: "", employee_type: .CONTRACTOR))
}
