import SwiftUI
import CoreData

struct RecordEditorView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var viewContext
	@FocusState private var focusedField: FocusField?

    @AppStorage(AppSettingsKey.preferredUnit) private var preferredUnitRawValue = UricUnit.umolL.rawValue
    @AppStorage(AppSettingsKey.userGender) private var userGenderRawValue = UserGender.male.rawValue

    private let record: UricAcidRecordEntity?

    @State private var valueText: String = ""
    @State private var selectedUnit: UricUnit = .umolL
    @State private var measuredAt: Date = Date()
    @State private var draftMeasuredAt: Date = Date()
    @State private var note: String = ""
    @State private var showingExtremeConfirm = false
    @State private var showingReferenceInfo = false
	@State private var showingDatePicker = false
    @State private var pendingSaveValue: Double?

	private enum FocusField: Hashable {
		case value
		case note
	}

    init(record: UricAcidRecordEntity?) {
        self.record = record
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // 数值输入卡片
                valueInputCard
                
                // 参考范围卡片
                referenceRangeCard
                
                // 时间选择卡片
                timeSelectionCard
                
                // 备注卡片
                noteCard
                
                // 保存按钮
                saveButton
            }
            .padding()
			.contentShape(Rectangle())
			.onTapGesture {
				focusedField = nil
			}
        }
		.scrollDismissesKeyboard(.interactively)
        .background(Color(.systemGroupedBackground))
        .navigationTitle(L10n.string(record == nil ? "ADD_RECORD" : "EDIT_RECORD"))
        .navigationBarTitleDisplayMode(.large)
	        .toolbar {
	            ToolbarItem(placement: .cancellationAction) {
	                Button("CANCEL") {
	                    Analytics.track("record_editor_cancelled", properties: ["mode": editorMode])
	                    dismiss()
	                }
	            }
	        }
	        .alert("UNUSUAL_VALUE_TITLE", isPresented: $showingExtremeConfirm) {
	            Button("CANCEL", role: .cancel) {
	                Analytics.track("extreme_value_save_cancelled", properties: ["mode": editorMode])
	                pendingSaveValue = nil
	            }
	            Button("SAVE_ANYWAY", role: .destructive) {
	                Analytics.track("extreme_value_save_confirmed", properties: ["mode": editorMode])
                if let value = pendingSaveValue {
                    save(value: value)
                }
                pendingSaveValue = nil
            }
        } message: {
            Text("UNUSUAL_VALUE_MESSAGE")
        }
        .sheet(isPresented: $showingReferenceInfo) {
            ReferenceInfoSheet()
        }
		.sheet(isPresented: $showingDatePicker) {
			measurementTimePicker
				.presentationDetents([.medium])
				.presentationDragIndicator(.visible)
		}
        .onAppear {
            selectedUnit = UricUnit(rawValue: preferredUnitRawValue) ?? .umolL
            if let record {
                measuredAt = record.measuredAt
                selectedUnit = record.unit
                valueText = String(format: "%.0f", record.value)
                note = record.note ?? ""
            }
        }
    }
    
    private var valueInputCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "drop.fill")
                    .foregroundStyle(.blue)
                    .font(.title2)
                
                Text("URIC_ACID_VALUE")
                    .font(.headline)
                
                Spacer()
            }
            
            HStack(spacing: 12) {
                TextField("VALUE_PLACEHOLDER", text: $valueText)
                    .keyboardType(.decimalPad)
					.focused($focusedField, equals: .value)
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .frame(height: 60)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.blue.opacity(0.05))
                    )
                
                VStack(spacing: 8) {
	                    ForEach(UricUnit.allCases) { unit in
	                        Button {
							focusedField = nil
	                            Analytics.track("record_unit_selected", properties: ["unit": unit.rawValue])
	                            selectedUnit = unit
                        } label: {
                            Text(unit.displayName)
                                .font(.caption)
                                .fontWeight(selectedUnit == unit ? .bold : .regular)
                                .foregroundStyle(selectedUnit == unit ? .white : .primary)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(selectedUnit == unit ? Color.blue : Color(.systemGray5))
                                )
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemGroupedBackground))
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
        )
    }
    
    private var referenceRangeCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "info.circle.fill")
                    .foregroundStyle(.cyan)
                    .font(.title3)
                
                Text("REFERENCE_RANGE")
                    .font(.headline)
                
                Spacer()
                
	                Button {
	                    Analytics.track("reference_info_opened")
	                    showingReferenceInfo = true
                } label: {
                    Image(systemName: "questionmark.circle")
                        .foregroundStyle(.secondary)
                }
				.accessibilityLabel("SOURCES_AND_REFERENCES")
            }
            
            // 当前性别对应的正常范围
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(L10n.format("PERSONAL_REFERENCE_RANGE", userGender.displayName))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    Spacer()
                }
                
                Text(userGender.normalRangeText(unit: selectedUnit))
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundStyle(.cyan)
			Text("SOURCES_HINT")
				.font(.caption)
				.foregroundStyle(.secondary)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.cyan.opacity(0.08))
            )
            
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemGroupedBackground))
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
        )
    }
    
    private func referenceRow(icon: String, color: Color, title: String, description: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundStyle(color)
                .font(.title3)
            
            Text(LocalizedStringKey(title))
                .font(.system(size: 15, weight: .medium))
            
            Spacer()
            
            Text(LocalizedStringKey(description))
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
    
    private func goutControlHint(umolValue: Double) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Divider()
                .padding(.vertical, 4)
            
            Text("GOUT_CONTROL_TARGETS")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("GOUT")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text("< 360 μmol/L")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(umolValue < 360 ? .green : .secondary)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("TOPHI_OR_FREQUENT_FLARES")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text("< 300 μmol/L")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(umolValue < 300 ? .green : .secondary)
                }
                
                Spacer()
            }
        }
    }
    
    private var timeSelectionCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "calendar")
                    .foregroundStyle(.blue)
                    .font(.title3)
                
                Text("MEASUREMENT_TIME")
                    .font(.headline)
                
                Spacer()
            }
            
			Button {
				focusedField = nil
				draftMeasuredAt = measuredAt
				showingDatePicker = true
			} label: {
				HStack(spacing: 12) {
					Text(measuredAt.chineseDateTime)
						.font(.system(size: 17, weight: .medium))
						.foregroundStyle(.primary)
					Spacer()
					Image(systemName: "chevron.right")
						.font(.caption)
						.foregroundStyle(.tertiary)
				}
				.padding(14)
				.background(
					RoundedRectangle(cornerRadius: 10)
						.fill(Color(.systemBackground))
				)
			}
			.buttonStyle(.plain)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemGroupedBackground))
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
        )
    }
    
    private var noteCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "text.alignleft")
                    .foregroundStyle(.blue)
                    .font(.title3)
                
                Text("NOTES")
                    .font(.headline)
                
                Spacer()
                
                Text("OPTIONAL")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            TextField("NOTE_PLACEHOLDER", text: $note, axis: .vertical)
				.focused($focusedField, equals: .note)
                .lineLimit(3...5)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemBackground))
                )
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemGroupedBackground))
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
        )
    }

	private var measurementTimePicker: some View {
		NavigationStack {
			VStack(spacing: 18) {
				Text(draftMeasuredAt.chineseDateTime)
					.font(.system(size: 19, weight: .semibold))
					.frame(maxWidth: .infinity)
					.padding(.top, 8)

				HStack(spacing: 10) {
					quickDateButton("TODAY", dayOffset: 0)
					quickDateButton("YESTERDAY", dayOffset: -1)
					Button("NOW") { draftMeasuredAt = Date() }
						.font(.subheadline.weight(.semibold))
						.frame(maxWidth: .infinity)
						.padding(.vertical, 10)
						.background(Color.blue.opacity(0.1))
						.clipShape(RoundedRectangle(cornerRadius: 8))
						.buttonStyle(.plain)
				}

				VStack(spacing: 0) {
					datePickerRow(title: "DATE", components: .date)
					Divider().padding(.leading, 16)
					datePickerRow(title: "TIME", components: .hourAndMinute)
				}
				.background(Color(.secondarySystemGroupedBackground))
				.clipShape(RoundedRectangle(cornerRadius: 12))

				Label("DATE_PICKER_YEAR_HINT", systemImage: "calendar.badge.clock")
					.font(.caption)
					.foregroundStyle(.secondary)
					.frame(maxWidth: .infinity, alignment: .leading)
				Spacer(minLength: 0)
			}
			.padding(.horizontal)
			.navigationTitle("SELECT_MEASUREMENT_TIME")
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItem(placement: .cancellationAction) {
					Button("CANCEL") { showingDatePicker = false }
				}
				ToolbarItem(placement: .confirmationAction) {
					Button("DONE") {
						measuredAt = draftMeasuredAt
						showingDatePicker = false
					}
				}
			}
		}
	}

	private func datePickerRow(title: LocalizedStringKey, components: DatePickerComponents) -> some View {
		HStack {
			Text(title)
				.font(.body.weight(.medium))
			Spacer()
			DatePicker("", selection: $draftMeasuredAt, displayedComponents: components)
				.datePickerStyle(.compact)
				.labelsHidden()
		}
		.padding(.horizontal, 16)
		.frame(minHeight: 54)
	}

	private func quickDateButton(_ title: LocalizedStringKey, dayOffset: Int) -> some View {
		Button {
			let calendar = Calendar.current
			guard let targetDay = calendar.date(byAdding: .day, value: dayOffset, to: Date()) else { return }
			let day = calendar.dateComponents([.year, .month, .day], from: targetDay)
			let time = calendar.dateComponents([.hour, .minute], from: draftMeasuredAt)
			var components = DateComponents()
			components.year = day.year
			components.month = day.month
			components.day = day.day
			components.hour = time.hour
			components.minute = time.minute
			if let date = calendar.date(from: components) {
				draftMeasuredAt = date
			}
		} label: {
			Text(title)
				.font(.subheadline.weight(.semibold))
				.frame(maxWidth: .infinity)
				.padding(.vertical, 10)
				.background(Color.blue.opacity(0.1))
				.clipShape(RoundedRectangle(cornerRadius: 8))
		}
		.buttonStyle(.plain)
	}
    
    private var saveButton: some View {
        Button {
            saveTapped()
        } label: {
            HStack {
                Image(systemName: "checkmark.circle.fill")
                Text("SAVE")
                    .fontWeight(.semibold)
            }
            .font(.headline)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 54)
            .background(
                LinearGradient(
                    colors: [.blue, .blue.opacity(0.8)],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: .blue.opacity(0.3), radius: 8, x: 0, y: 4)
        }
        .disabled(parsedValue == nil || parsedValue ?? 0 <= 0)
        .opacity(parsedValue == nil || parsedValue ?? 0 <= 0 ? 0.6 : 1)
    }

    private var parsedValue: Double? {
        Double(valueText.replacingOccurrences(of: ",", with: "."))
    }
    
    private var userGender: UserGender {
        UserGender(rawValue: userGenderRawValue) ?? .male
    }

	    private func saveTapped() {
	        guard let value = parsedValue, value > 0 else { return }
	        Analytics.track("record_save_tapped", properties: ["mode": editorMode])
	        if looksExtreme(value: value, unit: selectedUnit) {
	            Analytics.track("extreme_value_warning_shown", properties: ["mode": editorMode])
            pendingSaveValue = value
            showingExtremeConfirm = true
            return
        }
        save(value: value)
    }

    private func looksExtreme(value: Double, unit: UricUnit) -> Bool {
        let umolValue = UricUnit.convert(value: value, from: unit, to: .umolL)
        return umolValue < 50 || umolValue > 1200
    }
    
    private func formatValue(_ value: Double) -> String {
        let converted = UricUnit.convert(value: value, from: .umolL, to: selectedUnit)
        if selectedUnit == .umolL {
            return String(format: "%.0f", converted)
        } else {
            return String(format: "%.1f", converted)
        }
    }

    private func save(value: Double) {
        if let record {
            record.measuredAt = measuredAt
            record.value = value
            record.unit = selectedUnit
            record.note = note.trimmingCharacters(in: .whitespacesAndNewlines)
            record.updatedAt = Date()
        } else {
            _ = UricAcidRecordEntity.create(
                in: viewContext,
                measuredAt: measuredAt,
                value: value,
                unit: selectedUnit,
                note: note.trimmingCharacters(in: .whitespacesAndNewlines)
            )
        }
	        do {
	            try viewContext.save()
	            Analytics.track("record_saved", properties: ["mode": editorMode])
	            dismiss()
	        } catch {
	            Analytics.track("record_save_failed", properties: ["mode": editorMode])
	        }
	    }

	private var editorMode: String {
		record == nil ? "create" : "edit"
	}
}

