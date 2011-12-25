---
layout: main
title: Fraktursatz mit LaTeX
date: 2010-05-13
---

{:pdf: type="application/pdf"}

- [Besonderheiten der Fraktur](#Einleitung)
- [Warum LaTeX?](#LaTeX)
- [Verf&uuml;gbare Pakete](#Pakete)

## <a id="Einleitung">Besonderheiten der Fraktur</a> ##

Wer Texte auf dem Rechner in Fraktur setzen will, st&ouml;&szlig;t
schnell auf gewisse Schwierigkeiten. Absolute Grundvoraussetzung
f&uuml;r Fraktursatz ist die korrekte Verwendung von langem s
(&raquo;&#383;&laquo;) und rundem s (&raquo;s&laquo;).  Bei vielen
frei erh&auml;ltlichen Schriften (Fonts) ist allerdings das lange s
nicht einmal im Zeichenvorrat enthalten. Es gibt zum Gl&uuml;ck
inzwischen zahlreiche hochwertige Fonts, die dar&uuml;ber hinaus auch
eine Vielzahl an Ligaturen bereitstellen.

Die gro&szlig;e Anzahl zus&auml;tzlicher Zeichen f&uuml;hrt
allerdings dazu, dass diese Fonts oft nur mithilfe eines
Konvertierungsprogramms sinnvoll verwendet werden k&ouml;nnen, da die
Zeichensatzbelegung teilweise stark von der normalen Belegung abweicht
(so kann z.&nbsp;B. an der Stelle des Buchstabens &raquo;c&laquo; die
viel h&auml;ufiger ben&ouml;tigte Ligatur &raquo;ch&laquo;
liegen). Auch eine Umstellung auf Schriften anderer Hersteller (mit
typischerweise anderer Zeichensatzbelegung) wird so erschwert.

Diese Probleme k&ouml;nnen durch die Verwendung von LaTeX in Kombination
mit den unten beschriebenen Paketen umgangen werden.

Hier ein einfaches Beispiel (verwendet wurde das frakturx-Paket
mit der Zentenar-Fraktur):

<img src="frakbsp.gif" alt="ein einfaches Beispiel zum Ausprobieren der Fraktur" height="40" width="600">

Der Quelltext zur Erzeugung dieses Beispiels ist:

    ein \textspa{einfaches} Beispiel zum Aus+probieren der Fraktur

Die verschiedenen s-Buchstaben sowie Ligaturen werden weitgehend
automatisch gesetzt, auch korrekter Sperrsatz wird erleichtert.

Ein etwas l&auml;ngerer Text in der Alten Schwabacher:
[Ein Schildb&uuml;rgerstreich](Die_Schildbuerger_bauen_ein_Rathaus_a5.pdf){:pdf} (PDF, 38 KB)

Weitere Texte: [E-Books in Fraktur](ebooks.html)


## <a id="LaTeX">Warum LaTeX?</a> ##

LaTeX ist ein sehr m&auml;chtiges Schriftsatzsystem mit vielen
St&auml;rken.

Einige allgemeine Vorteile sind:

- LaTeX ist kostenlos f&uuml;r praktisch alle
  Plattformen verf&uuml;gbar,
- LaTeX liefert erstklassige typographische Ergebnisse
  (ohne umfassende Kenntnisse seitens des Anwenders vorauszusetzen),
  wie z.&nbsp;B. sehr ausgeglichenen Zeilen- und Seitenumbruch,
  optischen Randausgleich, usw.,
- Dokumente sind einfache Textdateien und damit sehr portabel.

Spezielle Vorteile f&uuml;r den Fraktursatz:

- Ligaturen werden selbst&auml;ndig erkannt und gesetzt,
- Lang-s und Rund-s werden in den meisten F&auml;llen automatisch
  korrekt verwendet,
- der Quelltext ist daher weitgehend unver&auml;ndert und bleibt
  leserlich: Probleme durch andere Zeichensatzbelegungen der Fonts
  werden vermieden.

Nachteile:

- neue Fonts k&ouml;nnen nicht einfach installiert werden, sie
  m&uuml;ssen zun&auml;chst angepasst werden. Dazu dienen die weiter
  unten genannten Pakete,
- LaTeX ist keine Textverarbeitung, sondern eher so etwas wie eine
  Programmiersprache (genauer: eine Auszeichnungssprache, wie HTML
  oder XML); die Bedienung ist am Anfang etwas gew&ouml;hnungsbed&uuml;rftig;
  dies wird allerdings mehr als wettgemacht durch eine hilfsbereite
  und hochmotivierte &raquo;Community&laquo; von LaTeX-Benutzern.

Ein guter Startpunkt f&uuml;r Informationen zu LaTeX ist die
<img src="/images/de.gif" alt="deutschsprachige Seite" height="10" width="16">&nbsp;[Hilfeseite (DE-TeX-FAQ)](http://www.dante.de/faq/de-tex-faq/html/de-tex-faq.html)
der deutschen Anwendervereinigung <img src="/images/de.gif" alt="deutschsprachige Seite" height="10" width="16">&nbsp;[DANTE](http://www.dante.de/).


## <a id="Pakete">Verf&uuml;gbare Pakete</a> ##

F&uuml;r eine Einbindung neuer Schriften in LaTeX gen&uuml;gt nicht
einfach eine ttf-Datei; es werden auch so genannte Fontmetriken und
weitere Dateien ben&ouml;tigt. Diese &raquo;Pakete&laquo;
zus&auml;tzlicher Dateien werden auch als
&raquo;Schriftanpassungen&laquo; bezeichnet. Sie m&uuml;ssen f&uuml;r
jede Schriftart einzeln erzeugt werden, was nicht ganz einfach ist.
Aber zum Gl&uuml;ck gibt es schon fertige Pakete, die Anpassungen
f&uuml;r verschiedene Fonts zur Verf&uuml;gung stellen:

- frakturx
  <br />
  Dieses Paket ist eine Weiterentwicklung des fraktur-Pakets
  (siehe n&auml;chster Punkt). Es ist leicht zu installieren, und umfasst
  eine wachsende Auswahl von Schriftarten.
  <br />
  _Quelle:_ <img src="/images/de.gif" alt="deutschsprachige Seite" height="10" width="16">&nbsp;[www.gaehrken.de/fraktur](http://www.gaehrken.de/fraktur/)

- fraktur
  <br />
  Dieses Paket liefert Anpassungen f&uuml;r einige kostenlose Fonts,
  sowie f&uuml;r eine Reihe kommerzieller Fonts von Delbanco.<br>
  Allerdings kann es bei der Verwendung mit pdfLaTeX unter Umst&auml;nden
  zu Problemen mit einigen Adobe-Schriftarten (Times, Helvetica, Palatino,
  Courier) kommen.
  <br />
  _Quelle:_ <img src="/images/de.gif" alt="deutschsprachige Seite" height="10" width="16">&nbsp;[user.uni-frankfurt.de/~muehlich/tex/texindex.html](http://user.uni-frankfurt.de/~muehlich/tex/texindex.html)

- yfonts / oldgerm
  <br />
  Diese Pakete dienen zur Einbindung der so genannten gothic-Fonts.
  Diese enthalten eine Textur, eine Schwabacher, eine Fraktur
  sowie Zierinitialen, und sind bei vielen LaTeX-Distributionen bereits
  enthalten, eine Installation entf&auml;llt somit.
  Dieselben Schriften k&ouml;nnen allerdings weitaus
  komfortabler mit dem Paket frakturx verwendet werden.
  <br />
  _Quelle:_ <img src="/images/en.gif" alt="englischsprachige Seite" height="10" width="16">&nbsp;[www.ctan.org](http://www.ctan.org/)

Weitere allgemeine Informationen zum Fraktursatz, Beispieltexte und
detailliertere Vergleiche der verschiedenen Pakete finden sich bei den
Dokumentationen zu den Paketen fraktur und frakturx.
