# 1.1.4 screenshot assets

- `raw/<locale>/`: real simulator captures, three separate screens per language.
- `generated/<locale>/`: localized marketing images rendered by `tools/generate.swift`.
- Languages: en-US, zh-Hans, de, es, fr, it, pt-PT.
- Screens: records, trends, add-record. No date-time promotional image.
- Promotional size: 1284 × 2778.

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

These files have not been uploaded to App Store Connect.
