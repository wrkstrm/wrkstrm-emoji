import Foundation

/// Catalog helpers for emoji-aware features shared across Wrkstrm packages.
public enum EmojiCatalog {

  // MARK: - Public API

  /// Emoji characters that:
  /// - are a single Unicode scalar
  /// - default to the emoji presentation
  /// - stand alone as individual grapheme clusters
  public static let standaloneEmoji: [Character] = {
    (0...0x10FFFF).compactMap { codePoint in
      guard
        let scalar = UnicodeScalar(codePoint),
        Self.isStandaloneScalar(scalar)
      else {
        return nil
      }
      return Character(scalar)
    }
  }()

  /// Determines whether the scalar is a standalone emoji we permit in catalogs
  /// and random generators.
  public static func isStandaloneScalar(_ scalar: UnicodeScalar) -> Bool {
    let isRegionalIndicator = (0x1F1E6...0x1F1FF).contains(scalar.value)
    return scalar.properties.isEmoji
      && scalar.properties.isEmojiPresentation
      && scalar.properties.isGraphemeBase
      && !scalar.properties.isEmojiModifier
      && !scalar.properties.isVariationSelector
      && !isRegionalIndicator
  }
}
