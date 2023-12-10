//
//  EmployeeListView.swift
//  Employee Directory
//
//  Created by Khyati Vyas on 2023-12-06.
//

import SwiftUI

struct EmployeeListView: View {
    
    
    @AppStorage("onboardingRequired") var onboardingRequired: Bool = true
    @ObservedObject var viewModel: EmployeeListViewModel
    @State private var selectedTab = 0
    
    init( viewModel: EmployeeListViewModel = EmployeeListViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        TabView{
            NavigationStack{
                if viewModel.isLoading{
                    ProgressView("Hang tight! Fetching Employee list...")
                        .progressViewStyle(CircularProgressViewStyle())
                }else{
                    listViewContent
                }
            }
            .fullScreenCover(isPresented: $onboardingRequired, onDismiss:{
                onboardingRequired = false
            }, content: {
                OnbordingView(onboardingRequired: $onboardingRequired)
            })
            .onAppear(){
                Task{
                    await viewModel.fetchEmployees()
                }
                
            }
            .tabItem {
                Label("Employees", systemImage: "person.3")
            }
            .tag(0)
            
            SettingsView()
            .tabItem{
                Label("Settings", systemImage: "gear")
            }
            .tag(1)
        }
    }
    
    //All the list view code will go here.
    @ViewBuilder
    var listViewContent: some View{
        List(viewModel.employeeResults){ employee in
            NavigationLink {
                EmployeeDetailView(employee: employee)
            }label: {
                AsyncImage(url: URL(string: employee.photo_url_small)){ image in
                    image
                        .image?.resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                }
                VStack(spacing: 0){
                    Text(employee.full_name)
                        .bold()
                    Text(employee.team)
                        .foregroundStyle(.gray)
                }.padding(.all, 0)
                
            }
        }
        .refreshable {
           await viewModel.fetchEmployees()
        }
        .navigationTitle("Employees")
        .searchable(text: $viewModel.searchTerm,
                    placement: .navigationBarDrawer(displayMode: .automatic),
                    prompt: "Search for Employees")
        .onChange(of: viewModel.searchTerm){ _, n in
            print("search: \(n)")
            viewModel.filterSearchResults()
        }
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
