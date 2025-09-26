import Testing

@testable import WrkstrmEmoji

struct EmojiCatalogTests {

  private let ambiguousASCII: Set<Character> = ["0", "O", "1", "l", "I"]

  @Test
  func catalogIsNotEmpty() {
    #expect(!EmojiCatalog.standaloneEmoji.isEmpty)
  }

  @Test
  func catalogContainsOnlyStandaloneEmoji() {
    let violations = EmojiCatalog.standaloneEmoji.filter { character in
      guard let scalar = character.unicodeScalars.first, character.unicodeScalars.count == 1 else {
        return true
      }
      return !EmojiCatalog.isStandaloneScalar(scalar)
    }
    #expect(violations.isEmpty)
  }

  @Test
  func rejectsRegionalIndicators() {
    let regionalIndicatorA = UnicodeScalar(0x1F1E6)!
    #expect(!EmojiCatalog.isStandaloneScalar(regionalIndicatorA))
  }

  @Test
  func rejectsVariationSelectors() {
    let variationSelector = UnicodeScalar(0xFE0F)!
    #expect(!EmojiCatalog.isStandaloneScalar(variationSelector))
  }

  @Test
  func emojiZeroLengthReturnsEmpty() {
    #expect(EmojiRandomizer.emojiString(length: 0).isEmpty)
  }

  @Test
  func emojiHonorsRequestedLength() {
    let result = EmojiRandomizer.emojiString(length: 32)
    #expect(result.count == 32)
  }

  @Test
  func mixedZeroLengthReturnsEmpty() {
    #expect(EmojiRandomizer.mixedString(length: 0).isEmpty)
  }

  @Test
  func mixedHonorsRequestedLength() {
    let result = EmojiRandomizer.mixedString(length: 48)
    #expect(result.count == 48)
  }

  @Test
  func mixedNoConfusingOmitsAmbiguousASCII() {
    let result = EmojiRandomizer.mixedString(length: 100, noConfusing: true)
    let asciiCharacters = result.filter { $0.unicodeScalars.first!.isASCII }
    #expect(asciiCharacters.allSatisfy { !ambiguousASCII.contains($0) })
  }

  @Test
  func mixedEmojiUsesStandaloneCatalog() {
    let result = EmojiRandomizer.mixedString(length: 128)
    let allValid = result.allSatisfy { character in
      let scalars = character.unicodeScalars
      guard let scalar = scalars.first else { return false }
      if scalar.isASCII {
        return scalars.count == 1
      }
      return scalars.count == 1 && EmojiCatalog.isStandaloneScalar(scalar)
    }
    #expect(allValid)
  }
}
