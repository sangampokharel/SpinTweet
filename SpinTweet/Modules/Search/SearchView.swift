//
//  SearchView.swift
//  SpinTweet
//
//  Created by sangam pokharel on 18/02/2024.
//

import SwiftUI

struct SearchView: View {
   
   @StateObject private var searchViewModel  = SearchViewModel()
   var body: some View {
       ZStack {
           ScrollView {
               LazyVStack {
                   ForEach(searchViewModel.filteredUsers.isEmpty ? searchViewModel.users : searchViewModel.filteredUsers ){ item in
                       NavigationLink {
                           LazyView(ProfileView(user: item))
                       } label: {
                           SearchCell(user: item)
                               .frame(maxHeight: 100)
                               .padding(.vertical,8)
                               .foregroundStyle(.white)
                       }
                   }
               }
               
           }.padding(.all)
           
           if searchViewModel.isLoading {
               LoadingView()
           }
       }
      
    }
}

#Preview {
    SearchView()
}
