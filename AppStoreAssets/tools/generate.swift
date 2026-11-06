import AppKit

struct Shot {
	let input: String
	let output: String
	let eyebrow: String
	let title: String
	let subtitle: String
	let language: String
}

guard CommandLine.arguments.count == 3 else {
	fatalError("Usage: swift generate.swift <localized-raw-directory> <output-directory>")
}
let root = CommandLine.arguments[1]
let outputRoot = CommandLine.arguments[2]

var shots = [
	Shot(input: "en-US/01-records.png", output: "en-US/01-records.png", eyebrow: "URIC ACID LOG", title: "Every Reading,\nClearly Organized", subtitle: "Keep your history easy to scan and understand.", language: "en"),
	Shot(input: "en-US/02-trends.png", output: "en-US/02-trends.png", eyebrow: "PROGRESS AT A GLANCE", title: "See Your Trends\nat a Glance", subtitle: "Follow changes over time with clear charts and statistics.", language: "en"),
	Shot(input: "en-US/03-add-record.png", output: "en-US/03-add-record.png", eyebrow: "FAST AND FOCUSED", title: "Log a Reading\nin Seconds", subtitle: "Record values, measurement time, and helpful notes.", language: "en"),
	Shot(input: "zh-Hans/01-records.png", output: "zh-Hans/01-records.png", eyebrow: "尿酸记录", title: "清晰记录\n每一次变化", subtitle: "历史数据整齐呈现，随时查看更轻松。", language: "zh"),
	Shot(input: "zh-Hans/02-trends.png", output: "zh-Hans/02-trends.png", eyebrow: "趋势分析", title: "变化趋势\n一目了然", subtitle: "通过图表与统计，直观了解近期变化。", language: "zh"),
	Shot(input: "zh-Hans/03-add-record.png", output: "zh-Hans/03-add-record.png", eyebrow: "轻松记录", title: "几秒完成\n一次记录", subtitle: "数值、测量时间和备注，简单清晰。", language: "zh"),
	// Date/time picker is intentionally omitted from the 1.1.4 release assets.
]

// Every locale must supply its own three real app captures. Never fall back to
// another locale or substitute the records page for a missing page.
let localizedCopy: [(String, String, String, String, String)] = [
	("fr", "SUIVI DE L’ACIDE URIQUE", "Chaque mesure,\nclairement organisée", "Consultez votre historique en un coup d’œil.", "fr"),
	("de", "HARNSÄURE-TAGEBUCH", "Alle Messwerte\nklar geordnet", "Behalten Sie Ihre Entwicklung einfach im Blick.", "de"),
	("es", "REGISTRO DE ÁCIDO ÚRICO", "Cada medición,\nclaramente organizada", "Consulta tu historial de forma rápida y sencilla.", "es"),
	("it", "REGISTRO DELL’ACIDO URICO", "Ogni valore,\nsempre organizzato", "Tieni la tua cronologia sotto controllo con facilità.", "it"),
	("pt-PT", "REGISTO DE ÁCIDO ÚRICO", "Cada medição,\nclaramente organizada", "Consulte o seu histórico de forma simples.", "pt")
]
for (locale, eyebrow, title, subtitle, language) in localizedCopy {
	let trendCopy: (String, String, String)
	let addCopy: (String, String, String)
	switch language {
	case "fr":
		trendCopy = ("VOTRE ÉVOLUTION", "Suivez vos tendances\nen un coup d’œil", "Des graphiques et statistiques pour suivre vos mesures.")
		addCopy = ("SIMPLE ET RAPIDE", "Une mesure saisie\nen quelques secondes", "Ajoutez la valeur, la date et vos notes.")
	case "de":
		trendCopy = ("VERLAUF IM BLICK", "Ihre Entwicklung\nauf einen Blick", "Verfolgen Sie Ihre Werte mit Diagrammen und Statistiken.")
		addCopy = ("SCHNELL UND EINFACH", "Messwerte in\nSekunden erfassen", "Wert, Messzeit und Notizen einfach eintragen.")
	case "es":
		trendCopy = ("TU EVOLUCIÓN", "Tus tendencias\nde un vistazo", "Sigue tus valores con gráficos y estadísticas.")
		addCopy = ("FÁCIL Y RÁPIDO", "Registra un valor\nen segundos", "Añade el valor, la fecha y tus notas.")
	case "it":
		trendCopy = ("IL TUO ANDAMENTO", "Le tue tendenze\na colpo d’occhio", "Segui i valori con grafici e statistiche.")
		addCopy = ("SEMPLICE E VELOCE", "Registra un valore\nin pochi secondi", "Aggiungi valore, data e note utili.")
	default:
		trendCopy = ("A SUA EVOLUÇÃO", "As suas tendências\nnum relance", "Acompanhe os valores com gráficos e estatísticas.")
		addCopy = ("SIMPLES E RÁPIDO", "Registe um valor\nem segundos", "Adicione o valor, a data e as suas notas.")
	}
	shots.append(contentsOf: [
		Shot(input: "\(locale)/01-records.png", output: "\(locale)/01-records.png", eyebrow: eyebrow, title: title, subtitle: subtitle, language: language),
		Shot(input: "\(locale)/02-trends.png", output: "\(locale)/02-trends.png", eyebrow: trendCopy.0, title: trendCopy.1, subtitle: trendCopy.2, language: language),
		Shot(input: "\(locale)/03-add-record.png", output: "\(locale)/03-add-record.png", eyebrow: addCopy.0, title: addCopy.1, subtitle: addCopy.2, language: language)
	])
}