// MARK: - 参考信息详情页
struct ReferenceInfoSheet: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // 单位换算说明
                    unitConversionSection
                    
                    // 正常范围
                    normalRangeSection
                    
                    // 注意事项
                    noticeSection
					
					sourcesSection
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
			.navigationTitle("REFERENCE_INFORMATION")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
	                    Button("DONE") {
	                        Analytics.track("reference_info_closed")
	                        dismiss()
	                    }
                }
            }
        }
    }
    
    private var unitConversionSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "ruler.fill")
                    .foregroundStyle(.blue)
                Text("UNIT_CONVERSION")
                    .font(.headline)
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("1 mg/dL ≈ 59.48 μmol/L")
                    .font(.system(size: 16, weight: .medium))
                Text("COMMON_UNITS")
                    .font(.caption)
                    .foregroundStyle(.secondary)
				Text("UNIT_CONVERSION_DESCRIPTION")
					.font(.caption)
					.foregroundStyle(.secondary)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.secondarySystemGroupedBackground))
            )
        }
    }
    
    private var normalRangeSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "person.2.fill")
                    .foregroundStyle(.green)
				Text("ADULT_REFERENCE_RANGES")
                    .font(.headline)
                Spacer()
            }
			
			Text("REFERENCE_RANGE_DISCLAIMER")
				.font(.caption)
				.foregroundStyle(.secondary)
            
			VStack(spacing: 12) {
				normalRangeRow(
					title: "ADULT_MEN",
					range: "208～428 μmol/L",
					subRange: "(3.5～7.2 mg/dL)"
				)
				
				normalRangeRow(
					title: "ADULT_WOMEN",
					range: "155～357 μmol/L",
					subRange: "(2.6～6.0 mg/dL)"
				)
			}
        }
    }
    
    private func normalRangeRow(title: String, range: String, subRange: String) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(LocalizedStringKey(title))
                    .font(.system(size: 15, weight: .medium))
                Text(LocalizedStringKey(subRange))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Text(range)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.green)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.secondarySystemGroupedBackground))
        )
    }
    
    private var noticeSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundStyle(.yellow)
                Text("IMPORTANT_NOTES")
                    .font(.headline)
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 8) {
				Text("DISCLAIMER_PERSONAL_USE")
					.font(.caption)
					.foregroundStyle(.orange)
                Text("DISCLAIMER_FASTING_ADULTS")
                    .font(.caption)
                Text("DISCLAIMER_LAB_VARIATION")
                    .font(.caption)
                Text("DISCLAIMER_LAB_REFERENCE")
                    .font(.caption)
                Text("DISCLAIMER_CONSULT_DOCTOR")
                    .font(.caption)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.secondarySystemGroupedBackground))
            )
        }
    }
	
	private var sourcesSection: some View {
		VStack(alignment: .leading, spacing: 12) {
			HStack {
				Image(systemName: "book.fill")
					.foregroundStyle(.indigo)
				Text("SOURCES_AND_REFERENCES")
					.font(.headline)
				Spacer()
			}
			
			VStack(alignment: .leading, spacing: 10) {
				Link("SOURCE_GOUT_GUIDELINE_2019", destination: URL(string: "https://seleguide.yiigle.com/uploads/guide_html/%E4%B8%AD%E5%9B%BD%E9%AB%98%E5%B0%BF%E9%85%B8%E8%A1%80%E7%97%87%E4%B8%8E%E7%97%9B%E9%A3%8E%E8%AF%8A%E7%96%97%E6%8C%87%E5%8D%97(2019).html")!)
					.font(.caption)
					.foregroundStyle(.blue)
				Link("SOURCE_DIETARY_GUIDELINE_2024", destination: URL(string: "http://www.nhc.gov.cn/sps/c100088/202402/9ba512ba8e314a47a181db11d2fa188d.shtml")!)
					.font(.caption)
					.foregroundStyle(.blue)
				Link("SOURCE_YOULAI_REFERENCE_RANGES", destination: URL(string: "https://m.youlai.cn/sjingbian/article/DD9828MtgUu.html")!)
					.font(.caption)
					.foregroundStyle(.blue)
				Link("SOURCE_PUBCHEM_URIC_ACID", destination: URL(string: "https://pubchem.ncbi.nlm.nih.gov/compound/Uric-acid")!)
					.font(.caption)
					.foregroundStyle(.blue)
			}
			.padding()
			.background(
				RoundedRectangle(cornerRadius: 12)
					.fill(Color(.secondarySystemGroupedBackground))
			)
		}
	}
}
