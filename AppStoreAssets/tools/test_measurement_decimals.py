"""Verify the actual editor formatter/parser without an iOS test target."""
import pathlib
import subprocess
import tempfile

root = pathlib.Path(__file__).resolve().parents[2]
source = (root / "UricLog/Views/RecordEditorView.swift").read_text()
start = source.index("enum MeasurementValueText {")
end = source.index("\n}\n", start) + 3
swift = "import Foundation\n" + source[start:end] + r"""
for identifier in ["en-US", "zh-Hans", "de", "es", "fr", "it", "pt-PT"] {
    let locale = Locale(identifier: identifier)
    for value in [5.29, 5.2, 5.0, 392.29, 392.0, 6.59045057162, 5.29123456789] {
        let text = MeasurementValueText.editing(value, locale: locale)
        let parsed = MeasurementValueText.parse(text)
        assert(parsed == value, "\(identifier): \(value) -> \(text) -> \(String(describing: parsed))")
    }
    print("PASS edit/save decimal round trip", identifier)
}
assert(MeasurementValueText.editing(5.29, locale: Locale(identifier: "it")) == "5,29")
assert(MeasurementValueText.editing(5.2, locale: Locale(identifier: "en-US")) == "5.20")
assert(MeasurementValueText.parse("5,29") == 5.29)
assert(MeasurementValueText.parse("5.29") == 5.29)
assert(MeasurementValueText.parse(" 5,29 \n") == 5.29)
for invalid in ["", "abc", "5,2,9", "5.2.9", "nan", "inf", "1e999"] {
    assert(MeasurementValueText.parse(invalid) == nil, invalid)
}
print("PASS two decimal places, comma/dot input and invalid values")
"""
with tempfile.TemporaryDirectory() as directory:
    path = pathlib.Path(directory) / "test.swift"
    path.write_text(swift)
    subprocess.run(["swift", str(path)], check=True)
