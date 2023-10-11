import Foundation

let fonts = [
    // 16th century
    "GFSComplutum-Regular",
    
    // 18th century
    "GFSBodoniClassic-Regular",
    "GFSBaskerville-Regular",
    "GFSGazis-Regular",
    
    // 19th century
    "GFSDidotClassic",
    "GFSPorson-Regular",
    "GFSSolomos-Regular",
    "GFSDecker-Normal",
    "GFSOrpheusClassic",
    "GFSPhilostratos-Normal",
    "GFSGoschen-Italic"
]

func withinBounds(x: Int, min: Int, max: Int) -> Int {
    if x >= min && x < max {
        return x
    } else if x < min {
        return max - 1
    } else if x >= max {
        return min
    } else {
        return x
    }
}

func withinFontIndex(x: Int) -> Int {
    return withinBounds(x: x, min: 0, max: fonts.count)
}

func withinQuoteIndex(x: Int) -> Int {
    return withinBounds(x: x, min: 0, max: quotes.count)
}

func randomQuoteIndex() -> Int {
    Int.random(in: 0..<quotes.count)
}

struct Q {
    var f: String?
    var t: String
    var a: String?
}

let quotes = [
    Q(f: "GFSDecker-Normal", t: "αντρες, πεταμενα λεφτα", a: "Στυλιανός"),
    Q(f: "GFSDecker-Normal", t: "ευλογησον"),
    Q(f: "GFSDidotClassic", t: "ἀνδρῶν γὰρ ἐπιφανῶν πᾶσα γῆ τάφος", a: "Θουκυδίδης"),
    Q(f: "GFSSolomos-Regular", t: """
Μὴν καταργεῖτε τὴν ὑπογεγραμμένη
ἰδίως κάτω ἀπὸ τὸ ὠμέγα

εἶναι κρίμα νὰ ἐκλείψει
ἡ πιὸ μικρὴ ἀσέλγεια
τοῦ ἀλφαβήτου μας
""", a: "Ντίνος Χριστιανόπουλος"),
    Q(f: "GFSDidotClassic", t: "οὐκ ἐν τῷ πολλῷ τὸ εὖ"),
    Q(f: "GFSOrpheusClassic", t: "φύσει γὰρ ἄνθρωπος ὃ βούλεται, τοῦτο καί οἴεται", a: "Ιούλιος Καίσαρας"),
    Q(f: "GFSOrpheusClassic", t: "ὁ κόσμος ἀλλοίωσις, ὁ βίος ὑπόληψις", a: "Δημόκριτος"),
    Q(f: "GFSOrpheusClassic", t: "Ο άνθρωπος ό,τι μπορεί κι ο Θεός ό,τι θέλει."),
    Q(f: "GFSGazis-Regular", t: "Ό,τι γράφει η μοίρα μελανό, ο ήλιος δεν τ’ ασπρίζει."),
    Q(f: "GFSDecker-Normal", t: "Ο γέρος πάει ή από πέσιμο ή από χέσιμο."),
    Q(f: "GFSPhilostratos-Normal", t: "Άγιος που δε θαυματουργεί, μηδέ δοξολογιέται.")
]
