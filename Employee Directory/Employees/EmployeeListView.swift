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
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .fullScreenCover(isPresented: $onboardingRequired, onDismiss:{
            onboardingRequired = false
        }, content: {
            OnbordingView(onboardingRequired: $onboardingRequired)
        })
//        .sheet(isPresented: $onboardingRequired, onDismiss:{ onboardingRequired = false
//        }, content:{
//            OnbordingView(onboardingRequired: $onboardingRequired)
//        })
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
