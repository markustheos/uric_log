# 1.1.4 screenshot assets

- `raw/<locale>/`: real simulator captures, three separate screens per language.
- `generated/<locale>/`: localized marketing images rendered by `tools/generate.swift`.
- Languages: en-US, zh-Hans, de, es, fr, it, pt-PT.
- Screens: records, trends, add-record. No date-time promotional image.
- Promotional size: 1206 × 2622 (explicit pixel bitmap).
- Upload slot: Dynamic Island iPhone, medium display (required).

Captured from the no-ad 1.1.4 (10) app on iPhone 18 Pro.
The simulator contains five illustrative readings, dated November 2–6, 2026:
421, 414, 407, 398, 392 μmol/L. Italian displays the equivalent values in mg/dL.
The new-record screen contains an unsaved sample value; it does not add a sixth
record to the dataset. Its measurement time is the actual capture time.

Capture automation launches the installed app with each supported app-language
preference and locale, taps the records/trends tabs and the add button, enters a
value and dismisses the keyboard. This is localized screen capture, not a
first-install/system-language test.

The trend-axis implementation is adaptive: visible readings and the enabled
target determine the bounds, with 15% padding and a small minimum span for
single/identical readings. Unit conversion preserves equivalent bounds.
The actual chart is line-only; marketing rendering adds a shadow around the
screenshot, not a fictitious area fill underneath the chart.

Known app presentation details retained faithfully (not retouched in artwork):
- Italian converted readings show up to four fractional digits.
- French app title currently contains `Aacide`, an existing translation typo.
- Longer chart headings wrap, and the bottom tab bar overlays part of statistics.

The corrected 1206 × 2622 images have been uploaded to the required medium
Dynamic Island iPhone slot for all seven languages in the 1.1.4 draft.
The earlier 1284 × 2778 images remain in the optional large Face ID iPhone slot;
they are not valid inputs for the medium Dynamic Island slot.

The latest release archive was uploaded as Build 11 (Xcode automatically
incremented the build number). The user confirmed that 1.1.4 was submitted
for review; this is not a claim of App Store approval.
