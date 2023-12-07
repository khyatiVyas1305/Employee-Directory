//
//  EmployeeListView.swift
//  Employee Directory
//
//  Created by Khyati Vyas on 2023-12-06.
//

import SwiftUI

struct EmployeeListView: View {
    
    //REMEMBER TO CHANGE THIS TO FALSE TO GET ONBOARDING BACK
    @AppStorage("onboardingRequired") var onboardingRequired: Bool = false
    @ObservedObject var viewModel: EmployeeListViewModel
    init( viewModel: EmployeeListViewModel = EmployeeListViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack{
            if viewModel.isLoading{
                ProgressView("Hang tight! Fetching Employee list...")
                    .progressViewStyle(CircularProgressViewStyle())
            }else{
                listViewContent
            }
        }
        .onAppear(){
            Task{
                await viewModel.fetchEmployees()
            }
        }
        .fullScreenCover(isPresented: $onboardingRequired, onDismiss:{
            onboardingRequired = false
        }, content: {
            OnbordingView(onboardingRequired: $onboardingRequired)
        })
    }
    
    //All the list view code will go here.
    @ViewBuilder
    var listViewContent: some View{
        List(viewModel.employees){ employee in
            NavigationLink {
                Text("Hello")
            }label: {
                AsyncImage(url: URL(string: employee.photo_url_small)){ image in
                    image
                        .image?.resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                }
                Text(employee.full_name)
            }
        }
        .navigationTitle("Employees")
        .listStyle(.insetGrouped)
    }
}

#Preview {
    EmployeeListView()
}

struct OnbordingView: View {
    @Binding var onboardingRequired: Bool
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [ .cyan,.blue, .primary]), startPoint: .topLeading, endPoint: .bottomTrailing)
            
            VStack{
                Spacer()
                Text("Employee List")
                    .foregroundStyle(Color(.white))
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding(.top)
                Spacer()
                Text("This application shows the list of employees who are fetched from the network. You can search employees by name and view their details by pressing them.")
                    .foregroundStyle(Color(.white))
                    .font(.subheadline)
                    .frame(maxWidth: 338)
                Button(action: {
                    onboardingRequired = false
                }, label: {
                    Text("Continue")
                        .frame(maxWidth: 340)
                })
                .buttonStyle(.borderedProminent)
                .tint(.white)
                .foregroundColor(.primary)
                .padding(.horizontal,20)
                .padding(.bottom, 40)
                .controlSize(.large)
                
                
            }
        }.ignoresSafeArea()
    }
}
