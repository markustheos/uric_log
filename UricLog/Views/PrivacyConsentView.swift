import SwiftUI

struct PrivacyConsentContainer<Content: View>: View {
	@AppStorage(AppSettingsKey.privacyConsentGranted) private var hasConsent = false
	@AppStorage(AppSettingsKey.privacyConsentChoiceMade) private var hasMadeChoice = false
	@State private var countryCode: String?
	@State private var hasTrackedConsentScreen = false
	private let content: Content

	init(@ViewBuilder content: () -> Content) {
		self.content = content()
		_countryCode = State(initialValue: AppStoreRegion.launchCountryCode)
	}

	var body: some View {
		Group {
			if !AppStoreRegion.isMainlandChina(countryCode) || hasMadeChoice {
				content
					.onAppear {
						AppOpenAdManager.shared.startIfAllowed(countryCode: countryCode)
					}
			} else {
				PrivacyConsentView(
					accept: {
						Analytics.track("privacy_consent_accepted")
						hasConsent = true
						hasMadeChoice = true
						AppOpenAdManager.shared.startIfAllowed(countryCode: countryCode)
					},
					decline: {
						Analytics.track("privacy_consent_declined")
						hasConsent = false
						hasMadeChoice = true
					}
				)
				.onAppear {
					guard !hasTrackedConsentScreen else { return }
					hasTrackedConsentScreen = true
					Analytics.track("privacy_consent_shown")
				}
			}
		}
		.task {
			await AppStoreRegion.refreshStorefrontCountryCode()
		}
	}
}

private struct PrivacyConsentView: View {
	let accept: () -> Void
	let decline: () -> Void

	var body: some View {
		ZStack {
			VStack(spacing: 14) {
				Image(systemName: "drop.fill")
					.font(.system(size: 54, weight: .semibold))
					.foregroundStyle(.blue)
				Text("APP_NAME")
					.font(.title.bold())
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.background(Color(.systemGroupedBackground))
			.blur(radius: 2)

			Color.black.opacity(0.32)
				.ignoresSafeArea()

			VStack(spacing: 22) {
				Text("PRIVACY_NOTICE_TITLE")
					.font(.title3.weight(.semibold))
					.multilineTextAlignment(.center)

				VStack(spacing: 10) {
					Text("AD_CONSENT_MESSAGE")
						.font(.body)
						.foregroundStyle(.secondary)
						.multilineTextAlignment(.leading)

					Text("HEALTH_DATA_PRIVACY_MESSAGE")
						.font(.body.weight(.medium))
						.frame(maxWidth: .infinity, alignment: .leading)

					Link(
						"VIEW_PRIVACY_POLICY",
						destination: URL(string: "https://xiaochai.tech/uric_log/privacy-policy.html")!
					)
					.frame(maxWidth: .infinity, alignment: .leading)
				}

				Button("DECLINE", action: decline)
					.buttonStyle(.plain)
					.font(.subheadline)
					.foregroundStyle(.secondary)

				Button(action: accept) {
					Text("AGREE_AND_CONTINUE")
						.font(.headline)
						.frame(maxWidth: .infinity)
						.padding(.vertical, 14)
				}
				.buttonStyle(.borderedProminent)
				.buttonBorderShape(.capsule)
			}
			.padding(24)
			.background(Color(.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 20))
			.shadow(color: .black.opacity(0.2), radius: 24, y: 8)
			.padding(.horizontal, 28)
		}
		.ignoresSafeArea()
	}
}
