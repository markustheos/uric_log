<a id="english"></a>

# Acid Uric Log — PostHog Analytics Guide

[English](#english) | [简体中文](#chinese) | [Italiano](#italian)

## Privacy constraints

- Do not upload uric acid readings, target values, notes, measurement dates, record IDs, or personal information stored on the device.
- Do not upload error objects or free text directly as event properties.
- Only the enumerated properties listed in this document are permitted.
- Keep Session Replay, automatic control interaction tracking, and automatic screen-view tracking disabled.

## Common properties

Every event sent through PostHog includes the following properties:

| Property | Values | Description |
| --- | --- | --- |
| `environment` | `debug` / `production` | Xcode Debug builds use `debug`; Release, TestFlight, and App Store builds use `production` |

## Common events

| Event | Trigger | Properties |
| --- | --- | --- |
| `app_launched` | App initialization completes | None |
| `tab_selected` | The user switches between bottom tabs | `tab`: `records` / `trends` / `settings` |
| `storage_error_acknowledged` | The user dismisses the storage initialization error alert | None |

## Records

| Event | Trigger | Properties |
| --- | --- | --- |
| `records_range_changed` | The user changes the records list time range | `range`: `days7` / `days30` / `days90` / `all` |
| `record_add_tapped` | The user taps the add button | None |
| `record_opened` | The user taps an existing record | None |
| `record_editor_cancelled` | The user cancels record creation or editing | `mode`: `create` / `edit` |
| `record_unit_selected` | The user selects a unit in the editor | `unit`: `umolL` / `mgdL` |
| `record_save_tapped` | The user taps save | `mode`: `create` / `edit` |
| `record_saved` | The Core Data save succeeds | `mode`: `create` / `edit` |
| `record_save_failed` | The Core Data save fails | `mode`: `create` / `edit` |
| `extreme_value_warning_shown` | The extreme value confirmation dialog appears | `mode`: `create` / `edit` |
| `extreme_value_save_cancelled` | The user cancels saving an extreme value | `mode`: `create` / `edit` |
| `extreme_value_save_confirmed` | The user confirms saving an extreme value | `mode`: `create` / `edit` |
| `record_delete_requested` | The user selects delete from the context menu | None |
| `record_delete_cancelled` | The user cancels the deletion confirmation | None |
| `record_delete_confirmed` | The user confirms deletion | None |
| `record_deleted` | The deletion is saved | None |
| `reference_info_opened` | The user opens reference information | None |
| `reference_info_closed` | The user closes reference information | None |

## Trends and settings

| Event | Trigger | Properties |
| --- | --- | --- |
| `trends_range_changed` | The user changes the trends time range | `range`: `days7` / `days30` / `days90` / `all` |
| `preferred_unit_changed` | The user changes the default unit | `unit`: `umolL` / `mgdL` |
| `gender_setting_changed` | The user changes the sex setting | None; do not upload the selected value |
| `target_setting_toggled` | The user toggles the target value feature | None; do not upload the enabled state or target value |
| `icloud_sync_toggled` | The user toggles iCloud sync | None |
| `icloud_restart_hint_acknowledged` | The user dismisses the restart notice | None |

## Export

| Event | Trigger | Properties |
| --- | --- | --- |
| `export_range_changed` | The user changes the CSV export range | `range`: `days7` / `days30` / `days90` / `all` |
| `csv_export_tapped` | The user taps to generate a CSV file | `range`: as above |
| `csv_export_succeeded` | The CSV file is generated successfully | None |
| `csv_export_failed` | CSV file generation fails | None; do not upload error text |
| `csv_share_tapped` | The system share sheet opens | None |

## Rules for adding events

Send every event through `Analytics.track`. Before adding an event, update this document and verify that its properties contain no health data, free text, times, unique identifiers, or information that could be used to reconstruct a user's records.

---

<a id="chinese"></a>

# PostHog 埋点说明

## 隐私约束

- 禁止上传尿酸数值、目标值、备注、测量日期、记录 ID 或设备中的个人信息。
- 禁止把错误对象和自由文本直接作为事件属性上传。
- 只允许使用本文档列出的枚举属性。
- Session Replay、控件自动采集和自动页面采集保持关闭。

## 公共属性

所有通过 PostHog 发送的事件都包含以下属性：

| 属性 | 取值 | 说明 |
| --- | --- | --- |
| `environment` | `debug` / `production` | Xcode Debug 构建使用 `debug`，Release、TestFlight 和 App Store 构建使用 `production` |

## 公共事件

| 事件 | 触发时机 | 属性 |
| --- | --- | --- |
| `app_launched` | App 初始化完成 | 无 |
| `tab_selected` | 切换底部 Tab | `tab`: `records` / `trends` / `settings` |
| `storage_error_acknowledged` | 关闭存储初始化错误提示 | 无 |

## 记录

| 事件 | 触发时机 | 属性 |
| --- | --- | --- |
| `records_range_changed` | 修改记录列表时间范围 | `range`: `days7` / `days30` / `days90` / `all` |
| `record_add_tapped` | 点击新增按钮 | 无 |
| `record_opened` | 点击已有记录 | 无 |
| `record_editor_cancelled` | 取消新增或编辑 | `mode`: `create` / `edit` |
| `record_unit_selected` | 在编辑器选择单位 | `unit`: `umolL` / `mgdL` |
| `record_save_tapped` | 点击保存 | `mode`: `create` / `edit` |
| `record_saved` | Core Data 保存成功 | `mode`: `create` / `edit` |
| `record_save_failed` | Core Data 保存失败 | `mode`: `create` / `edit` |
| `extreme_value_warning_shown` | 显示异常数值确认框 | `mode`: `create` / `edit` |
| `extreme_value_save_cancelled` | 取消保存异常数值 | `mode`: `create` / `edit` |
| `extreme_value_save_confirmed` | 确认保存异常数值 | `mode`: `create` / `edit` |
| `record_delete_requested` | 从上下文菜单点击删除 | 无 |
| `record_delete_cancelled` | 取消删除确认 | 无 |
| `record_delete_confirmed` | 确认删除 | 无 |
| `record_deleted` | 删除操作保存完成 | 无 |
| `reference_info_opened` | 打开参考信息 | 无 |
| `reference_info_closed` | 关闭参考信息 | 无 |

## 趋势与设置

| 事件 | 触发时机 | 属性 |
| --- | --- | --- |
| `trends_range_changed` | 修改趋势时间范围 | `range`: `days7` / `days30` / `days90` / `all` |
| `preferred_unit_changed` | 修改默认单位 | `unit`: `umolL` / `mgdL` |
| `gender_setting_changed` | 修改性别设置 | 无，不上传具体选择 |
| `target_setting_toggled` | 切换目标值功能 | 无，不上传状态或目标数值 |
| `icloud_sync_toggled` | 切换 iCloud 同步 | 无 |
| `icloud_restart_hint_acknowledged` | 关闭重启提示 | 无 |

## 导出

| 事件 | 触发时机 | 属性 |
| --- | --- | --- |
| `export_range_changed` | 修改 CSV 导出范围 | `range`: `days7` / `days30` / `days90` / `all` |
| `csv_export_tapped` | 点击生成 CSV | `range`: 同上 |
| `csv_export_succeeded` | CSV 文件生成成功 | 无 |
| `csv_export_failed` | CSV 文件生成失败 | 无，不上传错误文本 |
| `csv_share_tapped` | 打开系统分享面板 | 无 |

## 新增事件规范

所有事件通过 `Analytics.track` 发送。新增事件前必须更新本文档，并确认属性不包含健康数据、自由文本、时间、唯一标识符或可用于重建用户记录的信息。

---

<a id="italian"></a>

# Diario Acido Urico — Guida agli eventi PostHog

## Vincoli sulla privacy

- Non inviare valori di acido urico, valori obiettivo, note, date delle misurazioni, ID delle registrazioni o informazioni personali presenti sul dispositivo.
- Non inviare direttamente oggetti di errore o testo libero come proprietà degli eventi.
- Sono consentite esclusivamente le proprietà con valori enumerati elencate in questo documento.
- Mantieni disattivati Session Replay, la raccolta automatica delle interazioni con i controlli e la raccolta automatica delle visualizzazioni delle schermate.

## Proprietà comuni

Tutti gli eventi inviati tramite PostHog includono le seguenti proprietà:

| Proprietà | Valori | Descrizione |
| --- | --- | --- |
| `environment` | `debug` / `production` | Le build Debug di Xcode usano `debug`; le build Release, TestFlight e App Store usano `production` |

## Eventi comuni

| Evento | Quando viene generato | Proprietà |
| --- | --- | --- |
| `app_launched` | Al termine dell'inizializzazione dell'app | Nessuna |
| `tab_selected` | Quando l'utente cambia scheda nella barra inferiore | `tab`: `records` / `trends` / `settings` |
| `storage_error_acknowledged` | Quando l'utente chiude l'avviso di errore di inizializzazione dell'archivio | Nessuna |

## Registrazioni

| Evento | Quando viene generato | Proprietà |
| --- | --- | --- |
| `records_range_changed` | Quando l'utente modifica l'intervallo temporale dell'elenco delle registrazioni | `range`: `days7` / `days30` / `days90` / `all` |
| `record_add_tapped` | Quando l'utente tocca il pulsante di aggiunta | Nessuna |
| `record_opened` | Quando l'utente tocca una registrazione esistente | Nessuna |
| `record_editor_cancelled` | Quando l'utente annulla la creazione o la modifica di una registrazione | `mode`: `create` / `edit` |
| `record_unit_selected` | Quando l'utente seleziona un'unità nell'editor | `unit`: `umolL` / `mgdL` |
| `record_save_tapped` | Quando l'utente tocca il pulsante di salvataggio | `mode`: `create` / `edit` |
| `record_saved` | Quando il salvataggio in Core Data riesce | `mode`: `create` / `edit` |
| `record_save_failed` | Quando il salvataggio in Core Data non riesce | `mode`: `create` / `edit` |
| `extreme_value_warning_shown` | Quando viene mostrata la finestra di conferma per un valore estremo | `mode`: `create` / `edit` |
| `extreme_value_save_cancelled` | Quando l'utente annulla il salvataggio di un valore estremo | `mode`: `create` / `edit` |
| `extreme_value_save_confirmed` | Quando l'utente conferma il salvataggio di un valore estremo | `mode`: `create` / `edit` |
| `record_delete_requested` | Quando l'utente seleziona l'eliminazione dal menu contestuale | Nessuna |
| `record_delete_cancelled` | Quando l'utente annulla la conferma di eliminazione | Nessuna |
| `record_delete_confirmed` | Quando l'utente conferma l'eliminazione | Nessuna |
| `record_deleted` | Quando viene salvata l'eliminazione | Nessuna |
| `reference_info_opened` | Quando l'utente apre le informazioni di riferimento | Nessuna |
| `reference_info_closed` | Quando l'utente chiude le informazioni di riferimento | Nessuna |

## Andamento e impostazioni

| Evento | Quando viene generato | Proprietà |
| --- | --- | --- |
| `trends_range_changed` | Quando l'utente modifica l'intervallo temporale dei grafici dell'andamento | `range`: `days7` / `days30` / `days90` / `all` |
| `preferred_unit_changed` | Quando l'utente modifica l'unità predefinita | `unit`: `umolL` / `mgdL` |
| `gender_setting_changed` | Quando l'utente modifica l'impostazione del sesso | Nessuna; non inviare il valore selezionato |
| `target_setting_toggled` | Quando l'utente attiva o disattiva la funzione del valore obiettivo | Nessuna; non inviare lo stato di attivazione né il valore obiettivo |
| `icloud_sync_toggled` | Quando l'utente attiva o disattiva la sincronizzazione iCloud | Nessuna |
| `icloud_restart_hint_acknowledged` | Quando l'utente chiude l'avviso di riavvio | Nessuna |

## Esportazione

| Evento | Quando viene generato | Proprietà |
| --- | --- | --- |
| `export_range_changed` | Quando l'utente modifica l'intervallo di esportazione CSV | `range`: `days7` / `days30` / `days90` / `all` |
| `csv_export_tapped` | Quando l'utente richiede la generazione di un file CSV | `range`: come sopra |
| `csv_export_succeeded` | Quando il file CSV viene generato correttamente | Nessuna |
| `csv_export_failed` | Quando la generazione del file CSV non riesce | Nessuna; non inviare il testo dell'errore |
| `csv_share_tapped` | Quando si apre il pannello di condivisione del sistema | Nessuna |

## Regole per aggiungere eventi

Invia tutti gli eventi tramite `Analytics.track`. Prima di aggiungere un evento, aggiorna questo documento e verifica che le proprietà non contengano dati sanitari, testo libero, indicazioni temporali, identificatori univoci o informazioni che consentano di ricostruire le registrazioni dell'utente.
