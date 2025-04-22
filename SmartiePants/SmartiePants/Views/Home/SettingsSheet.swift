//
//  SettingsSheet.swift
//  SmartiePants
//
//  Created by Zoe Goldberg on 4/22/25.
//
import SwiftUI

struct SettingsSheetView: View {
    var onLogout: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Settings")
                .font(.poppins(fontStyle: .title, fontWeight: .bold))
                .foregroundColor(.darkBlue)

            Button(action: {
                onLogout()
            }) {
                HStack {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                    Text("Log Out")
                        .font(.poppins(fontStyle: .headline, fontWeight: .semibold))
                }
                .foregroundColor(.red)
                .padding()
                .frame(maxWidth: .infinity)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal)
            }

            Spacer()
        }
        .padding(.top, 30)
        .presentationDetents([.medium])
    }
}

#Preview {
    SettingsSheetView(onLogout: {})
}
