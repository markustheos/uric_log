import Foundation
import StoreKit

enum AppStoreRegion {
	static var localeCountryCode: String? {
		Locale.current.region?.identifier
	}

	static var cachedStorefrontCountryCode: String? {
		UserDefaults.standard.string(forKey: AppSettingsKey.cachedStorefrontCountryCode)
	}

	static var launchCountryCode: String? {
		if isMainlandChina(localeCountryCode) {
			return localeCountryCode
		}
		return cachedStorefrontCountryCode ?? localeCountryCode
	}

	static func resolveCountryCode() async -> String? {
		for attempt in 0..<4 {
			if let countryCode = await Storefront.current?.countryCode {
				return countryCode
			}
			if attempt < 3 {
				try? await Task.sleep(for: .milliseconds(250 * (attempt + 1)))
			}
		}
		return nil
	}

	static func refreshStorefrontCountryCode() async {
		guard let countryCode = await resolveCountryCode() else { return }
		UserDefaults.standard.set(countryCode, forKey: AppSettingsKey.cachedStorefrontCountryCode)
	}

	static func isMainlandChina(_ countryCode: String?) -> Bool {
		countryCode == "CHN" || countryCode == "CN"
	}
}

enum UricUnit: String, CaseIterable, Identifiable, Codable {
	case umolL
	case mgdL

	var id: String { rawValue }

	var displayName: String {
		switch self {
		case .umolL:
			return "μmol/L"
		case .mgdL:
			return "mg/dL"
		}
	}

	static func convert(value: Double, from: UricUnit, to: UricUnit) -> Double {
		guard from != to else { return value }
		switch (from, to) {
		case (.umolL, .mgdL):
			return value / 59.48
		case (.mgdL, .umolL):
			return value * 59.48
		default:
			return value
		}
	}
}

enum AppSettingsKey {
	static let appLanguage = "appLanguage"
	static let preferredUnit = "preferredUnit"
	static let userGender = "userGender"
	static let targetEnabled = "targetEnabled"
	static let targetValue = "targetValue"
	static let selectedTimeRange = "selectedTimeRange"
	static let iCloudEnabled = "iCloudEnabled"
	static let cachedStorefrontCountryCode = "cachedStorefrontCountryCode"
	static let measurementReminderEnabled = "measurementReminderEnabled"
	static let measurementReminderWeekdays = "measurementReminderWeekdays"
	static let measurementReminderHour = "measurementReminderHour"
	static let measurementReminderMinute = "measurementReminderMinute"

	static let legacyKeys = [
		preferredUnit,
		userGender,
		targetEnabled,
		targetValue,
		iCloudEnabled,
	]
}

enum UserGender: String, CaseIterable, Identifiable, Codable {
	case male
	case female
	
	var id: String { rawValue }
	
	var displayName: String {
		switch self {
		case .male:
			return L10n.string("SEX_MALE")
		case .female:
			return L10n.string("SEX_FEMALE")
		}
	}
	
	/// 正常范围上限（μmol/L）
	var normalRangeUpper: Double {
		switch self {
		case .male:
			return 428
		case .female:
			return 357
		}
	}
	
	/// 正常范围下限（μmol/L）
	var normalRangeLower: Double {
		switch self {
		case .male:
			return 208
		case .female:
			return 155
		}
	}
	
	/// 获取当前单位的正常范围显示文本
	func normalRangeText(unit: UricUnit) -> String {
		let lower = UricUnit.convert(value: normalRangeLower, from: .umolL, to: unit)
		let upper = UricUnit.convert(value: normalRangeUpper, from: .umolL, to: unit)
		let format = unit == .umolL ? "%.0f" : "%.1f"
		return String(
			format: "\(format)-\(format) \(unit.displayName)",
			locale: AppLanguage.selected.locale, lower, upper
		)
	}
}

enum TimeRange: String, CaseIterable, Identifiable {
	case days7
	case days30
	case days90
	case all

	var id: String { rawValue }

	var displayName: String {
		switch self {
		case .days7:
			return L10n.string("RANGE_7_DAYS")
		case .days30:
			return L10n.string("RANGE_30_DAYS")
		case .days90:
			return L10n.string("RANGE_90_DAYS")
		case .all:
			return L10n.string("RANGE_ALL")
		}
	}

	func startDate(now: Date = Date()) -> Date? {
		let calendar = Calendar.current
		switch self {
		case .days7:
			return calendar.date(byAdding: .day, value: -7, to: now)
		case .days30:
			return calendar.date(byAdding: .day, value: -30, to: now)
		case .days90:
			return calendar.date(byAdding: .day, value: -90, to: now)
		case .all:
			return nil
		}
	}
}
