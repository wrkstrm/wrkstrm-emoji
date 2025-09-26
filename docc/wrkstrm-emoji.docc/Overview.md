# Overview

`WrkstrmEmoji` centralizes curated emoji catalogs and randomization helpers that downstream tools
reuse for automation and recognition flows. Use this DocC catalog when previewing documentation via
`xcrun docc` or publishing outside Swift Package Manager.

- ``EmojiCatalog`` exposes the validated pool of standalone emoji scalars.
- ``EmojiRandomizer`` provides ASCII + emoji string generation utilities, including no-confusing
  filters for ASCII characters.

For day-to-day development you can rely on the DocC bundle shipped inside the package sources, and
fall back to this catalog when you need a dedicated documentation workspace.
