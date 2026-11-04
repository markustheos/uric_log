import SwiftUI

struct RootTabView: View {
	@SceneStorage("selectedTab") private var selectedTab = "records"

	var body: some View {
		TabView(selection: $selectedTab) {
			NavigationStack {
				RecordsListView()
			}
			.tag("records")
			.tabItem {
				Label("TAB_RECORDS", systemImage: "list.bullet")
			}

			NavigationStack {
				TrendsView()
			}
			.tag("trends")
			.tabItem {
				Label("TAB_TRENDS", systemImage: "chart.xyaxis.line")
			}

			NavigationStack {
				SettingsView()
			}
			.tag("settings")
			.tabItem {
				Label("TAB_SETTINGS", systemImage: "gearshape")
			}
		}
		.onChange(of: selectedTab) { _, newValue in
			Analytics.track("tab_selected", properties: ["tab": newValue])
		}
	}
}
