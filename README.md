<a id="english"></a>

# Acid Uric Log (UricLog)

[English](#english) | [简体中文](#chinese) | [Italiano](#italian) | [Español](#spanish) | [Deutsch](#german) | [Français](#french) | [Português](#portuguese)

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

---

<a id="spanish"></a>

# Diario Ácido Úrico (UricLog)

Una app para iOS gratuita, sencilla y centrada en la privacidad para registrar los valores de ácido úrico y consultar su evolución.

Principio fundamental: centrarse en el registro, la evolución y la exportación de datos. La app no ofrece diagnósticos médicos ni recomendaciones terapéuticas.

## Funcionalidades

- Mediciones: añade, modifica y elimina valores de ácido úrico, con la fecha, la hora de la medición y notas
- Unidades: cambia entre `μmol/L` y `mg/dL` en cualquier momento
- Intervalos de referencia: consulta los intervalos habituales según el sexo, con fuentes y referencias disponibles para verificarlos
- Evolución: consulta gráficos y resúmenes estadísticos de los últimos 7, 30 o 90 días, o de todas las mediciones; puedes establecer un valor objetivo
- Exportación: exporta las mediciones en formato CSV para las consultas médicas o para tus propios análisis
- Sincronización opcional: sincroniza las mediciones a través de iCloud (CloudKit) y los ajustes principales, como el sexo y el valor objetivo, a través de iCloud Key-Value Store

## Estructura del proyecto

- `UricLog/`
  - `UricLogApp.swift`: punto de entrada de la app
  - `Views/`: pantallas de SwiftUI
    - `RecordsListView.swift`: lista de mediciones
    - `RecordEditorView.swift`: creación y edición de mediciones; incluye acceso a información de referencia, fuentes y citas
    - `TrendsView.swift`: gráficos de evolución y estadísticas
    - `SettingsView.swift`: ajustes de unidades, sexo, valor objetivo, iCloud, exportación y otras opciones
  - `Models/`: modelos de dominio y claves de los ajustes
    - `UricAcidRecord.swift`: extensiones de la entidad de Core Data y lógica de creación de mediciones
    - `Unit.swift`: conversión de unidades, intervalos de referencia según el sexo y claves de los ajustes (`AppSettingsKey`)
  - `Persistence/`: persistencia de datos e iCloud
    - `Persistence.swift`: configuración del contenedor de Core Data / CloudKit
    - `PersistenceController.swift`: carga del contenedor, estado de iCloud y eventos de sincronización
  - `Utils/`
    - `CSVExporter.swift`: exportación CSV
    - `DateFormatter.swift`: formato de fechas
    - `ICloudSettingsSync.swift`: sincronización de los ajustes a través de iCloud Key-Value Store
- `doc/PRD.md`: documento de requisitos del producto (PRD)
- `site/privacy-policy.html`: política de privacidad para la publicación en el App Store

## Ejecución en local

1. Instala las dependencias: `pod install`
2. Abre `UricLog.xcworkspace` en Xcode
3. Selecciona el esquema `UricLog`
4. Ejecuta la app en un simulador o en un dispositivo físico

## Sincronización con iCloud

- Las mediciones se sincronizan a través de CloudKit + Core Data (`NSPersistentCloudKitContainer`)
- Los ajustes se sincronizan a través de `NSUbiquitousKeyValueStore` con estas claves:
  - `userGender`
  - `targetEnabled`
  - `targetValue`
  - `preferredUnit`

Puedes activar la sincronización con el interruptor de iCloud en los ajustes. Cuando está desactivada, la app sigue funcionando con normalidad en local.

## Aviso

La app está destinada exclusivamente al registro personal y a la consulta de los datos. No ofrece consejos médicos ni constituye una base para el diagnóstico. En caso de valores anómalos, consulta a un profesional médico cualificado.

---

<a id="german"></a>

# Harnsäure-Tagebuch (UricLog)

Eine kostenlose, schlichte iOS-App zum Erfassen von Harnsäurewerten und Anzeigen von Verläufen, bei der der Datenschutz im Mittelpunkt steht.

Grundprinzip: Konzentration auf die Erfassung, den Verlauf und den Export von Daten. Die App stellt keine medizinischen Diagnosen und gibt keine Behandlungsempfehlungen.

## Funktionen

- Messungen: Harnsäurewerte mit Messdatum, Uhrzeit und Notizen hinzufügen, bearbeiten und löschen
- Einheiten: jederzeit zwischen `μmol/L` und `mg/dL` wechseln
- Referenzbereiche: gängige Referenzbereiche nach Geschlecht anzeigen; Quellen und Referenzen stehen zur Überprüfung zur Verfügung
- Verlauf: Diagramme und statistische Zusammenfassungen der letzten 7, 30 oder 90 Tage oder aller Messungen anzeigen; ein Zielwert kann festgelegt werden
- Export: Messungen als CSV für Arzttermine oder eigene Auswertungen exportieren
- Optionale Synchronisierung: Messungen über iCloud (CloudKit) und wichtige Einstellungen wie Geschlecht und Zielwert über den iCloud Key-Value Store synchronisieren

## Projektstruktur

- `UricLog/`
  - `UricLogApp.swift`: Einstiegspunkt der App
  - `Views/`: SwiftUI-Ansichten
    - `RecordsListView.swift`: Liste der Messungen
    - `RecordEditorView.swift`: Messungen hinzufügen und bearbeiten; enthält den Zugang zu Referenzinformationen, Quellen und Zitaten
    - `TrendsView.swift`: Verlaufsdiagramme und Statistiken
    - `SettingsView.swift`: Einstellungen für Einheiten, Geschlecht, Zielwert, iCloud, Export und weitere Optionen
  - `Models/`: Domänenmodelle und Einstellungsschlüssel
    - `UricAcidRecord.swift`: Erweiterungen der Core-Data-Entität und Logik zum Erstellen von Messungen
    - `Unit.swift`: Einheitenumrechnung, Referenzbereiche nach Geschlecht und Einstellungsschlüssel (`AppSettingsKey`)
  - `Persistence/`: Datenpersistenz und iCloud
    - `Persistence.swift`: Konfiguration des Core-Data-/CloudKit-Containers
    - `PersistenceController.swift`: Laden des Containers, iCloud-Status und Synchronisierungsereignisse
  - `Utils/`
    - `CSVExporter.swift`: CSV-Export
    - `DateFormatter.swift`: Datumsformatierung
    - `ICloudSettingsSync.swift`: Synchronisierung der Einstellungen über den iCloud Key-Value Store
- `doc/PRD.md`: Produktanforderungsdokument (PRD)
- `site/privacy-policy.html`: Datenschutzerklärung für die Veröffentlichung im App Store

## Lokal ausführen

1. Abhängigkeiten installieren: `pod install`
2. `UricLog.xcworkspace` in Xcode öffnen
3. Das Schema `UricLog` auswählen
4. Die App in einem Simulator oder auf einem physischen Gerät ausführen

## iCloud-Synchronisierung

- Messungen werden über CloudKit + Core Data (`NSPersistentCloudKitContainer`) synchronisiert
- Einstellungen werden über `NSUbiquitousKeyValueStore` mit diesen Schlüsseln synchronisiert:
  - `userGender`
  - `targetEnabled`
  - `targetValue`
  - `preferredUnit`

Die Synchronisierung lässt sich mit dem iCloud-Schalter in den Einstellungen aktivieren. Ist sie deaktiviert, bleibt die App lokal vollständig nutzbar.

## Haftungsausschluss

Diese App dient ausschließlich der persönlichen Dokumentation und Information. Sie bietet keine medizinische Beratung und ist keine Grundlage für eine Diagnose. Wende dich bei auffälligen Werten an eine qualifizierte medizinische Fachperson.

---

<a id="french"></a>

# Journal Aacide Urique (UricLog)

Une app iOS gratuite, minimaliste et respectueuse de la vie privée pour enregistrer les valeurs d’acide urique et suivre leur évolution.

Principe fondamental : se concentrer sur l’enregistrement, l’évolution et l’exportation des données. L’app ne fournit aucun diagnostic médical ni conseil thérapeutique.

## Fonctionnalités

- Mesures : ajouter, modifier et supprimer des valeurs d’acide urique, avec la date et l’heure de la mesure ainsi que des notes
- Unités : passer de `μmol/L` à `mg/dL` et inversement à tout moment
- Intervalles de référence : afficher les intervalles courants selon le sexe, avec des sources et références consultables pour les vérifier
- Évolution : consulter les graphiques et les résumés statistiques des 7, 30 ou 90 derniers jours, ou de toutes les mesures ; possibilité de définir une valeur cible
- Exportation : exporter les mesures au format CSV pour les consultations médicales ou ses propres analyses
- Synchronisation facultative : synchroniser les mesures via iCloud (CloudKit) et les principaux réglages, comme le sexe et la valeur cible, via iCloud Key-Value Store

## Structure du projet

- `UricLog/`
  - `UricLogApp.swift` : point d’entrée de l’app
  - `Views/` : écrans SwiftUI
    - `RecordsListView.swift` : liste des mesures
    - `RecordEditorView.swift` : ajout et modification des mesures ; donne accès aux informations de référence, aux sources et aux citations
    - `TrendsView.swift` : graphiques d’évolution et statistiques
    - `SettingsView.swift` : réglages des unités, du sexe, de la valeur cible, d’iCloud, de l’exportation et d’autres options
  - `Models/` : modèles métier et clés des réglages
    - `UricAcidRecord.swift` : extensions de l’entité Core Data et logique de création des mesures
    - `Unit.swift` : conversion des unités, intervalles de référence selon le sexe et clés des réglages (`AppSettingsKey`)
  - `Persistence/` : persistance des données et iCloud
    - `Persistence.swift` : configuration du conteneur Core Data / CloudKit
    - `PersistenceController.swift` : chargement du conteneur, état d’iCloud et événements de synchronisation
  - `Utils/`
    - `CSVExporter.swift` : exportation CSV
    - `DateFormatter.swift` : mise en forme des dates
    - `ICloudSettingsSync.swift` : synchronisation des réglages via iCloud Key-Value Store
- `doc/PRD.md` : document des exigences produit (PRD)
- `site/privacy-policy.html` : politique de confidentialité pour la publication sur l’App Store

## Exécution en local

1. Installer les dépendances : `pod install`
2. Ouvrir `UricLog.xcworkspace` dans Xcode
3. Sélectionner le schéma `UricLog`
4. Exécuter l’app sur un simulateur ou un appareil physique

## Synchronisation iCloud

- Les mesures sont synchronisées via CloudKit + Core Data (`NSPersistentCloudKitContainer`)
- Les réglages sont synchronisés via `NSUbiquitousKeyValueStore` avec les clés suivantes :
  - `userGender`
  - `targetEnabled`
  - `targetValue`
  - `preferredUnit`

La synchronisation peut être activée à l’aide de l’interrupteur iCloud dans les réglages. Lorsqu’elle est désactivée, l’app reste entièrement utilisable en local.

## Avertissement

Cette app est destinée uniquement au suivi personnel et à la consultation des données. Elle ne fournit aucun conseil médical et ne constitue pas une base de diagnostic. En cas de valeurs anormales, consulter un professionnel de santé qualifié.

---

<a id="portuguese"></a>

# Diário Ácido Úrico (UricLog)

Uma app iOS gratuita, simples e centrada na privacidade para registar os valores de ácido úrico e acompanhar a sua evolução.

Princípio fundamental: concentrar-se no registo, na evolução e na exportação de dados. A app não fornece diagnósticos médicos nem recomendações de tratamento.

## Funcionalidades

- Medições: adicionar, editar e eliminar valores de ácido úrico, com a data e a hora da medição e notas
- Unidades: alternar entre `μmol/L` e `mg/dL` a qualquer momento
- Intervalos de referência: apresentar os intervalos habituais por sexo, com fontes e referências disponíveis para os verificar
- Evolução: consultar gráficos e resumos estatísticos dos últimos 7, 30 ou 90 dias, ou de todas as medições; permite definir um valor objetivo
- Exportação: exportar as medições em CSV para consultas médicas ou análises próprias
- Sincronização opcional: sincronizar as medições através do iCloud (CloudKit) e as principais definições, como o sexo e o valor objetivo, através do iCloud Key-Value Store

## Estrutura do projeto

- `UricLog/`
  - `UricLogApp.swift`: ponto de entrada da app
  - `Views/`: ecrãs SwiftUI
    - `RecordsListView.swift`: lista de medições
    - `RecordEditorView.swift`: adição e edição de medições; inclui acesso a informações de referência, fontes e citações
    - `TrendsView.swift`: gráficos de evolução e estatísticas
    - `SettingsView.swift`: definições de unidades, sexo, valor objetivo, iCloud, exportação e outras opções
  - `Models/`: modelos de domínio e chaves das definições
    - `UricAcidRecord.swift`: extensões da entidade Core Data e lógica de criação de medições
    - `Unit.swift`: conversão de unidades, intervalos de referência por sexo e chaves das definições (`AppSettingsKey`)
  - `Persistence/`: persistência de dados e iCloud
    - `Persistence.swift`: configuração do contentor Core Data / CloudKit
    - `PersistenceController.swift`: carregamento do contentor, estado do iCloud e eventos de sincronização
  - `Utils/`
    - `CSVExporter.swift`: exportação CSV
    - `DateFormatter.swift`: formatação de datas
    - `ICloudSettingsSync.swift`: sincronização das definições através do iCloud Key-Value Store
- `doc/PRD.md`: documento de requisitos do produto (PRD)
- `site/privacy-policy.html`: política de privacidade para publicação na App Store

## Execução local

1. Instalar as dependências: `pod install`
2. Abrir `UricLog.xcworkspace` no Xcode
3. Selecionar o esquema `UricLog`
4. Executar a app num simulador ou num dispositivo físico

## Sincronização com o iCloud

- As medições são sincronizadas através do CloudKit + Core Data (`NSPersistentCloudKitContainer`)
- As definições são sincronizadas através do `NSUbiquitousKeyValueStore` com estas chaves:
  - `userGender`
  - `targetEnabled`
  - `targetValue`
  - `preferredUnit`

É possível ativar a sincronização com o interruptor do iCloud nas definições. Quando está desativada, a app continua totalmente utilizável em modo local.

## Aviso

Esta app destina-se exclusivamente ao registo pessoal e à consulta dos dados. Não fornece aconselhamento médico nem constitui uma base para diagnóstico. Em caso de valores anómalos, consultar um profissional de saúde qualificado.
