<a id="english"></a>

# Acid Uric Log (Minimal Edition) — Product Requirements Document (PRD)

[English](#english) | [简体中文](#chinese) | [Italiano](#italian) | [Español](#spanish) | [Deutsch](#german) | [Français](#french) | [Português](#portuguese)

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


---

<a id="spanish"></a>

# Diario Ácido Úrico (Versión esencial) — Documento de requisitos del producto (PRD)

Versión: v0.1 (MVP)\
Posicionamiento: herramienta gratuita, sencilla y centrada en la privacidad para registrar los valores de ácido úrico y consultar su evolución\
Principio fundamental: centrarse en el registro, la evolución y la exportación de datos; no ofrecer diagnósticos médicos ni recomendaciones terapéuticas

---

## 1. Contexto y objetivos

Las personas con valores elevados de ácido úrico o con gota necesitan registrar los valores a lo largo del tiempo con un coste reducido y observar su evolución. Los productos disponibles suelen ofrecer demasiadas funciones, publicidad intrusiva o una portabilidad de datos limitada.

Los objetivos del producto son:

- Permitir que los usuarios registren los valores de ácido úrico con el menor número posible de acciones
- Ayudar a comprender las variaciones mediante gráficos claros y estadísticas básicas
- Mantener el control de los datos en manos del usuario: almacenamiento principalmente local, con sincronización con iCloud y exportación opcionales

Funciones excluidas de esta versión:

- Consejos sobre medicamentos, conclusiones diagnósticas o contenido destinado a sustituir al médico
- Extensiones como enciclopedias de purinas, comunidades de recetas, consultas médicas o servicios de comercio electrónico

---

## 2. Usuarios objetivo y situaciones habituales

### 2.1 Usuarios objetivo

- Usuarios con antecedentes de hiperuricemia o gota que necesitan un seguimiento a largo plazo
- Personas que han detectado valores elevados de ácido úrico en una revisión y desean hacer un seguimiento y repetir los análisis
- Personas interesadas en sus datos de salud que desean registrar mediciones de forma sencilla y exportarlas para el médico o sus familiares

### 2.2 Situaciones habituales

- Recepción de un informe en el hospital o tras una revisión: introducir una medición en ese momento
- Medición con un dispositivo doméstico: introducir el valor y una nota inmediatamente, por ejemplo, «anoche bebí alcohol»
- Preparación de una consulta de seguimiento: exportar los datos de los últimos tres meses para el médico
- Observación personal: comprobar si los valores han mejorado durante los últimos 7, 30 o 90 días

---

## 3. Propuesta de valor y principios de la experiencia de uso

### 3.1 Propuesta de valor

- Sencillez: un punto de acceso y tres pantallas principales cubren las tareas fundamentales
- Fiabilidad: los datos no se pierden y pueden recuperarse y exportarse
- Privacidad: datos en el dispositivo de forma predeterminada, iCloud opcional y ningún sistema de cuentas de la app

### 3.2 Principios de la experiencia de uso

- Prioridad al registro: añadir una medición debe requerir como máximo dos pasos en cualquier momento
- Evolución legible: los gráficos muestran de forma predeterminada las principales líneas de referencia y un resumen estadístico
- Portabilidad: el usuario puede exportar los datos originales en CSV en cualquier momento

---

## 4. Alcance del MVP (v0.1)

Esta versión incluye exclusivamente:

- Uso gratuito
- Diseño sencillo
- Almacenamiento local y en iCloud, con sincronización que se puede activar y desactivar
- Exportación de datos
- Gráficos de evolución

---

## 5. Arquitectura de la información (IA)

Se recomiendan tres secciones principales, accesibles mediante pestañas o una navegación equivalente:

1. Mediciones (lista y añadir)
2. Evolución (gráficos y estadísticas)
3. Ajustes (unidades, valor objetivo, iCloud, exportación y gestión de datos)

---

## 6. Requisitos funcionales

### 6.1 Mediciones (añadir/editar/eliminar)

#### 6.1.1 Añadir una medición

Campos:

- Valor de ácido úrico (obligatorio, numérico)
- Unidad (`μmol/L` o `mg/dL`, inicialmente la seleccionada en Ajustes)
- Fecha y hora de la medición (inicialmente las actuales, modificables)
- Nota (opcional, texto sin formato)

Requisitos de interacción:

- Al abrir la pantalla para añadir una medición, situar el cursor en el campo del valor
- Tras guardar correctamente, volver a la lista y mostrar la nueva medición

Validación:

- El valor debe ser positivo
- Si el valor introducido es claramente anómalo, por ejemplo, extremo, solicitar una confirmación adicional permitiendo guardarlo de todos modos

#### 6.1.2 Editar/eliminar

- Permitir abrir los detalles de una medición desde la lista y editarla
- Permitir la eliminación con confirmación

### 6.2 Lista de mediciones

- Ordenar por fecha y hora de la medición, de la más reciente a la más antigua
- Mostrar la fecha y la hora, el valor y la unidad de cada medición; opcionalmente, también la primera línea de la nota
- Ofrecer filtros rápidos por intervalo de tiempo: 7, 30 o 90 días, o todas las mediciones

### 6.3 Gráficos de evolución

#### 6.3.1 Visualización del gráfico

- Mostrar los valores de ácido úrico a lo largo del tiempo mediante un gráfico de líneas, opcionalmente con los puntos resaltados
- Permitir seleccionar el intervalo: 7, 30 o 90 días, o todas las mediciones
- Permitir ampliar y desplazar el gráfico; si el coste de implementación es elevado, posponerlo a una versión posterior

#### 6.3.2 Líneas de referencia y objetivo

- Permitir que el usuario establezca un valor objetivo, por ejemplo, 360 o 420, en la unidad seleccionada en Ajustes
- Mostrar la línea del objetivo en el gráfico

#### 6.3.3 Resumen estadístico (MVP)

Para el intervalo de tiempo seleccionado, mostrar:

- Valor medio
- Valores mínimo y máximo
- Último valor y diferencia respecto al objetivo
- Porcentaje de cumplimiento del objetivo: proporción de mediciones con un valor `<= valor objetivo`; ocultarlo cuando no haya un objetivo establecido

### 6.4 Almacenamiento y sincronización (local e iCloud)

#### 6.4.1 Almacenamiento local (predeterminado)

- No se requiere iniciar sesión
- Guardar los datos localmente en la app

#### 6.4.2 Sincronización con iCloud (interruptor opcional)

- Desactivada de forma predeterminada
- Cuando esté activada, sincronizar los datos en el iCloud del usuario para mantenerlos coherentes entre dispositivos y transferirlos a un dispositivo nuevo

Requisitos de la experiencia de sincronización:

- Indicar claramente que la sincronización requiere tener iCloud activado en los ajustes del sistema y una conexión de red disponible
- Los errores de sincronización no deben afectar al uso local

Principios de resolución de conflictos a nivel de producto:

- Usar la fecha y la hora de la última modificación como criterio predeterminado para resolver los conflictos
- En caso de conflicto entre versiones de una misma medición, conservar la más reciente; si es necesario, una versión futura podrá conservar también una copia del conflicto

### 6.5 Exportación

Formato de exportación del MVP:

- CSV (obligatorio): mediciones originales utilizables en Excel, por el médico o para análisis personales

Formato opcional para versiones posteriores:

- PDF con gráficos de evolución y resumen estadístico

Campos CSV sugeridos:

- `id`
- `measured_at`
- `value`
- `unit`
- `note`
- `created_at`
- `updated_at`

Intervalo de exportación:

- Permitir la exportación del intervalo de tiempo seleccionado: 7, 30 o 90 días, o todas las mediciones

### 6.6 Ajustes

- Selección de unidad: `μmol/L` / `mg/dL`
- Valor objetivo: interruptor y campo numérico
- Sincronización con iCloud: interruptor e indicación del estado
- Gestión de datos: exportación; eliminación de todos los datos e importación en versiones posteriores

---

## 7. Modelo conceptual de datos

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

## 8. Límites de privacidad y cumplimiento

- No recopilar información que permita identificar a una persona de forma predeterminada
- No integrar SDK de seguimiento publicitario, manteniendo la app gratuita y sencilla
- Incluir un aviso claro: los datos sirven exclusivamente para el registro personal y la consulta y no constituyen asesoramiento médico
- Una posible integración futura con Apple Salud (HealthKit) requiere una explicación independiente de los permisos y un interruptor específico; queda excluida de esta versión

---

## 9. Criterios de calidad y aceptación (MVP)

- Añadir una medición: no más de 10 segundos desde la apertura de la pantalla hasta completar el guardado para un usuario habitual
- Fiabilidad de los datos:
  - Ninguna pérdida de datos tras reiniciar la app o actualizar el sistema operativo
  - Activar o desactivar iCloud no debe crear duplicados ni borrar datos
- Exportación utilizable: los archivos CSV exportados deben abrirse correctamente en Excel y Numbers
- Gráficos correctos: los gráficos y las estadísticas deben mantenerse coherentes al cambiar el intervalo de tiempo

---

## 10. Planificación sugerida de versiones

### v0.1 (MVP)

- Mediciones: añadir, consultar, editar y eliminar
- Gráficos de evolución y estadísticas básicas
- Almacenamiento local y sincronización con iCloud opcional
- Exportación CSV

### v0.2 (Mejoras)

- Exportación PDF con gráficos
- Registro rápido mediante widgets y Atajos
- Interacciones más detalladas con los gráficos, como ampliar y seleccionar puntos

### v0.3 (A largo plazo)

- Nuevas dimensiones que registrar, como el peso, el consumo de alcohol y la toma de medicamentos, manteniéndolas opcionales y desactivadas de forma predeterminada
- Análisis avanzados: variaciones, evolución del cumplimiento del objetivo y periodicidad


---

<a id="german"></a>

# Harnsäure-Tagebuch (Minimalversion) — Produktanforderungsdokument (PRD)

Version: v0.1 (MVP)\
Positionierung: ein kostenloses, minimalistisches und datenschutzorientiertes Werkzeug zum Erfassen von Harnsäurewerten und Anzeigen ihres Verlaufs\
Grundprinzip: auf Erfassung, Verlauf und Datenexport konzentrieren; keine medizinischen Diagnosen oder Behandlungsempfehlungen geben

---

## 1. Hintergrund und Ziele

Menschen mit erhöhten Harnsäurewerten oder Gicht benötigen eine kostengünstige Möglichkeit, ihre Werte langfristig zu erfassen und ihren Verlauf zu beobachten. Bestehende Produkte bieten oft zu viele Funktionen, aufdringliche Werbung oder eine eingeschränkte Übertragbarkeit der Daten.

Die Ziele dieses Produkts sind:

- Harnsäurewerte mit möglichst wenigen Schritten erfassen
- Veränderungen mithilfe übersichtlicher Verlaufsdiagramme und grundlegender Statistiken verständlich machen
- Die Kontrolle über die Daten bei den Nutzern belassen: hauptsächlich lokale Speicherung, mit optionaler iCloud-Synchronisierung und Exportfunktion

Nicht im Umfang dieser Version enthalten:

- Medikamentenempfehlungen, diagnostische Schlussfolgerungen oder Inhalte, die einen Arzt ersetzen sollen
- Erweiterungen wie Purinlexika, Rezept-Communitys, ärztliche Beratungen oder E-Commerce-Angebote

---

## 2. Zielgruppen und typische Nutzungssituationen

### 2.1 Zielgruppen

- Nutzer mit Hyperurikämie oder Gicht in der Vorgeschichte, die eine langfristige Überwachung benötigen
- Personen, bei denen bei einer Vorsorgeuntersuchung erhöhte Harnsäurewerte festgestellt wurden und die ihre Werte verfolgen und Nachkontrollen planen möchten
- Personen, die sich für ihre Gesundheitsdaten interessieren und Werte einfach erfassen sowie für einen Arzt oder Angehörige exportieren möchten

### 2.2 Typische Nutzungssituationen

- Erhalt von Laborergebnissen im Krankenhaus oder bei einer Vorsorgeuntersuchung: einen Messwert direkt eingeben
- Messung mit einem Gerät für zu Hause: den Wert und eine Notiz, etwa „gestern Abend Alkohol getrunken“, sofort eingeben
- Vorbereitung auf einen Kontrolltermin: die Daten der letzten drei Monate für den Arzt exportieren
- Persönliche Verlaufskontrolle: prüfen, ob sich die Werte in den letzten 7, 30 oder 90 Tagen verbessert haben

---

## 3. Nutzenversprechen und Grundsätze der Bedienung

### 3.1 Nutzenversprechen

- Minimalismus: ein Einstiegspunkt und drei zentrale Ansichten decken die wichtigsten Aufgaben ab
- Zuverlässigkeit: Daten gehen nicht verloren und lassen sich wiederherstellen und exportieren
- Datenschutz: Daten bleiben standardmäßig auf dem Gerät; iCloud ist optional; kein eigenes Kontosystem der App

### 3.2 Grundsätze der Bedienung

- Erfassung hat Vorrang: ein neuer Eintrag muss jederzeit in höchstens zwei Schritten möglich sein
- Verständlicher Verlauf: Diagramme zeigen standardmäßig die wichtigsten Referenzlinien und zusammengefasste Statistiken
- Übertragbarkeit: Nutzer können ihre Rohdaten jederzeit als CSV exportieren

---

## 4. Umfang des MVP (v0.1)

Diese Version bietet ausschließlich:

- Kostenlose Nutzung
- Minimalistisches Design
- Lokale Speicherung und optionale iCloud-Speicherung
- Datenexport
- Verlaufsdiagramme

---

## 5. Informationsarchitektur (IA)

Empfohlen werden drei Hauptbereiche, erreichbar über Tabs oder eine gleichwertige Navigation:

1. Messungen (Liste und Hinzufügen)
2. Verlauf (Diagramme und Statistiken)
3. Einstellungen (Einheiten, Zielwert, iCloud, Export und Datenverwaltung)

---

## 6. Funktionale Anforderungen

### 6.1 Messungen (hinzufügen/bearbeiten/löschen)

#### 6.1.1 Eintrag hinzufügen

Felder:

- Harnsäurewert (erforderlich, numerisch)
- Einheit (`μmol/L` oder `mg/dL`, standardmäßig die in den Einstellungen gewählte Einheit)
- Datum und Uhrzeit der Messung (standardmäßig der aktuelle Zeitpunkt, änderbar)
- Notiz (optional, reiner Text)

Anforderungen an die Bedienung:

- Beim Öffnen der Ansicht zum Hinzufügen den Fokus auf das Werteingabefeld setzen
- Nach erfolgreichem Speichern zur Liste zurückkehren und den neuen Eintrag anzeigen

Validierung:

- Der Wert muss positiv sein
- Bei offensichtlich ungewöhnlichen Eingaben, etwa einem Extremwert, eine zusätzliche Bestätigung anfordern, das Speichern aber weiterhin zulassen

#### 6.1.2 Bearbeiten/löschen

- Das Öffnen und Bearbeiten der Details eines Eintrags aus der Liste ermöglichen
- Das Löschen mit Bestätigung ermöglichen

### 6.2 Liste der Messungen

- Nach Datum und Uhrzeit der Messung sortieren, neueste zuerst
- Für jeden Eintrag Datum und Uhrzeit, Wert und Einheit anzeigen, optional auch die erste Zeile der Notiz
- Schnelle Zeitraumfilter anbieten: 7, 30 oder 90 Tage oder alle Einträge

### 6.3 Verlaufsdiagramme

#### 6.3.1 Diagrammdarstellung

- Harnsäurewerte im Zeitverlauf als Liniendiagramm oder Liniendiagramm mit Datenpunkten darstellen
- Zwischen Zeiträumen wechseln können: 7, 30 oder 90 Tage oder alle Einträge
- Vergrößern und Verschieben unterstützen; bei hohem Implementierungsaufwand auf eine spätere Version verschieben

#### 6.3.2 Referenzlinien und Zielwert

- Das Festlegen eines Zielwerts, etwa 360 oder 420, in der in den Einstellungen gewählten Einheit ermöglichen
- Die Ziellinie im Diagramm anzeigen

#### 6.3.3 Zusammengefasste Statistiken (MVP)

Für den ausgewählten Zeitraum anzeigen:

- Durchschnittswert
- Minimal- und Maximalwert
- Letzter Wert und seine Abweichung vom Zielwert
- Zielerreichungsquote: Anteil der Einträge mit einem Wert `<= Zielwert`; ausblenden, wenn kein Zielwert festgelegt ist

### 6.4 Speicherung und Synchronisierung (lokal und iCloud)

#### 6.4.1 Lokale Speicherung (Standard)

- Keine Anmeldung erforderlich
- Daten lokal in der App speichern

#### 6.4.2 iCloud-Synchronisierung (optionaler Schalter)

- Standardmäßig deaktiviert
- Nach der Aktivierung Daten über die iCloud des Nutzers synchronisieren, um sie auf mehreren Geräten konsistent zu halten und auf ein neues Gerät zu übertragen

Anforderungen an die Bedienung der Synchronisierung:

- Klar darauf hinweisen, dass die Synchronisierung aktiviertes iCloud in den Systemeinstellungen und eine verfügbare Netzwerkverbindung erfordert
- Synchronisierungsfehler dürfen die lokale Nutzung nicht beeinträchtigen

Grundsätze zur Konfliktlösung auf Produktebene:

- Standardmäßig den Zeitpunkt der letzten Änderung zur Konfliktlösung verwenden
- Bei einem Konflikt zwischen zwei Versionen desselben Eintrags die neueste Version behalten; bei Bedarf kann eine spätere Version zusätzlich eine Konfliktkopie aufbewahren

### 6.5 Export

Exportformat des MVP:

- CSV (erforderlich): Rohdaten der Einträge zur Verwendung in Excel, durch Ärzte oder für eigene Analysen

Optionales Format für spätere Versionen:

- PDF mit Verlaufsdiagrammen und zusammengefassten Statistiken

Vorgeschlagene CSV-Felder:

- `id`
- `measured_at`
- `value`
- `unit`
- `note`
- `created_at`
- `updated_at`

Exportzeitraum:

- Den Export des aktuell ausgewählten Zeitraums ermöglichen: 7, 30 oder 90 Tage oder alle Einträge

### 6.6 Einstellungen

- Auswahl der Einheit: `μmol/L` / `mg/dL`
- Zielwert: Schalter und numerische Eingabe
- iCloud-Synchronisierung: Schalter und Statusmeldung
- Datenverwaltung: Export; Löschen aller Daten und Import in späteren Versionen

---

## 7. Konzeptionelles Datenmodell

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

## 8. Grenzen bei Datenschutz und Compliance

- Standardmäßig keine personenbezogenen Informationen erfassen, die eine Identifizierung ermöglichen
- Keine SDKs für Werbetracking integrieren, damit die App kostenlos und übersichtlich bleibt
- Einen klaren Hinweis aufnehmen: Die Daten dienen ausschließlich der persönlichen Dokumentation und Orientierung und stellen keine medizinische Beratung dar
- Eine mögliche spätere Integration mit Apple Health (HealthKit) erfordert eine separate Erläuterung der Berechtigungen und einen eigenen Schalter; sie gehört nicht zum Umfang dieser Version

---

## 9. Qualitäts- und Abnahmekriterien (MVP)

- Eintrag hinzufügen: für einen typischen Nutzer höchstens 10 Sekunden vom Öffnen der Eingabeansicht bis zum erfolgreichen Speichern
- Datenzuverlässigkeit:
  - Kein Datenverlust nach einem Neustart der App oder einem Update des Betriebssystems
  - Das Aktivieren oder Deaktivieren von iCloud darf weder Duplikate erzeugen noch Daten löschen
- Nutzbarer Export: exportierte CSV-Dateien lassen sich in Excel und Numbers korrekt öffnen
- Korrekte Verlaufsdiagramme: Diagramme und Statistiken bleiben beim Wechsel des Zeitraums konsistent

---

## 10. Vorgeschlagener Versionsplan

### v0.1 (MVP)

- Einträge: erstellen, lesen, bearbeiten und löschen
- Verlaufsdiagramme und grundlegende Statistiken
- Lokale Speicherung und optionale iCloud-Synchronisierung
- CSV-Export

### v0.2 (Erweiterungen)

- PDF-Export mit Diagrammen
- Schnelle Erfassung über Widgets und Kurzbefehle
- Detailliertere Diagramminteraktionen, etwa Vergrößern und Auswählen von Datenpunkten

### v0.3 (Langfristig)

- Zusätzliche Erfassungsbereiche wie Gewicht, Alkoholkonsum und Medikamenteneinnahme, weiterhin optional und standardmäßig deaktiviert
- Erweiterte Analysen: Schwankungen, Entwicklung der Zielerreichung und wiederkehrende Muster


---

<a id="french"></a>

# Journal Aacide Urique (Version minimaliste) — Document des exigences du produit (PRD)

Version : v0.1 (MVP)\
Positionnement : un outil gratuit, minimaliste et respectueux de la vie privée pour consigner les valeurs d’acide urique et suivre leur évolution\
Principe fondamental : se concentrer sur la saisie, l’évolution et l’exportation des données ; ne pas fournir de diagnostic médical ni de conseils thérapeutiques

---

## 1. Contexte et objectifs

Les personnes présentant un taux élevé d’acide urique ou souffrant de goutte ont besoin d’un moyen peu coûteux de consigner leurs valeurs dans la durée et d’en observer l’évolution. Les produits existants proposent souvent trop de fonctionnalités, des publicités intrusives ou une portabilité des données limitée.

Les objectifs de ce produit sont les suivants :

- Permettre aux utilisateurs de consigner leurs valeurs d’acide urique en un minimum d’actions
- Aider à comprendre les variations grâce à des graphiques d’évolution clairs et à des statistiques de base
- Laisser aux utilisateurs le contrôle de leurs données : stockage principalement local, avec synchronisation iCloud et exportation facultatives

Éléments exclus de cette version :

- Conseils sur les médicaments, conclusions diagnostiques ou contenus destinés à remplacer un médecin
- Extensions telles que des encyclopédies des purines, des communautés de recettes, des consultations médicales ou des services de commerce en ligne

---

## 2. Public cible et situations courantes

### 2.1 Public cible

- Utilisateurs ayant des antécédents d’hyperuricémie ou de goutte et nécessitant un suivi à long terme
- Personnes dont un bilan de santé révèle un taux élevé d’acide urique et qui souhaitent suivre leurs valeurs et prévoir des examens de contrôle
- Personnes intéressées par leurs données de santé qui souhaitent une saisie simple et la possibilité d’exporter leurs données pour un médecin ou un proche

### 2.2 Situations courantes

- Réception de résultats d’analyse à l’hôpital ou lors d’un bilan de santé : saisir immédiatement une mesure
- Mesure avec un appareil à domicile : saisir aussitôt la valeur et une note, par exemple « j’ai bu de l’alcool hier soir »
- Préparation d’un rendez-vous de suivi : exporter les données des trois derniers mois pour le médecin
- Suivi personnel : vérifier si les valeurs se sont améliorées au cours des 7, 30 ou 90 derniers jours

---

## 3. Proposition de valeur et principes d’utilisation

### 3.1 Proposition de valeur

- Minimalisme : un point d’entrée et trois écrans principaux couvrent les tâches essentielles
- Fiabilité : les données ne sont pas perdues et peuvent être récupérées et exportées
- Confidentialité : les données restent sur l’appareil par défaut ; iCloud est facultatif ; aucun système de compte propre à l’app

### 3.2 Principes d’utilisation

- Priorité à la saisie : l’ajout d’une mesure doit nécessiter au maximum deux étapes à tout moment
- Évolution lisible : les graphiques affichent par défaut les principales lignes de référence et un résumé statistique
- Portabilité : les utilisateurs peuvent exporter leurs données brutes au format CSV à tout moment

---

## 4. Périmètre du MVP (v0.1)

Cette version propose uniquement :

- Utilisation gratuite
- Conception minimaliste
- Stockage local et stockage iCloud facultatif
- Exportation des données
- Graphiques d’évolution

---

## 5. Architecture de l’information (IA)

Trois sections principales sont recommandées, accessibles par des onglets ou une navigation équivalente :

1. Mesures (liste et ajout)
2. Évolution (graphiques et statistiques)
3. Réglages (unités, valeur cible, iCloud, exportation et gestion des données)

---

## 6. Exigences fonctionnelles

### 6.1 Mesures (ajout/modification/suppression)

#### 6.1.1 Ajouter une mesure

Champs :

- Valeur d’acide urique (obligatoire, numérique)
- Unité (`μmol/L` ou `mg/dL`, par défaut celle choisie dans les réglages)
- Date et heure de la mesure (par défaut la date et l’heure actuelles, modifiables)
- Note (facultative, texte brut)

Exigences d’interaction :

- À l’ouverture de l’écran d’ajout, placer le curseur dans le champ de saisie de la valeur
- Après un enregistrement réussi, revenir à la liste et afficher la nouvelle mesure

Validation :

- La valeur doit être positive
- Si la valeur saisie est manifestement inhabituelle, par exemple extrême, demander une confirmation supplémentaire tout en permettant son enregistrement

#### 6.1.2 Modifier/supprimer

- Permettre d’ouvrir les détails d’une mesure depuis la liste et de la modifier
- Permettre la suppression avec confirmation

### 6.2 Liste des mesures

- Trier par date et heure de mesure, de la plus récente à la plus ancienne
- Afficher pour chaque mesure la date et l’heure, la valeur et l’unité, ainsi que la première ligne de la note si souhaité
- Proposer des filtres rapides par période : 7, 30 ou 90 jours, ou toutes les mesures

### 6.3 Graphiques d’évolution

#### 6.3.1 Affichage du graphique

- Afficher les valeurs d’acide urique dans le temps à l’aide d’un graphique en courbes, éventuellement avec des points de données
- Permettre de changer de période : 7, 30 ou 90 jours, ou toutes les mesures
- Permettre le zoom et le déplacement ; si le coût de mise en œuvre est élevé, reporter cette fonction à une version ultérieure

#### 6.3.2 Lignes de référence et cible

- Permettre de définir une valeur cible, par exemple 360 ou 420, dans l’unité choisie dans les réglages
- Afficher la ligne de la cible sur le graphique

#### 6.3.3 Résumé statistique (MVP)

Pour la période sélectionnée, afficher :

- Valeur moyenne
- Valeurs minimale et maximale
- Dernière valeur et écart par rapport à la cible
- Taux d’atteinte de la cible : proportion des mesures dont la valeur est `<= valeur cible` ; masquer ce taux lorsqu’aucune cible n’est définie

### 6.4 Stockage et synchronisation (local et iCloud)

#### 6.4.1 Stockage local (par défaut)

- Aucune connexion à un compte requise
- Enregistrer les données localement dans l’app

#### 6.4.2 Synchronisation iCloud (interrupteur facultatif)

- Désactivée par défaut
- Lorsqu’elle est activée, synchroniser les données via l’iCloud de l’utilisateur pour assurer leur cohérence entre les appareils et leur transfert vers un nouvel appareil

Exigences relatives à l’utilisation de la synchronisation :

- Indiquer clairement que la synchronisation nécessite l’activation d’iCloud dans les réglages système et une connexion réseau disponible
- Les échecs de synchronisation ne doivent pas affecter l’utilisation locale

Principes de résolution des conflits au niveau du produit :

- Utiliser par défaut la date de dernière modification comme critère de résolution des conflits
- En cas de conflit entre deux versions d’une même mesure, conserver la plus récente ; si nécessaire, une version ultérieure pourra également conserver une copie du conflit

### 6.5 Exportation

Format d’exportation du MVP :

- CSV (obligatoire) : mesures brutes utilisables dans Excel, par les médecins ou pour des analyses personnelles

Format facultatif pour une version ultérieure :

- PDF avec graphiques d’évolution et résumé statistique

Champs CSV suggérés :

- `id`
- `measured_at`
- `value`
- `unit`
- `note`
- `created_at`
- `updated_at`

Période d’exportation :

- Permettre l’exportation de la période actuellement sélectionnée : 7, 30 ou 90 jours, ou toutes les mesures

### 6.6 Réglages

- Choix de l’unité : `μmol/L` / `mg/dL`
- Valeur cible : interrupteur et saisie numérique
- Synchronisation iCloud : interrupteur et message d’état
- Gestion des données : exportation ; suppression de toutes les données et importation dans des versions ultérieures

---

## 7. Modèle conceptuel des données

### 7.1 UricAcidRecord

- `id` : UUID
- `measuredAt` : Date
- `value` : Decimal/Double
- `unit` : Enum (`umolL` / `mgdL`)
- `note` : String?
- `createdAt` : Date
- `updatedAt` : Date

### 7.2 Settings

- `preferredUnit`
- `targetEnabled`
- `targetValue`
- `icloudEnabled`

---

## 8. Limites en matière de confidentialité et de conformité

- Ne pas collecter par défaut d’informations permettant d’identifier une personne
- Ne pas intégrer de SDK de suivi publicitaire, afin que l’app reste gratuite et épurée
- Inclure un avertissement clair : les données sont destinées uniquement au suivi personnel et à la consultation et ne constituent pas un avis médical
- Toute intégration future avec Apple Santé (HealthKit) nécessite une explication distincte des autorisations et un interrupteur dédié ; elle est exclue de cette version

---

## 9. Critères de qualité et d’acceptation (MVP)

- Ajout d’une mesure : au maximum 10 secondes entre l’ouverture de l’écran d’ajout et la fin de l’enregistrement pour un utilisateur type
- Fiabilité des données :
  - Aucune perte de données après le redémarrage de l’app ou la mise à jour du système d’exploitation
  - L’activation ou la désactivation d’iCloud ne doit pas créer de doublons ni effacer de données
- Exportation utilisable : les fichiers CSV exportés s’ouvrent correctement dans Excel et Numbers
- Graphiques d’évolution exacts : les graphiques et les statistiques restent cohérents lors d’un changement de période

---

## 10. Feuille de route proposée

### v0.1 (MVP)

- Mesures : création, consultation, modification et suppression
- Graphiques d’évolution et statistiques de base
- Stockage local et synchronisation iCloud facultative
- Exportation CSV

### v0.2 (Améliorations)

- Exportation PDF avec graphiques
- Saisie rapide au moyen de widgets et de Raccourcis
- Interactions plus détaillées avec les graphiques, telles que le zoom et la sélection des points de données

### v0.3 (À long terme)

- Dimensions de suivi supplémentaires, telles que le poids, la consommation d’alcool et la prise de médicaments, toujours facultatives et désactivées par défaut
- Analyses avancées : variabilité, évolution de l’atteinte de la cible et tendances périodiques


---

<a id="portuguese"></a>

# Diário Ácido Úrico (Versão minimalista) — Documento de requisitos do produto (PRD)

Versão: v0.1 (MVP)\
Posicionamento: uma ferramenta gratuita, minimalista e centrada na privacidade para registar os valores de ácido úrico e consultar a sua evolução\
Princípio fundamental: concentrar-se no registo, na evolução e na exportação de dados; não fornecer diagnósticos médicos nem recomendações terapêuticas

---

## 1. Contexto e objetivos

As pessoas com valores elevados de ácido úrico ou com gota precisam de uma forma económica de registar os seus valores ao longo do tempo e observar a sua evolução. Os produtos existentes oferecem frequentemente demasiadas funcionalidades, publicidade intrusiva ou uma portabilidade dos dados limitada.

Os objetivos deste produto são:

- Permitir aos utilizadores registar os valores de ácido úrico com o menor número possível de ações
- Ajudar a compreender as variações através de gráficos de evolução claros e estatísticas básicas
- Manter o controlo dos dados nas mãos dos utilizadores: armazenamento principalmente local, com sincronização com o iCloud e exportação opcionais

Funcionalidades excluídas desta versão:

- Conselhos sobre medicamentos, conclusões de diagnóstico ou conteúdos destinados a substituir um médico
- Extensões como enciclopédias sobre purinas, comunidades de receitas, consultas médicas ou serviços de comércio eletrónico

---

## 2. Público-alvo e situações habituais

### 2.1 Público-alvo

- Utilizadores com antecedentes de hiperuricemia ou gota que necessitam de acompanhamento a longo prazo
- Pessoas cujos exames de rotina revelam valores elevados de ácido úrico e que pretendem acompanhar os valores e planear novos exames
- Pessoas interessadas nos seus dados de saúde que pretendem registos simples e a possibilidade de exportar os dados para um médico ou familiar

### 2.2 Situações habituais

- Receção de resultados de análises no hospital ou após exames de rotina: introduzir uma medição no momento
- Medição com um aparelho doméstico: introduzir imediatamente o valor e uma nota, por exemplo, «bebi álcool ontem à noite»
- Preparação para uma consulta de acompanhamento: exportar os dados dos últimos três meses para o médico
- Observação pessoal: verificar se os valores melhoraram nos últimos 7, 30 ou 90 dias

---

## 3. Proposta de valor e princípios de utilização

### 3.1 Proposta de valor

- Minimalismo: um ponto de entrada e três ecrãs principais abrangem as tarefas essenciais
- Fiabilidade: os dados não se perdem e podem ser recuperados e exportados
- Privacidade: os dados permanecem no dispositivo por predefinição; o iCloud é opcional; não existe um sistema de contas próprio da app

### 3.2 Princípios de utilização

- Prioridade ao registo: adicionar um registo deve exigir, em qualquer momento, no máximo dois passos
- Evolução legível: os gráficos apresentam, por predefinição, as principais linhas de referência e um resumo estatístico
- Portabilidade: os utilizadores podem exportar os seus dados originais em CSV a qualquer momento

---

## 4. Âmbito do MVP (v0.1)

Esta versão disponibiliza apenas:

- Utilização gratuita
- Design minimalista
- Armazenamento local e armazenamento opcional no iCloud
- Exportação de dados
- Gráficos de evolução

---

## 5. Arquitetura da informação (IA)

Recomendam-se três secções principais, acessíveis através de separadores ou de uma navegação equivalente:

1. Medições (lista e adição)
2. Evolução (gráficos e estatísticas)
3. Definições (unidades, valor-alvo, iCloud, exportação e gestão de dados)

---

## 6. Requisitos funcionais

### 6.1 Medições (adicionar/editar/apagar)

#### 6.1.1 Adicionar um registo

Campos:

- Valor de ácido úrico (obrigatório, numérico)
- Unidade (`μmol/L` ou `mg/dL`, por predefinição a selecionada nas Definições)
- Data e hora da medição (por predefinição as atuais, editáveis)
- Nota (opcional, texto simples)

Requisitos de interação:

- Ao abrir o ecrã de adição, colocar o cursor no campo de introdução do valor
- Após guardar com êxito, regressar à lista e apresentar o novo registo

Validação:

- O valor tem de ser positivo
- Se o valor introduzido for claramente invulgar, por exemplo, extremo, pedir uma confirmação adicional, mas permitir que seja guardado

#### 6.1.2 Editar/apagar

- Permitir abrir os detalhes de um registo a partir da lista e editá-lo
- Permitir apagar com confirmação

### 6.2 Lista de registos

- Ordenar por data e hora da medição, da mais recente para a mais antiga
- Apresentar a data e a hora, o valor e a unidade de cada registo, incluindo opcionalmente a primeira linha da nota
- Disponibilizar filtros rápidos por intervalo de tempo: 7, 30 ou 90 dias, ou todos os registos

### 6.3 Gráficos de evolução

#### 6.3.1 Apresentação do gráfico

- Apresentar os valores de ácido úrico ao longo do tempo num gráfico de linhas, opcionalmente com pontos de dados
- Permitir alternar entre intervalos de tempo: 7, 30 ou 90 dias, ou todos os registos
- Permitir ampliar e deslocar o gráfico; se o custo de implementação for elevado, adiar esta funcionalidade para uma versão posterior

#### 6.3.2 Linhas de referência e alvo

- Permitir definir um valor-alvo, por exemplo, 360 ou 420, na unidade selecionada nas Definições
- Apresentar a linha do alvo no gráfico

#### 6.3.3 Resumo estatístico (MVP)

Para o intervalo de tempo selecionado, apresentar:

- Valor médio
- Valores mínimo e máximo
- Último valor e diferença em relação ao alvo
- Taxa de cumprimento do alvo: proporção dos registos com um valor `<= valor-alvo`; ocultar quando não estiver definido um alvo

### 6.4 Armazenamento e sincronização (local e iCloud)

#### 6.4.1 Armazenamento local (predefinido)

- Não é necessário iniciar sessão
- Guardar os dados localmente na app

#### 6.4.2 Sincronização com o iCloud (interruptor opcional)

- Desativada por predefinição
- Quando ativada, sincronizar os dados através do iCloud do utilizador para os manter consistentes entre dispositivos e os transferir para um novo dispositivo

Requisitos de utilização da sincronização:

- Indicar claramente que a sincronização requer o iCloud ativo nas definições do sistema e uma ligação de rede disponível
- As falhas de sincronização não devem afetar a utilização local

Princípios de resolução de conflitos ao nível do produto:

- Utilizar a data e a hora da última alteração como critério predefinido para resolver conflitos
- Em caso de conflito entre duas versões do mesmo registo, conservar a mais recente; se necessário, uma versão futura poderá também conservar uma cópia do conflito

### 6.5 Exportação

Formato de exportação do MVP:

- CSV (obrigatório): registos originais utilizáveis no Excel, por médicos ou para análises pessoais

Formato opcional para versões posteriores:

- PDF com gráficos de evolução e resumo estatístico

Campos CSV sugeridos:

- `id`
- `measured_at`
- `value`
- `unit`
- `note`
- `created_at`
- `updated_at`

Intervalo de exportação:

- Permitir a exportação do intervalo de tempo atualmente selecionado: 7, 30 ou 90 dias, ou todos os registos

### 6.6 Definições

- Seleção da unidade: `μmol/L` / `mg/dL`
- Valor-alvo: interruptor e introdução numérica
- Sincronização com o iCloud: interruptor e mensagem de estado
- Gestão de dados: exportação; eliminação de todos os dados e importação em versões posteriores

---

## 7. Modelo conceptual dos dados

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

## 8. Limites de privacidade e conformidade

- Não recolher, por predefinição, informações que permitam identificar uma pessoa
- Não integrar SDK de seguimento publicitário, mantendo a app gratuita e simples
- Incluir um aviso claro: os dados destinam-se apenas ao registo pessoal e à consulta e não constituem aconselhamento médico
- Uma eventual integração futura com a app Saúde da Apple (HealthKit) requer uma explicação separada das permissões e um interruptor próprio; está excluída desta versão

---

## 9. Critérios de qualidade e aceitação (MVP)

- Adicionar um registo: no máximo 10 segundos desde a abertura do ecrã de adição até à conclusão da gravação para um utilizador típico
- Fiabilidade dos dados:
  - Nenhuma perda de dados após reiniciar a app ou atualizar o sistema operativo
  - Ativar ou desativar o iCloud não deve criar duplicados nem apagar dados
- Exportação utilizável: os ficheiros CSV exportados abrem corretamente no Excel e no Numbers
- Gráficos de evolução corretos: os gráficos e as estatísticas mantêm-se consistentes ao mudar o intervalo de tempo

---

## 10. Plano de versões sugerido

### v0.1 (MVP)

- Registos: criar, consultar, editar e apagar
- Gráficos de evolução e estatísticas básicas
- Armazenamento local e sincronização opcional com o iCloud
- Exportação CSV

### v0.2 (Melhorias)

- Exportação PDF com gráficos
- Registo rápido através de widgets e Atalhos
- Interações mais detalhadas com os gráficos, como ampliar e selecionar pontos de dados

### v0.3 (A longo prazo)

- Dimensões de acompanhamento adicionais, como peso, consumo de álcool e toma de medicamentos, mantendo-as opcionais e desativadas por predefinição
- Análises avançadas: variações, evolução do cumprimento do alvo e padrões periódicos
