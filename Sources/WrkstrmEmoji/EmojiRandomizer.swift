/// Shared randomization helpers built on top of ``EmojiCatalog``.
public enum EmojiRandomizer {

  /// Generates a random string made up exclusively of standalone emoji.
  ///
  /// - Parameters:
  ///   - length: Number of emoji to generate.
  ///   - catalog: Optional catalog to source emoji from. Defaults to
  ///     ``EmojiCatalog/standaloneEmoji``.
  /// - Returns: A string composed of `length` emoji characters.
  public static func emojiString(length: Int, catalog: [Character] = EmojiCatalog.standaloneEmoji)
    -> String
  {
    guard length > 0 else { return "" }
    return String((0..<length).compactMap { _ in catalog.randomElement() })
  }

  /// Generates a random string that mixes printable ASCII and standalone emoji characters.
  ///
  /// - Parameters:
  ///   - length: Number of scalars to generate.
  ///   - noConfusing: When `true`, removes ambiguous ASCII characters such as `0`, `O`, `1`, `l`,
  ///     and `I` before mixing with emoji.
  ///   - emojiCatalog: Emoji pool to sample from. Defaults to
  ///     ``EmojiCatalog/standaloneEmoji``.
  /// - Returns: A mixed ASCII + emoji string.
  public static func mixedString(
    length: Int,
    noConfusing: Bool = false,
    emojiCatalog: [Character] = EmojiCatalog.standaloneEmoji
  ) -> String {
    guard length > 0 else { return "" }
    let asciiPool = noConfusing ? safeASCII : asciiTable
    let combined = asciiPool + emojiCatalog
    guard !combined.isEmpty else { return "" }
    return String((0..<length).compactMap { _ in combined.randomElement() })
  }

  /// Returns a single random emoji from the provided catalog.
  ///
  /// - Parameter catalog: Emoji pool to sample from.
  /// - Returns: A random emoji character when the catalog is not empty.
  public static func emoji(catalog: [Character] = EmojiCatalog.standaloneEmoji) -> Character? {
    catalog.randomElement()
  }

  // MARK: - Private

  /// All printable ASCII characters (U+0020 to U+007E).
  private static let asciiTable: [Character] = {
    (32...126).compactMap { UnicodeScalar($0).map(Character.init) }
  }()

  /// Ambiguity-free ASCII characters modeled after Base58-style sets.
  private static let safeASCII: [Character] = Array(
    "ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz23456789!@#$%^&*"
  )
}
