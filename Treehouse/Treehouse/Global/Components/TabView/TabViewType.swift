//
//  TabViewType.swift
//  Treehouse
//
//  Created by 윤영서 on 4/26/24.
//

import Foundation
import SwiftUI

struct HomeTab: View {
    var body: some View {
        Text("HomeView")
    }
}

struct TreeTab: View {
    var body: some View {
        Text("TreeView")
    }
}

struct NotificationTab: View {
    var body: some View {
        NotificationView()
    }
}

struct SettingsTab: View {
    var body: some View {
        Text("SettingsView")
    }
}
