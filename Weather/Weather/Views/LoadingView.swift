//
//  LoadingView.swift
//  Weather
//
//  Created by Marcus Lisman on 5/19/23.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        
        Image("logo")
          .resizable()
          .scaledToFit()
          .aspectRatio(contentMode: .fit)
          .frame(width: 200)
          .padding(.top, 100)
        
        VStack {
            Text("Your weather will be provided shortly!")
                .padding(.bottom, 150)
        }
        
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .white))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
