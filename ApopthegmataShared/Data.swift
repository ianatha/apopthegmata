import Foundation

let fonts = [
    // 16th century
    "GFSComplutum-Regular",
    
    // 18th century
    "GFSBodoniClassic-Regular",
    "GFSBaskerville-Regular",
    "GFSGazis-Regular",
    
    //    // 19th century
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
    Int(arc4random_uniform(UInt32(quotes.count)))
}

let quotes = [
    "άντρες, πεταμένα λεφτά",
"""
Μὴν καταργεῖτε τὴν ὑπογεγραμμένη
ἰδίως κάτω ἀπὸ τὸ ὠμέγα

εἶναι κρίμα νὰ ἐκλείψει
ἡ πιὸ μικρὴ ἀσέλγεια
τοῦ ἀλφαβήτου μας
""",
    "ἀνδρῶν γὰρ ἐπιφανῶν πᾶσα γῆ τάφος",
    "οὐκ ἐν τῷ πολλῷ τὸ εὖ",
    "Ο άνθρωπος ό,τι μπορεί κι ο Θεός ό,τι θέλει.",
    "Ό,τι γράφει η μοίρα μελανό, ο ήλιος δεν τ’ ασπρίζει.",
    "Ο γέρος πάει ή από πέσιμο ή από χέσιμο.",
    "Άγιος που δε θαυματουργεί, μηδέ δοξολογιέται."
]
