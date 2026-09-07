---
layout: post
title: "Begriffe im Stromnetz"
date: 2026-09-06 16:00:00 +0200
modified: 2026-09-06 16:00:00 +0200
draft: false
categories: [Energy, Solar]
tags: [Solar, PV, Terms, Begriffe, Fach-Chinesisch]
---

Wer eine Photovoltaikanlage, eine Wallbox oder eine Wärmepumpe plant, stolpert schnell über Begriffe wie **Smart Meter**, **Smart Meter Gateway** und **intelligentes Messsystem**. Die Wörter klingen ähnlich, bezeichnen aber unterschiedliche Dinge.

Die Kurzfassung lautet:

> Ein intelligentes Messsystem besteht aus einer modernen Messeinrichtung und einem Smart Meter Gateway. Die moderne Messeinrichtung misst den Strom. Das Gateway übermittelt die Messwerte sicher an berechtigte Stellen.

## Die Begriffe auf einen Blick

| Begriff | Was ist es? | Aufgabe |
| --- | --- | --- |
| **Messeinrichtung** | Der Stromzähler | Misst den Energiebezug und, bei einer PV-Anlage, meist auch die Einspeisung. |
| **Moderne Messeinrichtung (mME)** | Ein digitaler Stromzähler ohne Kommunikations-Gateway | Zeigt Messwerte vor Ort an und speichert sie. Eine automatische Fernübertragung ist allein damit nicht möglich. |
| **Smart Meter Gateway (SMGW)** | Eine Kommunikationseinheit mit hohen Sicherheitsanforderungen | Empfängt Messwerte, verschlüsselt und übermittelt sie an berechtigte Empfänger. |
| **Intelligentes Messsystem (iMSys)** | mME **plus** SMGW | Verbindet digitale Messung mit sicherer Kommunikation. |
| **Smart Meter** | Ein Sammelbegriff | Wird oft für ein iMSys verwendet, manchmal aber auch ungenau für jeden digitalen Zähler. |
| **Messstellenbetreiber (MSB)** | Der Betreiber der Messstelle | Baut den Zähler ein, betreibt ihn, wartet ihn und ist für die Messdaten verantwortlich. |
| **Netzbetreiber** | Der Betreiber des Stromnetzes | Betreibt und stabilisiert das Netz, an das die Anlage angeschlossen ist. |
| **Stromlieferant** | Das Unternehmen, bei dem Strom gekauft wird | Liefert Strom und erstellt die Rechnung. |

## Die wichtigste Unterscheidung

### Moderne Messeinrichtung ist noch kein Smart Meter

Eine moderne Messeinrichtung ist zunächst nur ein digitaler Zähler. Sie ersetzt den alten Ferraris-Zähler und kann genauer sowie komfortabler abgelesen werden. Ohne Smart Meter Gateway sendet sie ihre Werte jedoch nicht automatisch über das Internet oder an den Netzbetreiber.

Erst wenn ein Smart Meter Gateway hinzukommt, entsteht ein **intelligentes Messsystem**:

```text
Moderne Messeinrichtung (mME)
		    +
	  Smart Meter Gateway (SMGW)
		    =
	  Intelligentes Messsystem (iMSys)
```

Das Gateway ist dabei nicht einfach ein WLAN-Router. Es bildet eine speziell abgesicherte Vertrauens- und Kommunikationszone. Die Messwerte sollen nur an Stellen gelangen, die dafür berechtigt sind.

## So hängt alles zusammen

Das folgende Bild zeigt die Rollen und den Weg der Messwerte:

```text
			   Stromnetz
				  |
			 +-----+------+
			 | Hausanlage |
			 | PV / Wallbox|
			 | Waermepumpe |
			 +-----+------+
				  |
		    +-------+--------+
		    | Stromzaehler   |
		    | mME             |
		    +-------+--------+
				  |
		    +-------+--------+
		    | Smart Meter    |
		    | Gateway (SMGW) |
		    +---+---------+--+
			   |         |
	   verschluesselt      | lokale Geraete-
	   ueber WAN            | kommunikation (HAN/CLS)
			   |         |
	   +---------+--+    +-+----------------+
	   | berechtigte |    | Wallbox, PV,     |
	   | Empfaenger  |    | Waermepumpe      |
	   +-------------+    +------------------+
		MSB / Netzbetreiber /
		Lieferant / weitere
		berechtigte Stellen
```

Die Begriffe **WAN**, **HAN** und **CLS** beschreiben dabei verschiedene Seiten des Gateways:

* **WAN (Wide Area Network):** Die sichere Verbindung vom Gateway nach aussen, zum Beispiel zum Messstellenbetreiber oder zu weiteren berechtigten Marktteilnehmern.
* **HAN (Home Area Network):** Der lokale Bereich, in dem ein Nutzer oder ein Energiemanagementsystem freigegebene Werte auslesen kann.
* **CLS (Controllable Local Systems):** Eine gesicherte Schnittstelle für externe Steuerboxen und steuerbare Anlagen, etwa eine Wallbox oder Wärmepumpe. Die Freigabe und die technische Ausgestaltung sind dabei entscheidend.

