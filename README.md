<a id="english"></a>

# Acid Uric Log (UricLog)

[English](#english) | [简体中文](#chinese) | [Italiano](#italian)

A free, minimalist, privacy-first iOS app for recording uric acid levels and viewing trends.

Core principle: focus on recording, trends, and data export. The app does not provide medical diagnoses or treatment advice.

## Features

- Records: add, edit, and delete uric acid readings, including measurement dates, times, and notes
- Units: switch between `μmol/L` and `mg/dL` at any time
- Reference ranges: display common reference ranges by sex, with sources and references available for verification
- Trends: view charts and summary statistics for the last 7, 30, or 90 days, or all records; supports a target value
- Export: export records as CSV for medical appointments or your own analysis
- Optional sync: sync records through iCloud (CloudKit) and key settings, such as sex and target value, through iCloud Key-Value Store

## Project structure

- `UricLog/`
  - `UricLogApp.swift`: app entry point
  - `Views/`: SwiftUI screens
    - `RecordsListView.swift`: records list
    - `RecordEditorView.swift`: add and edit records; includes access to reference information, sources, and citations
    - `TrendsView.swift`: trend charts and statistics
    - `SettingsView.swift`: units, sex, target value, iCloud, export, and other settings
  - `Models/`: domain models and settings keys
    - `UricAcidRecord.swift`: Core Data entity extensions and record creation
    - `Unit.swift`: unit conversion, reference ranges by sex, and settings keys (`AppSettingsKey`)
  - `Persistence/`: persistence and iCloud
    - `Persistence.swift`: Core Data / CloudKit container setup
    - `PersistenceController.swift`: container loading, iCloud status, and sync events
  - `Utils/`
    - `CSVExporter.swift`: CSV export
    - `DateFormatter.swift`: date formatting
    - `ICloudSettingsSync.swift`: settings sync through iCloud Key-Value Store
- `doc/PRD.md`: product requirements document (PRD)
- `site/privacy-policy.html`: privacy policy page for App Store submission

## Run locally

1. Install dependencies: `pod install`
2. Open `UricLog.xcworkspace` in Xcode
3. Select the `UricLog` scheme
4. Run the app on a simulator or a physical device

## iCloud sync

- Records sync through CloudKit + Core Data (`NSPersistentCloudKitContainer`)
- Settings sync through `NSUbiquitousKeyValueStore` using these keys:
  - `userGender`
  - `targetEnabled`
  - `targetValue`
  - `preferredUnit`

Enable sync using the iCloud toggle in Settings. The app remains fully usable locally when sync is disabled.

## Disclaimer

This app is intended for personal recordkeeping and reference only. It does not provide medical advice or a basis for diagnosis. Consult a qualified medical professional if your readings are abnormal.

---

<a id="chinese"></a>

# 尿酸记录（UricLog）

一款免费、极简、隐私优先的尿酸数值记录与趋势查看 iOS App。

核心原则：只做“记录 + 趋势 + 可带走（导出）”，不提供医疗诊断与治疗建议。

## 功能概览

- 记录：新增/编辑/删除尿酸数值，支持测量时间与备注
- 单位：支持 `μmol/L` 与 `mg/dL`，可随时切换
- 参考范围：可按性别显示常见参考区间；提供“来源与引用”链接便于核对
- 趋势：按 7/30/90 天或全部查看趋势图与统计摘要；支持目标值
- 导出：支持导出 CSV（便于复诊或自行分析）
- 同步（可选）：支持 iCloud（CloudKit）同步数据；并通过 iCloud Key-Value Store 同步关键设置（性别、目标值等）

## 项目结构

- `UricLog/`
  - `UricLogApp.swift`：App 入口
  - `Views/`：SwiftUI 页面
    - `RecordsListView.swift`：记录列表
    - `RecordEditorView.swift`：新增/编辑记录；包含“参考信息/来源与引用”入口
    - `TrendsView.swift`：趋势图与统计
    - `SettingsView.swift`：单位、性别、目标值、iCloud、导出等设置
  - `Models/`：领域模型与设置 Key
    - `UricAcidRecord.swift`：Core Data 实体扩展与创建逻辑
    - `Unit.swift`：单位换算、性别参考范围、设置 Key（`AppSettingsKey`）
  - `Persistence/`：持久化与 iCloud
    - `Persistence.swift`：Core Data / CloudKit 容器构建
    - `PersistenceController.swift`：容器加载、iCloud 状态与同步事件
  - `Utils/`
    - `CSVExporter.swift`：CSV 导出
    - `DateFormatter.swift`：日期格式化
    - `ICloudSettingsSync.swift`：iCloud Key-Value Store 设置同步
- `doc/PRD.md`：产品说明（PRD）
- `site/privacy-policy.html`：隐私政策页面（用于上架资料）

## 本地运行

1. 安装依赖：`pod install`
2. 用 Xcode 打开 `UricLog.xcworkspace`
3. 选择 `UricLog` scheme
4. 运行到模拟器或真机

## iCloud 同步说明

- 记录数据：通过 CloudKit + Core Data（`NSPersistentCloudKitContainer`）同步
- 设置数据：通过 `NSUbiquitousKeyValueStore` 同步以下 Key
  - `userGender`
  - `targetEnabled`
  - `targetValue`
  - `preferredUnit`

开启入口在设置页的 iCloud 开关；关闭后本地仍可正常使用。

## 免责声明

本应用仅用于个人记录与参考，不构成医疗建议或诊断依据。如有异常请咨询专业医生。

---

<a id="italian"></a>

# Diario Acido Urico (UricLog)

Un'app iOS gratuita, essenziale e attenta alla privacy per registrare i valori di acido urico e consultarne l'andamento.

Principio fondamentale: concentrarsi su registrazione, andamento ed esportazione dei dati. L'app non fornisce diagnosi mediche o consigli terapeutici.

## Funzionalità

- Registrazioni: aggiungi, modifica ed elimina i valori di acido urico, con data, ora della misurazione e note
- Unità: passa da `μmol/L` a `mg/dL` e viceversa in qualsiasi momento
- Intervalli di riferimento: visualizza gli intervalli comuni in base al sesso, con fonti e riferimenti consultabili per verificarli
- Andamento: consulta grafici e riepiloghi statistici degli ultimi 7, 30 o 90 giorni, oppure di tutte le registrazioni; puoi impostare un valore obiettivo
- Esportazione: esporta le registrazioni in formato CSV per le visite mediche o per le tue analisi
- Sincronizzazione facoltativa: sincronizza le registrazioni tramite iCloud (CloudKit) e le impostazioni principali, come sesso e valore obiettivo, tramite iCloud Key-Value Store

## Struttura del progetto

- `UricLog/`
  - `UricLogApp.swift`: punto di ingresso dell'app
  - `Views/`: schermate SwiftUI
    - `RecordsListView.swift`: elenco delle registrazioni
    - `RecordEditorView.swift`: aggiunta e modifica delle registrazioni; include l'accesso a informazioni di riferimento, fonti e citazioni
    - `TrendsView.swift`: grafici dell'andamento e statistiche
    - `SettingsView.swift`: impostazioni di unità, sesso, valore obiettivo, iCloud, esportazione e altro
  - `Models/`: modelli di dominio e chiavi delle impostazioni
    - `UricAcidRecord.swift`: estensioni dell'entità Core Data e logica di creazione delle registrazioni
    - `Unit.swift`: conversione delle unità, intervalli di riferimento per sesso e chiavi delle impostazioni (`AppSettingsKey`)
  - `Persistence/`: persistenza dei dati e iCloud
    - `Persistence.swift`: configurazione del contenitore Core Data / CloudKit
    - `PersistenceController.swift`: caricamento del contenitore, stato di iCloud ed eventi di sincronizzazione
  - `Utils/`
    - `CSVExporter.swift`: esportazione CSV
    - `DateFormatter.swift`: formattazione delle date
    - `ICloudSettingsSync.swift`: sincronizzazione delle impostazioni tramite iCloud Key-Value Store
- `doc/PRD.md`: documento dei requisiti del prodotto (PRD)
- `site/privacy-policy.html`: informativa sulla privacy per la pubblicazione sull'App Store

## Avvio in locale

1. Installa le dipendenze: `pod install`
2. Apri `UricLog.xcworkspace` in Xcode
3. Seleziona lo scheme `UricLog`
4. Esegui l'app su un simulatore o un dispositivo fisico

## Sincronizzazione iCloud

- Le registrazioni vengono sincronizzate tramite CloudKit + Core Data (`NSPersistentCloudKitContainer`)
- Le impostazioni vengono sincronizzate tramite `NSUbiquitousKeyValueStore` con queste chiavi:
  - `userGender`
  - `targetEnabled`
  - `targetValue`
  - `preferredUnit`

Puoi attivare la sincronizzazione con l'interruttore iCloud nelle impostazioni. Quando è disattivata, l'app continua a funzionare normalmente in locale.

## Avvertenza

L'app è destinata esclusivamente alla registrazione personale e alla consultazione dei dati. Non fornisce consigli medici né costituisce una base per la diagnosi. In caso di valori anomali, consulta un medico qualificato.
