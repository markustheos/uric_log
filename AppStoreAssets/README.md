# App Store Assets

Store generated App Store screenshots by app version:

```text
versions/<version>/raw/<locale>/*.png
versions/<version>/generated/<locale>/*.png
```

Current screenshot assets are under `versions/1.1.4/`. Shared generation scripts live in
`tools/` so generated images from different releases do not overwrite each
other.

Example:

```bash
swift AppStoreAssets/tools/generate.swift \
  <raw-screenshot-directory> \
  AppStoreAssets/versions/1.1.4/generated
```

## 1.1.4 screenshots

Each of `en-US`, `zh-Hans`, `de`, `es`, `fr`, `it`, and `pt-PT` has
three **separately captured, localized app screens**:

```text
versions/1.1.4/
  raw/<locale>/01-records.png
  raw/<locale>/02-trends.png
  raw/<locale>/03-add-record.png
  generated/<locale>/01-records.png
  generated/<locale>/02-trends.png
  generated/<locale>/03-add-record.png
```

There is no date/time-picker promotional image. The generator adds marketing
copy, rounded corners and a shadow to the real screenshots; it does not
launch the app, translate the app UI, or create records.

```bash
swift AppStoreAssets/tools/generate.swift \
  AppStoreAssets/versions/1.1.4/raw \
  AppStoreAssets/versions/1.1.4/generated
```

All 21 inputs must exist and be distinct before rendering starts. Missing
localized screenshots and byte-identical duplicates are errors, not reasons
to fall back to English.

Trend-axis regression checks (runs the implementation extracted from
`TrendsView.swift` with the actual unit-conversion code):

```bash
python3 AppStoreAssets/tools/test_trend_axis.py
```

## 素材大小（1.1.4）

按 PNG 文件实际字节数统计，不含 README 和文件系统分配开销：

| 目录 | 数量 | 字节数 | 大小 |
| --- | ---: | ---: | ---: |
| `raw/` | 21 张 | 10,556,848 | 10.07 MiB（10.56 MB） |
| `generated/` | 21 张 | 15,002,530 | 14.31 MiB（15.00 MB） |
| 合计 | 42 张 | 25,559,378 | 24.38 MiB（25.56 MB） |

素材没有加入 Xcode App target，不会随 App 打包。提交到 Git 后会增加仓库体积；
删除本地文件也不会移除已提交的历史对象。`raw` 应保留以便重新生成，商店上传用
`generated`，不要把 raw 上传为最终宣传图。

重新统计：

```bash
du -sh AppStoreAssets/versions/1.1.4/{raw,generated}
python3 - <<'PY'
from pathlib import Path
for kind in ("raw", "generated"):
    files = list((Path("AppStoreAssets/versions/1.1.4") / kind).rglob("*.png"))
    size = sum(p.stat().st_size for p in files)
    print(f"{kind}: {len(files)} 张，{size:,} 字节，{size / 1024**2:.2f} MiB")
PY
```

## 后续版本更新流程

### 商店名称本地化（与版本文案分开）

App Store 搜索结果/产品页的名称需要在 App Store Connect → App 信息 →
本地化信息中，按语言配置“名称”（以及可选副标题）。仅添加版本描述、
更新说明或截图不会自动本地化商店名称。`InfoPlist.strings` 的
`CFBundleDisplayName` 控制设备上的 App 名称，也不代替商店名称。

建议名称：

| 语言 | 商店名称 |
| --- | --- |
| zh-Hans | 尿酸记录 |
| en-US | Uric Acid Log |
| de | Harnsäure-Tagebuch |
| es | Diario Ácido Úrico |
| fr | Journal Acide Urique |
| it | Diario Acido Urico |
| pt-PT | Diário Ácido Úrico |

保存前检查字符限制和名称可用性，并确认当前审核状态是否允许编辑。
商店最终显示还受用户的商店语言及本地化回退影响，不是由 App 内手动选择的语言控制。

### 1. 建立新目录，安装要发布的代码

不要覆盖旧版本目录。下面以 `1.1.5` 为例，在仓库根目录执行：

```bash
VERSION=1.1.5
for locale in en-US zh-Hans de es fr it pt-PT; do
  mkdir -p "AppStoreAssets/versions/$VERSION/raw/$locale"
done
xcrun simctl list devices booted
```

选用同一个 iPhone 模拟器。通过 Xcode 的 `UricLog.xcworkspace` / `UricLog`
scheme 构建运行最新代码；不要直接复用旧 `/tmp` 构建产物。
核实版本、广告移除状态和最新界面。以下 `booted` 命令要求只启动一个模拟器，
多个同时启动时改用明确的 UDID。本轮使用 iPhone 18 Pro，原始截图为 1206 × 2622。

### 2. 准备一致的演示数据

- 使用测试模拟器，不要修改真机用户数据；关闭 iCloud，避免演示记录同步到真实账户。
- 通过 App 添加 5 条示例记录。1.1.4 使用 2026-11-02～06：
  421、414、407、398、392 μmol/L，每天 08:30。
- 后续发布应改为截图当天及之前的相邻 5 天，确保 30 天筛选包含所有记录，
  不使用未来年份，也不要所有记录都在同一天。
