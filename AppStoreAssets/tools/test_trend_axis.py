"""Run the real Swift axis implementation without needing an XCTest target."""
import pathlib
import subprocess
import tempfile

root = pathlib.Path(__file__).resolve().parents[2]
units = (root / "UricLog/Models/Unit.swift").read_text()
trends = (root / "UricLog/Views/TrendsView.swift").read_text()
source = (
    "import Foundation\n"
    + units[units.index("enum UricUnit:"):units.index("enum AppSettingsKey")]
    + trends[trends.index("enum TrendYAxis {"):trends.index("// MARK: - 统计项视图")]
)
source += r"""
func check(_ values: [Double], target: Double? = nil) {
    let si = TrendYAxis.domain(values: values, target: target, unit: .umolL)
    let mg = TrendYAxis.domain(
        values: values.map { $0 / 59.48 },
        target: target.map { $0 / 59.48 }, unit: .mgdL
    )
    assert(si.lowerBound >= 0 && si.upperBound > si.lowerBound)
    assert(abs(si.lowerBound / 59.48 - mg.lowerBound) < 1e-8)
    assert(abs(si.upperBound / 59.48 - mg.upperBound) < 1e-8)
    for value in values.filter(\.isFinite) where value >= 0 {
        assert(si.contains(value))
    }
    if let target, target.isFinite, target >= 0 {
        assert(si.contains(target))
    }
    print("PASS", values, target as Any, si, mg)
}
check([392, 398, 407, 414, 421])
check([392, 398, 407, 414, 421], target: 420)
check([392, 398, 407, 414, 421], target: 600)
check([400])
check([400, 400, 400])
check([0])
check([0, 1])
check([])
check([Double.nan, Double.infinity, 400], target: Double.nan)
check([1, 2000])
let narrow = TrendYAxis.domain(values: [6.6, 6.7, 6.8, 7.1], target: nil, unit: .mgdL)
assert(narrow.upperBound - narrow.lowerBound < 1)
print("PASS mg/dL narrow span", narrow)
"""

with tempfile.TemporaryDirectory() as directory:
    path = pathlib.Path(directory) / "axis-tests.swift"
    path.write_text(source)
    subprocess.run(["swift", str(path)], check=True)
