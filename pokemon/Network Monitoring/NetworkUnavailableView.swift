//
//  NetworkUnavailableView.swift
//  pokemon
//
//  Created by Tamás Balla on 2024. 12. 11..
//
// Source: https://medium.com/@husnainali593/how-to-check-network-connection-in-swiftui-using-nwpathmonitor-8f6cd4777514


import SwiftUI

struct NetworkUnavailableView: View {
    var body: some View {
        ContentUnavailableView(
            "No Internet Connection",
            systemImage: "wifi.exclamationmark",
            description: Text("Please check your connection and try again.")
        )
    }
}
