<a id="english"></a>

# Acid Uric Log (Minimal Edition) — Product Requirements Document (PRD)

[English](#english) | [简体中文](#chinese) | [Italiano](#italian)

Version: v0.1 (MVP)\
Positioning: a free, minimalist, privacy-first tool for recording uric acid levels and viewing trends\
Core principle: focus on recording, trends, and data export; do not provide medical diagnoses or treatment advice

---

## 1. Background and goals

People with high uric acid levels or gout need a low-cost way to record their levels over time and observe trends. Existing products often have too many features, intrusive advertising, or limited data portability.

The goals of this product are to:

- Let users record uric acid levels with as few actions as possible
- Help users understand changes through clear trend charts and basic statistics
- Keep users in control of their data: primarily local storage, with optional iCloud sync and export

Out of scope for this release:

- Medication advice, diagnostic conclusions, or content intended to replace a doctor
- Extensions such as purine encyclopedias, recipe communities, medical consultations, or e-commerce

---

## 2. Target users and typical scenarios

### 2.1 Target users

- Users with a history of hyperuricemia or gout who need long-term monitoring
- People whose health checkups show elevated uric acid and who want to track their levels and arrange follow-up checks
- People interested in their health data who want simple recording and the ability to export data for a doctor or family member

### 2.2 Typical scenarios

- Receiving lab results at a hospital or health checkup: enter a reading on the spot
- Taking a measurement with a home testing device: immediately enter the reading and a note, such as “drank alcohol last night”
- Preparing for a follow-up appointment: export the last three months of data for the doctor
- Reviewing personal trends: check whether readings have improved over the last 7, 30, or 90 days

---

## 3. Value proposition and experience principles

### 3.1 Value proposition

- Minimalism: one entry point and three core screens cover the main tasks
- Reliability: data is not lost and can be recovered and exported
- Privacy: data stays on the device by default; iCloud is optional; no app account system

### 3.2 Experience principles

- Recording comes first: adding a record must take no more than two steps at any time
- Readable trends: charts show key reference lines and summary statistics by default
- Portability: users can export their raw data as CSV at any time

---

## 4. MVP scope (v0.1)

This release delivers only the following:

- Free to use
- Minimalist design
- Local storage + optional iCloud storage
- Data export
- Trend charts

---

## 5. Information architecture (IA)

Three top-level destinations are recommended, using tabs or equivalent navigation:

1. Records (list + add)
2. Trends (charts + statistics)
3. Settings (units, target value, iCloud, export, data management)

---

## 6. Functional requirements

### 6.1 Records (add/edit/delete)

#### 6.1.1 Add a record

Fields:

- Uric acid value (required, numeric)
- Unit (`μmol/L` or `mg/dL`, defaults to the unit selected in Settings)
- Measurement date and time (defaults to now, editable)
- Note (optional, plain text)

Interaction requirements:

- Focus the value input when the add screen opens
- Return to the list and display the new record after a successful save

Validation:

- The value must be positive
- If the input is clearly unusual, such as an extreme value, request confirmation but still allow it to be saved

#### 6.1.2 Edit/delete

- Allow users to open a record's details from the list and edit it
- Support deletion with confirmation

### 6.2 Records list

- Sort by measurement date and time, newest first
- Show date and time + value + unit for each record, optionally including the first line of the note
- Provide quick time-range filters: 7, 30, or 90 days, or all records

### 6.3 Trend charts

#### 6.3.1 Chart display

- Show uric acid levels over time using a line chart or a line chart with data points
- Allow switching between time ranges: 7, 30, or 90 days, or all records
- Support zooming and panning; if implementation cost is high, defer this to a later release

#### 6.3.2 Reference lines and target

- Let users set a target value, such as 360 or 420, using the unit selected in Settings
- Show the target line on the chart

#### 6.3.3 Summary statistics (MVP)

For the selected time range, show:

- Average value
- Minimum/maximum values
- Latest value and its difference from the target
- Target achievement rate: the proportion of records with a value `<= target value`; hide this when no target is set

### 6.4 Storage and sync (local + iCloud)

#### 6.4.1 Local storage (default)

- No login required
- Save data locally within the app

#### 6.4.2 iCloud sync (optional toggle)

- Disabled by default
- When enabled, sync data through the user's iCloud for consistency across devices and migration to a new device

Sync experience requirements:

- Clearly state that sync requires iCloud to be enabled in system settings and a network connection to be available
- Sync failures must not affect local use

Conflict resolution principles at the product level:

- Use the last-modified time as the default conflict resolution strategy
- If two versions of the same record conflict, keep the latest version; a future release may retain a separate conflict copy if needed

### 6.5 Export

MVP export format:

- CSV (required): raw records usable in Excel, by doctors, or for personal analysis

Optional future format:

- PDF with trend charts and summary statistics

Suggested CSV fields:

- `id`
- `measured_at`
- `value`
- `unit`
- `note`
- `created_at`
- `updated_at`

Export range:

- Support exporting the currently selected time range: 7, 30, or 90 days, or all records

### 6.6 Settings

- Unit selection: `μmol/L` / `mg/dL`
- Target value: toggle + numeric input
- iCloud sync: toggle + status message
- Data management: export; clear all data and import in future releases

---

## 7. Conceptual data model

### 7.1 UricAcidRecord

- `id`: UUID
- `measuredAt`: Date
- `value`: Decimal/Double
- `unit`: Enum (`umolL` / `mgdL`)
- `note`: String?
- `createdAt`: Date
- `updatedAt`: Date

### 7.2 Settings

- `preferredUnit`
- `targetEnabled`
- `targetValue`
- `icloudEnabled`

---

## 8. Privacy and compliance boundaries

- Do not collect personally identifiable information by default
- Do not integrate advertising tracking SDKs, keeping the app free and uncluttered
- Include a clear disclaimer: data is for personal recordkeeping and reference only and does not constitute medical advice
- Any future integration with Apple Health (HealthKit) requires a separate permission explanation and toggle; it is out of scope for this release

---

## 9. Quality and acceptance criteria (MVP)

- Adding a record: no more than 10 seconds from opening the add screen to completing the save for a typical user
- Data reliability:
  - No data loss after restarting the app or updating the operating system
  - Enabling or disabling iCloud must not create duplicates or erase data
- Usable export: exported CSV files open correctly in Excel and Numbers
- Accurate trend charts: charts and statistics remain consistent when switching time ranges

---

## 10. Suggested roadmap

### v0.1 (MVP)

- Records: create, read, update, and delete
- Trend charts + basic statistics
- Local storage + optional iCloud sync
- CSV export

### v0.2 (Enhancements)

- PDF export with charts
- Quick recording through widgets and Shortcuts
- More detailed chart interactions, such as zooming and selecting data points

### v0.3 (Long term)

- Additional tracking dimensions, such as weight, alcohol consumption, and medication logs, kept optional and disabled by default
- Advanced analysis: variability, target achievement trends, and periodic patterns

---

<a id="chinese"></a>

# 尿酸记录（极简版）产品说明（PRD）

版本：v0.1（MVP）  
定位：免费、极简、隐私优先的尿酸数值记录与趋势查看工具  
核心原则：只做“记录 + 趋势 + 可带走（导出）”，不做医疗诊断与治疗建议

---

## 1. 背景与目标

高尿酸/痛风人群需要长期、低成本地记录尿酸数值并观察趋势变化，但市面产品往往功能堆叠、广告干扰或数据可迁移性差。

本产品的目标是：

- 让用户在最少操作下完成尿酸记录
- 用清晰的趋势图与基础统计帮助用户理解变化
- 数据完全可控：本地存储为主，可选 iCloud 同步与导出

非目标（本期不做）：

- 不提供用药建议、诊断结论或“替代医生”的内容
- 不做嘌呤百科、食谱社区、问诊电商等扩展形态

---

## 2. 目标用户与典型场景

### 2.1 目标用户

- 有高尿酸血症/痛风史，需长期监测的用户
- 体检发现尿酸偏高，想自我管理并复查的人
- 关注健康数据、希望“简单记录 + 可导出给医生/家人”的人

### 2.2 典型使用场景

- 医院/体检拿到化验单：当场录入一次
- 家用检测仪测完：立刻录入并备注（如“昨晚喝酒”）
- 复诊前：导出近 3 个月数据给医生
- 自我观察：查看近 7/30/90 天趋势是否改善

---

## 3. 价值主张与体验原则

### 3.1 价值主张

- 极简：1 个入口、3 个核心页面即可完成主要任务
- 稳定：不丢数据、可恢复、可导出
- 隐私：默认仅本机；iCloud 为可选；不做账号体系

### 3.2 体验原则

- 记录优先：任何时候“新增记录”不超过 2 步
- 趋势可读：图表默认显示关键参考线与统计摘要
- 可迁移：用户随时能导出原始数据（CSV）

---

## 4. MVP 范围（v0.1）

本期只交付以下能力：

- 免费
- 极简
- 本地 + iCloud 存储（可开关）
- 可导出
- 趋势图

---

## 5. 信息架构（IA）

建议 3 个一级入口（Tab 或等价导航）：

1. 记录（列表 + 新增）
2. 趋势（图表 + 统计）
3. 设置（单位、目标值、iCloud、导出、数据管理）

---

## 6. 功能需求

### 6.1 记录（新增/编辑/删除）

#### 6.1.1 新增记录

字段：

- 尿酸值（必填，数值）
- 单位（`μmol/L` 或 `mg/dL`，默认跟随设置）
- 测量时间（默认当前时间，可修改）
- 备注（可选，纯文本）

交互要求：

- 打开新增页后，焦点默认在数值输入
- 保存成功后回到列表并显示新纪录

校验：

- 数值必须为正数
- 若输入明显异常（如极端值），给出二次确认（但允许保存）

#### 6.1.2 编辑/删除

- 支持在列表中进入详情并编辑
- 支持删除（含二次确认）

### 6.2 记录列表

- 按时间倒序
- 每条展示：日期时间 + 数值 + 单位（可选展示备注首行）
- 支持快速筛选时间范围：7/30/90 天、全部

### 6.3 趋势图

#### 6.3.1 图表展示

- 折线图/点线图展示尿酸随时间变化
- 支持时间范围切换：7/30/90 天、全部
- 支持缩放/拖拽（若成本高，可先不做，保留为后续）

#### 6.3.2 参考线与目标

- 用户可设置目标值（例如 360 或 420，单位随设置）
- 图中展示目标线

#### 6.3.3 统计摘要（MVP）

在当前时间范围内展示：

- 平均值
- 最小/最大值
- 最近一次值与距离目标差值
- 达标率（记录中 `<= 目标值` 的比例；无目标时隐藏）

### 6.4 存储与同步（本地 + iCloud）

#### 6.4.1 本地存储（默认）

- 不需要登录
- 数据随 App 本地保存

#### 6.4.2 iCloud 同步（可选开关）

- 默认关闭
- 开启后：在用户的 iCloud 中同步数据（用于多设备一致与换机）

同步体验要求：

- 明确提示“仅当系统开启 iCloud 且网络可用时同步”
- 同步失败不影响本地使用

冲突原则（产品层面）：

- 以“最后修改时间”作为默认冲突解决策略
- 若出现同一条记录的冲突，保留最新版本；必要时可在后续版本提供“冲突副本保留”

### 6.5 导出

MVP 导出格式：

- CSV（必做）：原始记录可用于 Excel/医生/自分析

可选（后续）：

- PDF（含趋势图 + 统计摘要）

CSV 字段建议：

- `id`
- `measured_at`
- `value`
- `unit`
- `note`
- `created_at`
- `updated_at`

导出范围：

- 支持导出当前筛选时间范围（7/30/90/全部）

### 6.6 设置

- 单位切换：`μmol/L` / `mg/dL`
- 目标值：开关 + 数值输入
- iCloud 同步：开关 + 状态提示
- 数据管理：导出、（后续）清空数据、（后续）导入

---

## 7. 数据模型（概念）

### 7.1 UricAcidRecord

- `id`：UUID
- `measuredAt`：Date
- `value`：Decimal/Double
- `unit`：Enum（`umolL` / `mgdL`）
- `note`：String?
- `createdAt`：Date
- `updatedAt`：Date

### 7.2 Settings

- `preferredUnit`
- `targetEnabled`
- `targetValue`
- `icloudEnabled`

---

## 8. 隐私与合规边界

- 默认不采集任何可识别身份信息
- 不接入广告追踪 SDK（保持“免费但干净”）
- 明确免责声明：数据仅用于个人记录与参考，不构成医疗建议
- 若未来接入 Apple 健康（HealthKit），需单独做权限说明与开关（本期不做）

---

## 9. 质量与验收标准（MVP）

- 新增记录：从打开到保存完成 ≤ 10 秒（常见用户）
- 数据可靠：
  - App 重启/系统升级后数据不丢
  - iCloud 开启/关闭切换不会导致重复或清空
- 导出可用：导出的 CSV 可被 Excel/Numbers 正确打开
- 趋势图正确：时间范围切换后图表与统计一致

---

## 10. 版本规划（建议）

### v0.1（MVP）

- 记录（增删改查）
- 趋势图 + 基础统计
- 本地存储 + 可选 iCloud 同步
- CSV 导出

### v0.2（增强）

- PDF 导出（含图表）
- 小组件/快捷指令快速记录
- 更细的图表交互（缩放/点选）

### v0.3（长期）

- 维度扩展（体重、饮酒、用药打卡等）但保持“可选、默认关闭”
- 高级分析（波动、达标趋势、周期性）


---

<a id="italian"></a>

# Diario Acido Urico (Versione essenziale) — Documento dei requisiti del prodotto (PRD)

Versione: v0.1 (MVP)\
Posizionamento: strumento gratuito, essenziale e attento alla privacy per registrare i valori di acido urico e consultarne l'andamento\
Principio fondamentale: concentrarsi su registrazione, andamento ed esportazione dei dati; non fornire diagnosi mediche o consigli terapeutici

---

## 1. Contesto e obiettivi

Le persone con valori elevati di acido urico o con gotta hanno bisogno di registrare i valori nel tempo a basso costo e osservarne l'andamento. I prodotti disponibili spesso offrono troppe funzionalità, pubblicità invadente o scarsa portabilità dei dati.

Gli obiettivi del prodotto sono:

- Consentire agli utenti di registrare i valori di acido urico con il minor numero possibile di operazioni
- Aiutare a comprendere le variazioni attraverso grafici chiari e statistiche di base
- Lasciare agli utenti il pieno controllo dei dati: salvataggio principalmente locale, con sincronizzazione iCloud ed esportazione facoltative

Funzionalità escluse da questa versione:

- Consigli sui farmaci, conclusioni diagnostiche o contenuti che intendano sostituire il medico
- Estensioni come enciclopedie sulle purine, comunità di ricette, consulti medici o servizi di commercio elettronico

---

## 2. Utenti destinatari e scenari tipici

### 2.1 Utenti destinatari

- Utenti con una storia di iperuricemia o gotta che necessitano di un monitoraggio nel tempo
- Persone che hanno riscontrato valori elevati di acido urico durante un controllo e desiderano monitorarli e ripetere gli esami
- Persone interessate ai propri dati sanitari che desiderano registrazioni semplici ed esportabili per il medico o i familiari

### 2.2 Scenari tipici

- Ricezione del referto in ospedale o dopo un controllo: inserire subito una misurazione
- Misurazione con uno strumento domestico: inserire immediatamente il valore e una nota, per esempio «ieri sera ho bevuto alcol»
- Preparazione a una visita di controllo: esportare gli ultimi tre mesi di dati per il medico
- Osservazione personale: verificare se i valori sono migliorati negli ultimi 7, 30 o 90 giorni

---

## 3. Proposta di valore e principi dell'esperienza d'uso

### 3.1 Proposta di valore

- Essenzialità: un punto di accesso e tre schermate principali coprono le attività fondamentali
- Affidabilità: i dati non vengono persi e possono essere recuperati ed esportati
- Privacy: dati sul dispositivo per impostazione predefinita, iCloud facoltativo e nessun sistema di account dell'app

### 3.2 Principi dell'esperienza d'uso

- Priorità alla registrazione: aggiungere una registrazione deve richiedere al massimo due passaggi in qualsiasi momento
- Andamento leggibile: i grafici mostrano per impostazione predefinita le principali linee di riferimento e un riepilogo statistico
- Portabilità: l'utente può esportare i dati originali in CSV in qualsiasi momento

---

## 4. Ambito dell'MVP (v0.1)

Questa versione include esclusivamente:

- Utilizzo gratuito
- Design essenziale
- Salvataggio locale e su iCloud, con sincronizzazione attivabile e disattivabile
- Esportazione dei dati
- Grafici dell'andamento

---

## 5. Architettura delle informazioni (IA)

Si consigliano tre sezioni principali, accessibili tramite schede o una navigazione equivalente:

1. Registrazioni (elenco e aggiunta)
2. Andamento (grafici e statistiche)
3. Impostazioni (unità, valore obiettivo, iCloud, esportazione, gestione dei dati)

---

## 6. Requisiti funzionali

### 6.1 Registrazioni (aggiunta/modifica/eliminazione)

#### 6.1.1 Aggiunta di una registrazione

Campi:

- Valore di acido urico (obbligatorio, numerico)
- Unità (`μmol/L` o `mg/dL`, inizialmente quella scelta nelle impostazioni)
- Data e ora della misurazione (inizialmente quelle attuali, modificabili)
- Nota (facoltativa, testo semplice)

Requisiti di interazione:

- All'apertura della schermata di aggiunta, posizionare il cursore nel campo del valore
- Dopo il salvataggio riuscito, tornare all'elenco e mostrare la nuova registrazione

Convalida:

- Il valore deve essere positivo
- Se il valore inserito è chiaramente anomalo, per esempio estremo, richiedere un'ulteriore conferma consentendo comunque il salvataggio

#### 6.1.2 Modifica/eliminazione

- Consentire di aprire il dettaglio di una registrazione dall'elenco e modificarla
- Consentire l'eliminazione con conferma

### 6.2 Elenco delle registrazioni

- Ordinare per data e ora della misurazione, dalla più recente
- Mostrare per ogni registrazione data e ora, valore e unità; facoltativamente, anche la prima riga della nota
- Offrire filtri rapidi per intervallo temporale: 7, 30 o 90 giorni, oppure tutte le registrazioni

### 6.3 Grafici dell'andamento

#### 6.3.1 Visualizzazione del grafico

- Mostrare i valori di acido urico nel tempo con un grafico a linee, eventualmente con punti evidenziati
- Consentire di scegliere l'intervallo: 7, 30 o 90 giorni, oppure tutte le registrazioni
- Consentire zoom e trascinamento; se il costo di implementazione è elevato, rimandare a una versione successiva

#### 6.3.2 Linee di riferimento e obiettivo

- Consentire all'utente di impostare un valore obiettivo, per esempio 360 o 420, nell'unità scelta nelle impostazioni
- Mostrare la linea dell'obiettivo nel grafico

#### 6.3.3 Riepilogo statistico (MVP)

Per l'intervallo temporale selezionato, mostrare:

- Valore medio
- Valore minimo e massimo
- Ultimo valore e differenza rispetto all'obiettivo
- Percentuale di raggiungimento dell'obiettivo: proporzione delle registrazioni con valore `<= valore obiettivo`; nasconderla quando non è impostato un obiettivo

### 6.4 Salvataggio e sincronizzazione (locale e iCloud)

#### 6.4.1 Salvataggio locale (predefinito)

- Nessun accesso richiesto
- Salvare i dati localmente nell'app

#### 6.4.2 Sincronizzazione iCloud (interruttore facoltativo)

- Disattivata per impostazione predefinita
- Quando attiva, sincronizzare i dati nell'iCloud dell'utente per mantenerli coerenti tra dispositivi e trasferirli a un nuovo dispositivo

Requisiti dell'esperienza di sincronizzazione:

- Indicare chiaramente che la sincronizzazione richiede iCloud attivo nelle impostazioni di sistema e una connessione di rete disponibile
- Gli errori di sincronizzazione non devono compromettere l'utilizzo locale

Principi di risoluzione dei conflitti a livello di prodotto:

- Usare la data dell'ultima modifica come criterio predefinito per risolvere i conflitti
- In caso di conflitto tra versioni della stessa registrazione, conservare la più recente; se necessario, una versione futura potrà conservare anche una copia del conflitto

### 6.5 Esportazione

Formato di esportazione dell'MVP:

- CSV (obbligatorio): registrazioni originali utilizzabili in Excel, dal medico o per analisi personali

Formato facoltativo per versioni successive:

- PDF con grafici dell'andamento e riepilogo statistico

Campi CSV suggeriti:

- `id`
- `measured_at`
- `value`
- `unit`
- `note`
- `created_at`
- `updated_at`

Intervallo di esportazione:

- Consentire l'esportazione dell'intervallo temporale selezionato: 7, 30 o 90 giorni, oppure tutte le registrazioni

### 6.6 Impostazioni

- Scelta dell'unità: `μmol/L` / `mg/dL`
- Valore obiettivo: interruttore e campo numerico
- Sincronizzazione iCloud: interruttore e indicazione dello stato
- Gestione dei dati: esportazione; eliminazione di tutti i dati e importazione in versioni successive

---

## 7. Modello concettuale dei dati

### 7.1 UricAcidRecord

- `id`: UUID
- `measuredAt`: Date
- `value`: Decimal/Double
- `unit`: Enum (`umolL` / `mgdL`)
- `note`: String?
- `createdAt`: Date
- `updatedAt`: Date

### 7.2 Settings

- `preferredUnit`
- `targetEnabled`
- `targetValue`
- `icloudEnabled`

---

## 8. Limiti di privacy e conformità

- Non raccogliere informazioni personali identificative per impostazione predefinita
- Non integrare SDK di tracciamento pubblicitario, mantenendo l'app gratuita ed essenziale
- Inserire un'avvertenza chiara: i dati servono esclusivamente alla registrazione personale e alla consultazione e non costituiscono consigli medici
- Un'eventuale integrazione futura con Apple Salute (HealthKit) richiede una spiegazione separata dei permessi e un interruttore dedicato; è esclusa da questa versione

---

## 9. Criteri di qualità e accettazione (MVP)

- Aggiunta di una registrazione: non più di 10 secondi dall'apertura della schermata al completamento del salvataggio per un utente tipico
- Affidabilità dei dati:
  - Nessuna perdita di dati dopo il riavvio dell'app o l'aggiornamento del sistema operativo
  - L'attivazione o disattivazione di iCloud non deve creare duplicati o cancellare dati
- Esportazione utilizzabile: i CSV esportati devono aprirsi correttamente in Excel e Numbers
- Grafici corretti: grafici e statistiche devono rimanere coerenti quando cambia l'intervallo temporale

---

## 10. Pianificazione suggerita delle versioni

### v0.1 (MVP)

- Registrazioni: aggiunta, consultazione, modifica ed eliminazione
- Grafici dell'andamento e statistiche di base
- Salvataggio locale e sincronizzazione iCloud facoltativa
- Esportazione CSV

### v0.2 (Miglioramenti)

- Esportazione PDF con grafici
- Registrazione rapida tramite widget e Comandi Rapidi
- Interazioni più dettagliate con i grafici, come zoom e selezione dei punti

### v0.3 (Lungo termine)

- Nuove dimensioni da registrare, come peso, consumo di alcol e assunzione di farmaci, mantenendole facoltative e disattivate per impostazione predefinita
- Analisi avanzate: variazioni, andamento del raggiungimento dell'obiettivo e periodicità