// Preflight the entire set before writing any promotional output.
var hashes = Set<Data>()
for shot in shots {
	let path = root + "/" + shot.input
	guard let data = FileManager.default.contents(atPath: path) else {
		fatalError("Missing localized capture: \(shot.input)")
	}
	guard hashes.insert(data).inserted else {
		fatalError("Duplicate capture detected: \(shot.input)")
	}
}

// Keep the established layout, but render explicit pixels for the required
// Dynamic Island medium iPhone slot. Do not depend on lockFocus/Retina scale.
let canvasSize = NSSize(width: 642, height: 1389)
let outputWidth = 1206
let outputHeight = 2622
let screenshotWidth: CGFloat = 510
let screenshotY: CGFloat = 14
let screenshotCornerRadius: CGFloat = 29

func font(size: CGFloat, weight: NSFont.Weight, language: String) -> NSFont {
	if language == "zh", let result = NSFont(name: "PingFangSC-Semibold", size: size) {
		return result
	}
	return NSFont.systemFont(ofSize: size, weight: weight)
}

func drawText(_ value: String, rect: NSRect, font: NSFont, color: NSColor, alignment: NSTextAlignment = .left, lineSpacing: CGFloat = 0) {
	let paragraph = NSMutableParagraphStyle()
	paragraph.alignment = alignment
	paragraph.lineSpacing = lineSpacing
	value.draw(in: rect, withAttributes: [
		.font: font,
		.foregroundColor: color,
		.paragraphStyle: paragraph
	])
}

for shot in shots {
	guard let source = NSImage(contentsOfFile: root + "/" + shot.input) else {
		fatalError("Unable to load \(shot.input)")
	}

	guard let bitmap = NSBitmapImageRep(
		bitmapDataPlanes: nil, pixelsWide: outputWidth, pixelsHigh: outputHeight,
		bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false,
		colorSpaceName: .deviceRGB, bytesPerRow: 0, bitsPerPixel: 0
	), let context = NSGraphicsContext(bitmapImageRep: bitmap) else {
		fatalError("Unable to create output bitmap")
	}
	NSGraphicsContext.saveGraphicsState()
	NSGraphicsContext.current = context
	context.cgContext.scaleBy(
		x: CGFloat(outputWidth) / canvasSize.width,
		y: CGFloat(outputHeight) / canvasSize.height
	)
	NSColor(calibratedRed: 0.965, green: 0.975, blue: 0.992, alpha: 1).setFill()
	NSRect(origin: .zero, size: canvasSize).fill()

	NSColor(calibratedRed: 0.04, green: 0.53, blue: 0.96, alpha: 1).setFill()
	NSRect(x: 48, y: 1358, width: 36, height: 4).fill()

	drawText(shot.eyebrow, rect: NSRect(x: 48, y: 1314, width: 564, height: 30), font: font(size: 16, weight: .bold, language: shot.language), color: NSColor(calibratedRed: 0.04, green: 0.45, blue: 0.88, alpha: 1))
	drawText(shot.title, rect: NSRect(x: 48, y: 1175, width: 564, height: 125), font: font(size: shot.language == "zh" ? 43 : 39, weight: .bold, language: shot.language), color: NSColor(calibratedWhite: 0.08, alpha: 1), lineSpacing: 2.5)
	drawText(shot.subtitle, rect: NSRect(x: 48, y: 1128, width: 564, height: 38), font: font(size: shot.language == "zh" ? 17.5 : 15.5, weight: .regular, language: shot.language), color: NSColor(calibratedWhite: 0.38, alpha: 1))

	let ratio = source.size.height / source.size.width
	let imageRect = NSRect(x: (canvasSize.width - screenshotWidth) / 2, y: screenshotY, width: screenshotWidth, height: screenshotWidth * ratio)
	NSGraphicsContext.saveGraphicsState()
	let shadow = NSShadow()
	shadow.shadowColor = NSColor.black.withAlphaComponent(0.18)
	shadow.shadowBlurRadius = 17
	shadow.shadowOffset = NSSize(width: 0, height: -5)
	shadow.set()
	let path = NSBezierPath(roundedRect: imageRect, xRadius: screenshotCornerRadius, yRadius: screenshotCornerRadius)
	NSColor.white.setFill()
	path.fill()
	path.addClip()
	source.draw(in: imageRect, from: NSRect(origin: .zero, size: source.size), operation: .sourceOver, fraction: 1)
	NSGraphicsContext.restoreGraphicsState()

	context.flushGraphics()
	NSGraphicsContext.restoreGraphicsState()
	guard let png = bitmap.representation(using: .png, properties: [:]) else {
		fatalError("Unable to encode \(shot.output)")
	}
	let output = URL(fileURLWithPath: outputRoot + "/" + shot.output)
	try FileManager.default.createDirectory(at: output.deletingLastPathComponent(), withIntermediateDirectories: true)
	try png.write(to: output)
}