## Wer macht was?

Die Rollen werden oft miteinander verwechselt:

1. Der **Messstellenbetreiber** installiert und betreibt das Messsystem. Er kümmert sich um Zähler, Gateway, Wartung und die sichere Übertragung.
2. Der **Netzbetreiber** verantwortet das Stromnetz. Er braucht Messwerte zum Beispiel für Netzbetrieb, Abrechnung von Einspeisung oder die Umsetzung von Steueranforderungen.
3. Der **Stromlieferant** verkauft Strom und nutzt die zulässigen Messwerte für die Abrechnung.
4. Der **Anlagenbetreiber** erzeugt oder verbraucht Energie, zum Beispiel mit PV-Anlage, Batterie, Wallbox oder Wärmepumpe. Er ist nicht automatisch Betreiber des Messsystems.

Der Messstellenbetreiber kann der örtliche grundzuständige Messstellenbetreiber sein. Unter bestimmten Voraussetzungen kann auch ein wettbewerblicher Messstellenbetreiber gewählt werden. Das ändert jedoch nichts daran, dass der Netzbetreiber für das Netz und der Lieferant für den Stromvertrag zuständig bleiben.

## Was passiert mit den Messwerten?

Bei einem herkömmlichen Zähler wird der Zählerstand typischerweise in grösseren Abständen abgelesen oder vom Kunden gemeldet. Ein intelligentes Messsystem kann Messwerte in festgelegten Intervallen erfassen und sicher übertragen.

Der technische Ablauf sieht vereinfacht so aus:

```text
Energie fliesst
	 |
	 v
 mME misst den Zaehlerstand
	 |
	 v
 SMGW prueft, sammelt und verschluesselt
	 |
	 v
 berechtigte Stelle erhaelt die benoetigten Daten
	 |
	 +--> Abrechnung
	 +--> Netzplanung und Netzbetrieb
	 +--> Auswertung des eigenen Verbrauchs
	 +--> eventuell freigegebene Steuerung
```

Das bedeutet nicht, dass automatisch jeder Beteiligte jederzeit alle Messwerte sieht. Zweck, Berechtigung und Übertragungsweg sind Bestandteil des Messsystems. Gerade beim Gateway ist Datenschutz kein nachträgliches Zusatzfeature, sondern Teil der technischen Architektur.

## Warum ist das für PV, Wallbox und Wärmepumpe interessant?

Eine PV-Anlage erzeugt nicht immer dann Strom, wenn im Haus viel verbraucht wird. Mit zeitlich aufgelösten Messwerten lässt sich besser erkennen, wann Energie bezogen, erzeugt oder eingespeist wird. Das ist nützlich für ein Energiemanagementsystem, dynamische Stromtarife und die Optimierung von Batterie, Wallbox oder Wärmepumpe.

Messung und Steuerung sind aber zwei verschiedene Dinge:

* Ein intelligentes Messsystem kann Messwerte sicher übertragen.
* Eine Steuerung braucht zusätzlich eine dafür vorgesehene Schnittstelle, ein berechtigtes Steuersignal und ein kompatibles Gerät.
* Ein Smart Meter bedeutet daher nicht automatisch, dass der Netzbetreiber beliebige Geräte im Haus schalten kann.

## Ein kleines Beispiel

Angenommen, ein Haus hat eine PV-Anlage und eine Wallbox:

1. Die mME misst, wie viel Strom das Haus aus dem Netz bezieht oder in das Netz einspeist.
2. Das SMGW übermittelt die dafür vorgesehenen Werte sicher.
3. Das Energiemanagementsystem kann daraus ableiten, ob gerade PV-Überschuss vorhanden ist.
4. Die Wallbox lädt mit diesem Überschuss, sofern die Anlage technisch dafür eingerichtet und freigegeben ist.

Der Zähler ist also das Messinstrument, das Gateway der sichere Kommunikator. Die Entscheidung, wann geladen wird, trifft nicht der Zähler selbst, sondern ein dafür vorgesehenes Energiemanagement oder eine Steuerung.

## Merksätze

* **Digitaler Zähler** bedeutet nicht automatisch **Smart Meter**.
* **Smart Meter Gateway** ist die sichere Kommunikationseinheit.
* **Intelligentes Messsystem** bedeutet: mME plus SMGW.
* **Messen** und **Steuern** sind getrennte Funktionen.
* **Messstellenbetreiber**, **Netzbetreiber** und **Stromlieferant** haben unterschiedliche Aufgaben.

Wer diese fünf Punkte auseinanderhalten kann, versteht die meisten Diagramme, Produktbeschreibungen und Schreiben rund um den digitalen Stromzähler deutlich leichter.