- 统一性别、时间范围和目标开关。1.1.4 为男性、30 天、开启目标线；
  μmol/L 目标 420，意大利语 mg/dL 目标 7.0。
- 改单位时转换数值和目标，不能将 392 μmol/L 直接当作 392 mg/dL。
- 可统一状态栏，截图完成后清除覆盖：

```bash
xcrun simctl status_bar booted override --time '9:41' \
  --dataNetwork wifi --wifiMode active --wifiBars 3 \
  --batteryState charged --batteryLevel 100
```

### 3. 每一种语言实际打开三个页面再截图

在 App「设置 → 语言」切换并确认实际文字变化。设置对应单位：当前版本意大利语
为 mg/dL，其余六种为 μmol/L。**已有安装切换语言不会自动重置单位**，需要手动设置。
用统一示例数据截屏，不需要逐语言卸载 App。

若需同时设置系统区域格式，可通过模拟器 Settings 设置；不要将仅修改文件夹名
当作语言切换。App 内语言选择与系统语言首次安装测试是两件不同的事。

对 `en-US / zh-Hans / de / es / fr / it / pt-PT` 逐一执行：

1. **records**：打开记录 Tab，滚动到顶部，确认有 5 条不同日期记录和正确单位。
2. **trends**：打开趋势 Tab，保持相同时间范围，确认曲线、纵轴、目标线和统计正常。
   mg/dL 不应因纵轴范围过大变成横线；当前界面只有线，不能人为加面积阴影。
3. **add_record**：返回记录页，点击右上角 `+`，必须显示新增标题而不是编辑标题。
   输入 392 μmol/L（意大利语约 6.6 mg/dL），点击标题等非输入区域收起键盘。
   截图后取消，不保存，避免数据变成 6 条。时间使用真实当前时间。

每次页面加载、启动动画和切换动画结束后再执行对应命令，不能连续执行三条命令
而不切换页面。以下以英文为例：

```bash
# 实际打开记录列表后：
xcrun simctl io booted screenshot \
  "AppStoreAssets/versions/$VERSION/raw/en-US/01-records.png"
# 实际打开趋势页后：
xcrun simctl io booted screenshot \
  "AppStoreAssets/versions/$VERSION/raw/en-US/02-trends.png"
# 实际打开新增记录并收起键盘后：
xcrun simctl io booted screenshot \
  "AppStoreAssets/versions/$VERSION/raw/en-US/03-add-record.png"
```

其余语言更换输出语言目录，但还必须实际切换 App 语言并重复页面操作。
本轮使用了临时 XCTest 自动点击并导出截图；该自动化工程在 `/tmp`，
**不属于仓库的可复用工具，不能依赖它长期存在**。上述手工步骤是完整可复现路径。
以后使用自动化也必须校验语言标题、页面类型、数据和键盘状态，而非只检查 PNG 存在。

### 4. 检查 raw，再生成宣传图

- 必须有 7 × 3 = 21 张不同截图，逐张看图，不只检查文件数量。
- 内部语言与目录匹配；没有乱码、广告、启动页、弹窗或空状态。
- 列表和趋势使用同一组记录；单位正确，纵轴自适应；新增页不是列表复制品。
- 检查长文本是否截断、标题拼写和内容遮挡。发现 App 问题应修复代码并重截，
  不在宣传图中修图掩盖。
- 英文三张先确认版式，再检查其他语言三张。

```bash
find "AppStoreAssets/versions/$VERSION/raw" -name '*.png' | sort
python3 AppStoreAssets/tools/test_trend_axis.py
swift AppStoreAssets/tools/generate.swift \
  "AppStoreAssets/versions/$VERSION/raw" \
  "AppStoreAssets/versions/$VERSION/generated"
```

生成器要求 21 个输入存在且内容不重复，没有跨语言回退。宣传文案在
`tools/generate.swift` 的 `shots` / `localizedCopy` 中；新增语言或页面时需同步
调整输入、文案及检查数量。修改文案只需重生成；修改 App 界面必须先重截对应 raw。
工具保留圆角、外围阴影和顶部文案，通过显式像素画布输出 **1206 × 2622 PNG**，
不依赖 macOS 屏幕的 Retina 倍率。上传到 **带灵动岛的 iPhone（中等显示屏）**
必填栏目；该栏目不接受旧的 1284 × 2778 图。旧尺寸只能用于
“带面容 ID 的 iPhone（大显示屏）”，不要把两个栏目混用。

### 5. 检查输出、记录版本、再上传

逐张检查生成后的 21 张：文案与页面匹配、无文字溢出、无错误裁剪、阴影正常，
截图仍为对应语言的真实界面。更新新版本目录 README，记录 App 版本/build、
设备、日期、数据、单位、已知问题和素材大小。

```bash
find "AppStoreAssets/versions/$VERSION/generated" -name '*.png' | sort
du -sh "AppStoreAssets/versions/$VERSION/"{raw,generated}
xcrun simctl status_bar booted clear
git diff --check
```

确认后在 App Store Connect 对应版本、对应语言上传 `generated/<locale>/` 三张，
不要上传 raw、旧图或 date_time。代码发生变化时重新构建发布包；
截图重新生成不会自动更新之前归档或已上传的二进制包。
