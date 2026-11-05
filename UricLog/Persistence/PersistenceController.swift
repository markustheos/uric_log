import Foundation
import CoreData
import CloudKit
import os

final class PersistenceController: ObservableObject {
	@Published private(set) var isLoaded: Bool = false
	@Published var loadErrorMessage: String?
	@Published var iCloudStatus: String = L10n.string("STATUS_CHECKING")
	@Published var isSyncing: Bool = false
	@Published private(set) var iCloudSyncFailed: Bool = false
	let container: NSPersistentContainer
	private var iCloudEnabled: Bool
	private var lastFailedEventType: NSPersistentCloudKitContainer.EventType?
	private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "tech.xiaochai.uriclog", category: "CloudKit")

	init(iCloudEnabled: Bool) {
		self.iCloudEnabled = iCloudEnabled
		self.container = Persistence.buildContainer(iCloudEnabled: iCloudEnabled)
		
		if iCloudEnabled {
			checkiCloudStatus()
			setupCloudKitMonitoring()
		} else {
			self.iCloudStatus = L10n.string("STATUS_DISABLED")
		}
		
		DispatchQueue.global(qos: .userInitiated).async {
			self.container.loadPersistentStores { _, error in
				if let error {
					if iCloudEnabled {
						UserDefaults.standard.set(false, forKey: AppSettingsKey.iCloudEnabled)
						DispatchQueue.main.async {
							self.loadErrorMessage = L10n.format("ICLOUD_LOAD_ERROR", error.localizedDescription)
							self.iCloudStatus = L10n.string("STATUS_CONNECTION_FAILED")
						}
						let local = Persistence.buildContainer(iCloudEnabled: false)
						local.loadPersistentStores { _, localError in
							if let localError {
								fatalError("Failed to load local persistent stores: \(localError)")
							}
							local.viewContext.automaticallyMergesChangesFromParent = true
							local.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
							DispatchQueue.main.async {
								self.isLoaded = true
							}
						}
						return
					}
					fatalError("Failed to load persistent stores: \(error)")
				}
				self.container.viewContext.automaticallyMergesChangesFromParent = true
				self.container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
				DispatchQueue.main.async {
					self.isLoaded = true
					if iCloudEnabled {
						self.iCloudStatus = L10n.string("STATUS_CONNECTED")
					}
				}
			}
		}
	}
	
	private func checkiCloudStatus() {
		CKContainer.default().accountStatus { status, error in
			DispatchQueue.main.async {
				switch status {
				case .available:
					self.iCloudStatus = L10n.string("ICLOUD_ACCOUNT_AVAILABLE")
				case .noAccount:
					self.iCloudStatus = L10n.string("ICLOUD_NOT_SIGNED_IN")
				case .restricted:
					self.iCloudStatus = L10n.string("ICLOUD_ACCOUNT_RESTRICTED")
				case .couldNotDetermine:
					self.iCloudStatus = L10n.string("ICLOUD_STATUS_UNDETERMINED")
                case .temporarilyUnavailable:
                    self.iCloudStatus = L10n.string("STATUS_TEMPORARILY_UNAVAILABLE")
                @unknown default:
					self.iCloudStatus = L10n.string("STATUS_UNKNOWN")
				}
				
				if let error {
					self.iCloudStatus = L10n.format("ERROR_MESSAGE", error.localizedDescription)
				}
			}
		}
	}
	
	private func setupCloudKitMonitoring() {
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(handleCloudKitEvent),
			name: NSPersistentCloudKitContainer.eventChangedNotification,
			object: container
		)
	}
	
	@objc private func handleCloudKitEvent(_ notification: Notification) {
		guard let event = notification.userInfo?[NSPersistentCloudKitContainer.eventNotificationUserInfoKey] as? NSPersistentCloudKitContainer.Event else { return }
		
		DispatchQueue.main.async {
			switch event.type {
			case .setup:
				self.iCloudStatus = L10n.string("STATUS_INITIALIZING")
			case .import:
				self.isSyncing = true
				self.iCloudStatus = L10n.string("STATUS_IMPORTING")
			case .export:
				self.isSyncing = true
				self.iCloudStatus = L10n.string("STATUS_SYNCING")
			default:
				break
			}
			
			if event.endDate != nil {
				self.isSyncing = false
				if event.succeeded {
					// A setup/import success must not hide a failure of another event type.
					if self.lastFailedEventType == event.type {
						self.lastFailedEventType = nil
						self.iCloudSyncFailed = false
					}
					if self.lastFailedEventType == nil {
						self.iCloudStatus = L10n.string("STATUS_SYNC_COMPLETE")
					}
				} else {
					let message = self.userFacingMessage(for: event.error)
					self.lastFailedEventType = event.type
					self.iCloudSyncFailed = true
					self.iCloudStatus = L10n.format("ICLOUD_SYNC_ERROR", message)
					self.logger.error(
						"CloudKit \(String(describing: event.type), privacy: .public) failed: \(String(describing: event.error), privacy: .public)"
					)
				}
			}
		}
	}

	private func userFacingMessage(for error: Error?) -> String {
		guard let error else { return L10n.string("ICLOUD_CONNECTION_ERROR") }

		let nsError = error as NSError
		guard nsError.domain == CKErrorDomain,
			let code = CKError.Code(rawValue: nsError.code) else {
			return L10n.string("ICLOUD_CONNECTION_ERROR")
		}

		switch code {
		case .notAuthenticated:
			return L10n.string("ICLOUD_SIGN_IN_REQUIRED")
		case .networkUnavailable, .networkFailure:
			return L10n.string("NETWORK_UNAVAILABLE")
		case .serviceUnavailable:
			return L10n.string("ICLOUD_SERVICE_UNAVAILABLE")
		case .requestRateLimited:
			if let retryAfter = nsError.userInfo[CKErrorRetryAfterKey] as? TimeInterval {
				return L10n.format("ICLOUD_RETRY_AFTER", max(1, Int(retryAfter.rounded())))
			}
			return L10n.string("ICLOUD_RATE_LIMITED")
		case .quotaExceeded:
			return L10n.string("ICLOUD_STORAGE_FULL")
		case .permissionFailure:
			return L10n.string("ICLOUD_PERMISSION_DENIED")
		case .accountTemporarilyUnavailable:
			return L10n.string("ICLOUD_ACCOUNT_UNAVAILABLE")
		case .zoneNotFound, .unknownItem:
			return L10n.string("ICLOUD_DATA_NOT_READY")
		case .serverRejectedRequest, .invalidArguments:
			return L10n.string("ICLOUD_CONFIGURATION_ERROR")
		case .partialFailure:
			return L10n.string("ICLOUD_PARTIAL_SYNC_ERROR")
		default:
			return L10n.string("ICLOUD_CONNECTION_ERROR")
		}
	}

	func refreshLocalizedStatus() {
		if !iCloudEnabled {
			iCloudStatus = L10n.string("STATUS_DISABLED")
		} else if iCloudSyncFailed {
			iCloudStatus = L10n.format("ICLOUD_SYNC_ERROR", L10n.string("ICLOUD_CONNECTION_ERROR"))
		} else if isSyncing {
			iCloudStatus = L10n.string("STATUS_SYNCING")
		} else {
			iCloudStatus = L10n.string("STATUS_CONNECTED")
		}
	}
	
	deinit {
		NotificationCenter.default.removeObserver(self)
	}
}
