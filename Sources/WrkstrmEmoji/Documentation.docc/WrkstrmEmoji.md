# ``WrkstrmEmoji``

WrkstrmEmoji centralizes emoji-aware utilities so downstream packages share a
single source of truth for curated emoji catalogs and randomization helpers.

## Topics

### Catalogs

- ``EmojiCatalog``

### Generators

- ``EmojiRandomizer``

## Example

```swift
let emojiOnly = EmojiRandomizer.emojiString(length: 4)
let mixed = EmojiRandomizer.mixedString(length: 6, noConfusing: true)
```

`EmojiCatalog.isStandaloneScalar(_:)` exposes the validation rules used by
`EmojiRandomizer`, enabling callers to audit their own pools before mixing them
into automation or recognition pipelines.
