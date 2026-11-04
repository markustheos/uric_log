import Foundation
import UserNotifications

enum MeasurementReminderManager {
	private static let identifierPrefix = "uric-acid-measurement-reminder-"

	static func requestAuthorization() async -> Bool {
		do {
			return try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge])
		} catch {
			return false
		}
	}

	static func schedule(weekdays: Set<Int>, hour: Int, minute: Int) async {
		await cancel()
		let content = UNMutableNotificationContent()
		content.title = L10n.string("MEASUREMENT_REMINDER_TITLE")
		content.body = L10n.string("MEASUREMENT_REMINDER_BODY")
		content.sound = .default

		for weekday in weekdays {
			var components = DateComponents()
			components.calendar = .current
			components.weekday = weekday
			components.hour = hour
			components.minute = minute
			let request = UNNotificationRequest(
				identifier: identifierPrefix + String(weekday),
				content: content,
				trigger: UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
			)
			try? await UNUserNotificationCenter.current().add(request)
		}
	}

	static func cancel() async {
		let center = UNUserNotificationCenter.current()
		let requests = await center.pendingNotificationRequests()
		let identifiers = requests.map(\.identifier).filter { $0.hasPrefix(identifierPrefix) }
		center.removePendingNotificationRequests(withIdentifiers: identifiers)
	}
}
