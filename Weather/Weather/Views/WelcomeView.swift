//
//  WelcomeView.swift
//  Weather
//
//  Created by Marcus Lisman on 5/19/23.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                
                Image("logo")
                  .resizable()
                  .scaledToFit()
                  .aspectRatio(contentMode: .fit)
                  .frame(width: 200)
                
                Text("AccuSky: The weather accuracy you need, right where you are")
                    .bold().font(.title)
                Text("Please share your current location to get the most up-to-date, accurate weather for your area")
                    .padding()
            }
            .multilineTextAlignment(.center)
            .padding()
            
            LocationButton(.shareCurrentLocation) {
                locationManager.requestLocation()
            }
            .cornerRadius(30)
            .symbolVariant(.fill)
            .foregroundColor(.white)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
