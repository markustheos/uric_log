<a id="english"></a>

# Acid Uric Log — PostHog Analytics Guide

[English](#english) | [简体中文](#chinese) | [Italiano](#italian) | [Español](#spanish) | [Deutsch](#german) | [Français](#french) | [Português](#portuguese)

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

---

<a id="spanish"></a>

# Diario Ácido Úrico — Guía de eventos de PostHog

## Restricciones de privacidad

- No enviar valores de ácido úrico, valores objetivo, notas, fechas de las mediciones, ID de las mediciones ni información personal almacenada en el dispositivo.
- No enviar directamente objetos de error ni texto libre como propiedades de los eventos.
- Solo se permiten las propiedades con valores enumerados que figuran en este documento.
- Mantener desactivados Session Replay, la captura automática de interacciones con los controles y la captura automática de visualizaciones de pantallas.

## Propiedades comunes

Todos los eventos enviados a través de PostHog incluyen las siguientes propiedades:

| Propiedad | Valores | Descripción |
| --- | --- | --- |
| `environment` | `debug` / `production` | Las compilaciones Debug de Xcode usan `debug`; las compilaciones Release, TestFlight y App Store usan `production` |

## Eventos comunes

| Evento | Cuándo se genera | Propiedades |
| --- | --- | --- |
| `app_launched` | Al finalizar la inicialización de la app | Ninguna |
| `tab_selected` | Cuando el usuario cambia de pestaña en la barra inferior | `tab`: `records` / `trends` / `settings` |
| `storage_error_acknowledged` | Cuando el usuario cierra el aviso de error de inicialización del almacenamiento | Ninguna |

## Mediciones

| Evento | Cuándo se genera | Propiedades |
| --- | --- | --- |
| `records_range_changed` | Cuando el usuario cambia el intervalo de tiempo de la lista de mediciones | `range`: `days7` / `days30` / `days90` / `all` |
| `record_add_tapped` | Cuando el usuario pulsa el botón de añadir | Ninguna |
| `record_opened` | Cuando el usuario pulsa una medición existente | Ninguna |
| `record_editor_cancelled` | Cuando el usuario cancela la creación o edición de una medición | `mode`: `create` / `edit` |
| `record_unit_selected` | Cuando el usuario selecciona una unidad en el editor | `unit`: `umolL` / `mgdL` |
| `record_save_tapped` | Cuando el usuario pulsa el botón de guardar | `mode`: `create` / `edit` |
| `record_saved` | Cuando el guardado en Core Data se completa correctamente | `mode`: `create` / `edit` |
| `record_save_failed` | Cuando falla el guardado en Core Data | `mode`: `create` / `edit` |
| `extreme_value_warning_shown` | Cuando se muestra el diálogo de confirmación de un valor extremo | `mode`: `create` / `edit` |
| `extreme_value_save_cancelled` | Cuando el usuario cancela el guardado de un valor extremo | `mode`: `create` / `edit` |
| `extreme_value_save_confirmed` | Cuando el usuario confirma el guardado de un valor extremo | `mode`: `create` / `edit` |
| `record_delete_requested` | Cuando el usuario selecciona eliminar en el menú contextual | Ninguna |
| `record_delete_cancelled` | Cuando el usuario cancela la confirmación de eliminación | Ninguna |
| `record_delete_confirmed` | Cuando el usuario confirma la eliminación | Ninguna |
| `record_deleted` | Cuando se guarda la eliminación | Ninguna |
| `reference_info_opened` | Cuando el usuario abre la información de referencia | Ninguna |
| `reference_info_closed` | Cuando el usuario cierra la información de referencia | Ninguna |

## Evolución y ajustes

| Evento | Cuándo se genera | Propiedades |
| --- | --- | --- |
| `trends_range_changed` | Cuando el usuario cambia el intervalo de tiempo de los gráficos de evolución | `range`: `days7` / `days30` / `days90` / `all` |
| `preferred_unit_changed` | Cuando el usuario cambia la unidad predeterminada | `unit`: `umolL` / `mgdL` |
| `gender_setting_changed` | Cuando el usuario cambia el ajuste de sexo | Ninguna; no enviar el valor seleccionado |
| `target_setting_toggled` | Cuando el usuario activa o desactiva la función del valor objetivo | Ninguna; no enviar el estado de activación ni el valor objetivo |
| `icloud_sync_toggled` | Cuando el usuario activa o desactiva la sincronización con iCloud | Ninguna |
| `icloud_restart_hint_acknowledged` | Cuando el usuario cierra el aviso de reinicio | Ninguna |

## Exportación

| Evento | Cuándo se genera | Propiedades |
| --- | --- | --- |
| `export_range_changed` | Cuando el usuario cambia el intervalo de exportación CSV | `range`: `days7` / `days30` / `days90` / `all` |
| `csv_export_tapped` | Cuando el usuario solicita la generación de un archivo CSV | `range`: como se indica arriba |
| `csv_export_succeeded` | Cuando el archivo CSV se genera correctamente | Ninguna |
| `csv_export_failed` | Cuando falla la generación del archivo CSV | Ninguna; no enviar el texto del error |
| `csv_share_tapped` | Cuando se abre el menú de compartir del sistema | Ninguna |

## Reglas para añadir eventos

Enviar todos los eventos a través de `Analytics.track`. Antes de añadir un evento, actualizar este documento y comprobar que sus propiedades no contienen datos de salud, texto libre, información temporal, identificadores únicos ni información que permita reconstruir las mediciones del usuario.

---

<a id="german"></a>

# Harnsäure-Tagebuch — Leitfaden für PostHog-Ereignisse

## Datenschutzvorgaben

- Keine Harnsäurewerte, Zielwerte, Notizen, Datumsangaben der Messungen, Datensatz-IDs oder auf dem Gerät gespeicherten personenbezogenen Informationen hochladen.
- Keine Fehlerobjekte oder Freitexte direkt als Ereigniseigenschaften hochladen.
- Ausschließlich die in diesem Dokument aufgeführten Eigenschaften mit fest vorgegebenen Werten verwenden.
- Session Replay, die automatische Erfassung von Interaktionen mit Bedienelementen und die automatische Erfassung von Bildschirmaufrufen deaktiviert lassen.

## Gemeinsame Eigenschaften

Alle über PostHog gesendeten Ereignisse enthalten die folgenden Eigenschaften:

| Eigenschaft | Werte | Beschreibung |
| --- | --- | --- |
| `environment` | `debug` / `production` | Xcode-Debug-Builds verwenden `debug`; Release-, TestFlight- und App-Store-Builds verwenden `production` |

## Allgemeine Ereignisse

| Ereignis | Auslöser | Eigenschaften |
| --- | --- | --- |
| `app_launched` | Die Initialisierung der App ist abgeschlossen | Keine |
| `tab_selected` | Die nutzende Person wechselt zwischen den Tabs in der unteren Leiste | `tab`: `records` / `trends` / `settings` |
| `storage_error_acknowledged` | Die nutzende Person schließt den Hinweis auf einen Fehler bei der Initialisierung des Datenspeichers | Keine |

## Messungen

| Ereignis | Auslöser | Eigenschaften |
| --- | --- | --- |
| `records_range_changed` | Die nutzende Person ändert den Zeitraum der Messungsliste | `range`: `days7` / `days30` / `days90` / `all` |
| `record_add_tapped` | Die nutzende Person tippt auf die Schaltfläche zum Hinzufügen | Keine |
| `record_opened` | Die nutzende Person tippt auf eine vorhandene Messung | Keine |
| `record_editor_cancelled` | Die nutzende Person bricht das Erstellen oder Bearbeiten einer Messung ab | `mode`: `create` / `edit` |
| `record_unit_selected` | Die nutzende Person wählt im Editor eine Einheit aus | `unit`: `umolL` / `mgdL` |
| `record_save_tapped` | Die nutzende Person tippt auf Speichern | `mode`: `create` / `edit` |
| `record_saved` | Das Speichern in Core Data ist erfolgreich | `mode`: `create` / `edit` |
| `record_save_failed` | Das Speichern in Core Data schlägt fehl | `mode`: `create` / `edit` |
| `extreme_value_warning_shown` | Der Bestätigungsdialog für einen extremen Wert wird angezeigt | `mode`: `create` / `edit` |
| `extreme_value_save_cancelled` | Die nutzende Person bricht das Speichern eines extremen Wertes ab | `mode`: `create` / `edit` |
| `extreme_value_save_confirmed` | Die nutzende Person bestätigt das Speichern eines extremen Wertes | `mode`: `create` / `edit` |
| `record_delete_requested` | Die nutzende Person wählt im Kontextmenü die Löschoption aus | Keine |
| `record_delete_cancelled` | Die nutzende Person bricht die Löschbestätigung ab | Keine |
| `record_delete_confirmed` | Die nutzende Person bestätigt das Löschen | Keine |
| `record_deleted` | Die Löschung wird gespeichert | Keine |
| `reference_info_opened` | Die nutzende Person öffnet die Referenzinformationen | Keine |
| `reference_info_closed` | Die nutzende Person schließt die Referenzinformationen | Keine |

## Verlauf und Einstellungen

| Ereignis | Auslöser | Eigenschaften |
| --- | --- | --- |
| `trends_range_changed` | Die nutzende Person ändert den Zeitraum des Verlaufs | `range`: `days7` / `days30` / `days90` / `all` |
| `preferred_unit_changed` | Die nutzende Person ändert die Standardeinheit | `unit`: `umolL` / `mgdL` |
| `gender_setting_changed` | Die nutzende Person ändert die Einstellung für das Geschlecht | Keine; den ausgewählten Wert nicht hochladen |
| `target_setting_toggled` | Die nutzende Person aktiviert oder deaktiviert die Zielwertfunktion | Keine; weder den Aktivierungsstatus noch den Zielwert hochladen |
| `icloud_sync_toggled` | Die nutzende Person aktiviert oder deaktiviert die iCloud-Synchronisierung | Keine |
| `icloud_restart_hint_acknowledged` | Die nutzende Person schließt den Neustarthinweis | Keine |

## Export

| Ereignis | Auslöser | Eigenschaften |
| --- | --- | --- |
| `export_range_changed` | Die nutzende Person ändert den Zeitraum für den CSV-Export | `range`: `days7` / `days30` / `days90` / `all` |
| `csv_export_tapped` | Die nutzende Person fordert die Erstellung einer CSV-Datei an | `range`: wie oben |
| `csv_export_succeeded` | Die CSV-Datei wird erfolgreich erstellt | Keine |
| `csv_export_failed` | Die Erstellung der CSV-Datei schlägt fehl | Keine; den Fehlertext nicht hochladen |
| `csv_share_tapped` | Der Teilen-Dialog des Systems wird geöffnet | Keine |

## Regeln zum Hinzufügen von Ereignissen

Alle Ereignisse über `Analytics.track` senden. Vor dem Hinzufügen eines Ereignisses dieses Dokument aktualisieren und prüfen, dass die Eigenschaften keine Gesundheitsdaten, Freitexte, Zeitangaben, eindeutigen Kennungen oder Informationen enthalten, mit denen sich die Messungen einer Person rekonstruieren lassen.

---

<a id="french"></a>

# Journal Aacide Urique — Guide des événements PostHog

## Contraintes de confidentialité

- Ne pas transmettre de valeurs d’acide urique, de valeurs cibles, de notes, de dates de mesure, d’identifiants de mesures ni d’informations personnelles stockées sur l’appareil.
- Ne pas transmettre directement d’objets d’erreur ni de texte libre comme propriétés des événements.
- Seules les propriétés aux valeurs énumérées dans ce document sont autorisées.
- Garder désactivés Session Replay, la collecte automatique des interactions avec les commandes et la collecte automatique des affichages d’écrans.

## Propriétés communes

Tous les événements envoyés via PostHog incluent les propriétés suivantes :

| Propriété | Valeurs | Description |
| --- | --- | --- |
| `environment` | `debug` / `production` | Les compilations Debug de Xcode utilisent `debug` ; les compilations Release, TestFlight et App Store utilisent `production` |

## Événements communs

| Événement | Déclencheur | Propriétés |
| --- | --- | --- |
| `app_launched` | L’initialisation de l’app est terminée | Aucune |
| `tab_selected` | L’utilisateur change d’onglet dans la barre inférieure | `tab`: `records` / `trends` / `settings` |
| `storage_error_acknowledged` | L’utilisateur ferme l’alerte d’erreur d’initialisation du stockage | Aucune |

## Mesures

| Événement | Déclencheur | Propriétés |
| --- | --- | --- |
| `records_range_changed` | L’utilisateur modifie la période de la liste des mesures | `range`: `days7` / `days30` / `days90` / `all` |
| `record_add_tapped` | L’utilisateur touche le bouton d’ajout | Aucune |
| `record_opened` | L’utilisateur touche une mesure existante | Aucune |
| `record_editor_cancelled` | L’utilisateur annule la création ou la modification d’une mesure | `mode`: `create` / `edit` |
| `record_unit_selected` | L’utilisateur sélectionne une unité dans l’éditeur | `unit`: `umolL` / `mgdL` |
| `record_save_tapped` | L’utilisateur touche le bouton d’enregistrement | `mode`: `create` / `edit` |
| `record_saved` | L’enregistrement dans Core Data réussit | `mode`: `create` / `edit` |
| `record_save_failed` | L’enregistrement dans Core Data échoue | `mode`: `create` / `edit` |
| `extreme_value_warning_shown` | La boîte de dialogue de confirmation d’une valeur extrême s’affiche | `mode`: `create` / `edit` |
| `extreme_value_save_cancelled` | L’utilisateur annule l’enregistrement d’une valeur extrême | `mode`: `create` / `edit` |
| `extreme_value_save_confirmed` | L’utilisateur confirme l’enregistrement d’une valeur extrême | `mode`: `create` / `edit` |
| `record_delete_requested` | L’utilisateur sélectionne la suppression dans le menu contextuel | Aucune |
| `record_delete_cancelled` | L’utilisateur annule la confirmation de suppression | Aucune |
| `record_delete_confirmed` | L’utilisateur confirme la suppression | Aucune |
| `record_deleted` | La suppression est enregistrée | Aucune |
| `reference_info_opened` | L’utilisateur ouvre les informations de référence | Aucune |
| `reference_info_closed` | L’utilisateur ferme les informations de référence | Aucune |

## Évolution et réglages

| Événement | Déclencheur | Propriétés |
| --- | --- | --- |
| `trends_range_changed` | L’utilisateur modifie la période du graphique d’évolution | `range`: `days7` / `days30` / `days90` / `all` |
| `preferred_unit_changed` | L’utilisateur modifie l’unité par défaut | `unit`: `umolL` / `mgdL` |
| `gender_setting_changed` | L’utilisateur modifie le réglage du sexe | Aucune ; ne pas transmettre la valeur sélectionnée |
| `target_setting_toggled` | L’utilisateur active ou désactive la fonction de valeur cible | Aucune ; ne transmettre ni l’état d’activation ni la valeur cible |
| `icloud_sync_toggled` | L’utilisateur active ou désactive la synchronisation iCloud | Aucune |
| `icloud_restart_hint_acknowledged` | L’utilisateur ferme l’avis de redémarrage | Aucune |

## Exportation

| Événement | Déclencheur | Propriétés |
| --- | --- | --- |
| `export_range_changed` | L’utilisateur modifie la période d’exportation CSV | `range`: `days7` / `days30` / `days90` / `all` |
| `csv_export_tapped` | L’utilisateur demande la génération d’un fichier CSV | `range`: comme ci-dessus |
| `csv_export_succeeded` | Le fichier CSV est généré avec succès | Aucune |
| `csv_export_failed` | La génération du fichier CSV échoue | Aucune ; ne pas transmettre le texte de l’erreur |
| `csv_share_tapped` | La feuille de partage du système s’ouvre | Aucune |

## Règles d’ajout d’événements

Envoyer tous les événements via `Analytics.track`. Avant d’ajouter un événement, mettre à jour ce document et vérifier que ses propriétés ne contiennent ni données de santé, ni texte libre, ni indications temporelles, ni identifiants uniques, ni informations permettant de reconstituer les mesures de l’utilisateur.

---

<a id="portuguese"></a>

# Diário Ácido Úrico — Guia de eventos do PostHog

## Restrições de privacidade

- Não enviar valores de ácido úrico, valores objetivo, notas, datas das medições, identificadores das medições nem informações pessoais armazenadas no dispositivo.
- Não enviar diretamente objetos de erro nem texto livre como propriedades dos eventos.
- Só são permitidas as propriedades com valores enumerados indicadas neste documento.
- Manter desativados o Session Replay, a recolha automática de interações com os controlos e a recolha automática de visualizações de ecrãs.

## Propriedades comuns

Todos os eventos enviados através do PostHog incluem as seguintes propriedades:

| Propriedade | Valores | Descrição |
| --- | --- | --- |
| `environment` | `debug` / `production` | As compilações Debug do Xcode utilizam `debug`; as compilações Release, TestFlight e App Store utilizam `production` |

## Eventos comuns

| Evento | Quando é gerado | Propriedades |
| --- | --- | --- |
| `app_launched` | Quando a inicialização da app termina | Nenhuma |
| `tab_selected` | Quando o utilizador muda de separador na barra inferior | `tab`: `records` / `trends` / `settings` |
| `storage_error_acknowledged` | Quando o utilizador fecha o aviso de erro de inicialização do armazenamento | Nenhuma |

## Medições

| Evento | Quando é gerado | Propriedades |
| --- | --- | --- |
| `records_range_changed` | Quando o utilizador altera o intervalo de tempo da lista de medições | `range`: `days7` / `days30` / `days90` / `all` |
| `record_add_tapped` | Quando o utilizador toca no botão de adicionar | Nenhuma |
| `record_opened` | Quando o utilizador toca numa medição existente | Nenhuma |
| `record_editor_cancelled` | Quando o utilizador cancela a criação ou edição de uma medição | `mode`: `create` / `edit` |
| `record_unit_selected` | Quando o utilizador seleciona uma unidade no editor | `unit`: `umolL` / `mgdL` |
| `record_save_tapped` | Quando o utilizador toca no botão de guardar | `mode`: `create` / `edit` |
| `record_saved` | Quando a gravação no Core Data é concluída com êxito | `mode`: `create` / `edit` |
| `record_save_failed` | Quando a gravação no Core Data falha | `mode`: `create` / `edit` |
| `extreme_value_warning_shown` | Quando é apresentado o diálogo de confirmação de um valor extremo | `mode`: `create` / `edit` |
| `extreme_value_save_cancelled` | Quando o utilizador cancela a gravação de um valor extremo | `mode`: `create` / `edit` |
| `extreme_value_save_confirmed` | Quando o utilizador confirma a gravação de um valor extremo | `mode`: `create` / `edit` |
| `record_delete_requested` | Quando o utilizador seleciona a opção de eliminar no menu de contexto | Nenhuma |
| `record_delete_cancelled` | Quando o utilizador cancela a confirmação de eliminação | Nenhuma |
| `record_delete_confirmed` | Quando o utilizador confirma a eliminação | Nenhuma |
| `record_deleted` | Quando a eliminação é guardada | Nenhuma |
| `reference_info_opened` | Quando o utilizador abre as informações de referência | Nenhuma |
| `reference_info_closed` | Quando o utilizador fecha as informações de referência | Nenhuma |

## Evolução e definições

| Evento | Quando é gerado | Propriedades |
| --- | --- | --- |
| `trends_range_changed` | Quando o utilizador altera o intervalo de tempo do gráfico de evolução | `range`: `days7` / `days30` / `days90` / `all` |
| `preferred_unit_changed` | Quando o utilizador altera a unidade predefinida | `unit`: `umolL` / `mgdL` |
| `gender_setting_changed` | Quando o utilizador altera a definição de sexo | Nenhuma; não enviar o valor selecionado |
| `target_setting_toggled` | Quando o utilizador ativa ou desativa a função do valor objetivo | Nenhuma; não enviar o estado de ativação nem o valor objetivo |
| `icloud_sync_toggled` | Quando o utilizador ativa ou desativa a sincronização com o iCloud | Nenhuma |
| `icloud_restart_hint_acknowledged` | Quando o utilizador fecha o aviso de reinício | Nenhuma |

## Exportação

| Evento | Quando é gerado | Propriedades |
| --- | --- | --- |
| `export_range_changed` | Quando o utilizador altera o intervalo de exportação CSV | `range`: `days7` / `days30` / `days90` / `all` |
| `csv_export_tapped` | Quando o utilizador solicita a criação de um ficheiro CSV | `range`: conforme indicado acima |
| `csv_export_succeeded` | Quando o ficheiro CSV é criado com êxito | Nenhuma |
| `csv_export_failed` | Quando a criação do ficheiro CSV falha | Nenhuma; não enviar o texto do erro |
| `csv_share_tapped` | Quando se abre a folha de partilha do sistema | Nenhuma |

## Regras para adicionar eventos

Enviar todos os eventos através de `Analytics.track`. Antes de adicionar um evento, atualizar este documento e verificar que as suas propriedades não contêm dados de saúde, texto livre, informações temporais, identificadores únicos nem informações que permitam reconstruir as medições do utilizador.
