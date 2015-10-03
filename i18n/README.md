# Translation tutorial

## Requirements

To participate in any way in Kournal translations you got to have Qt5 Linguist Tools installed
(executeables such as `lupdate` or `lrelease`). *Qt5 Linguist* is not required, but it's advised
to make translating easier.

You should have also `python`, which is needed by `update.py` generated from `update.py.in` by CMake.

If something doesn't work remember to check if `TRANSLATION_UPDATER` flag is set to `ON` in CMake cache.

## CMake

First of all you have to run CMake to generate needed files:

- `update.py` – basic script written in Python to update/create translation files
- `sources.txt` – list of sources, where translatable strings may be found

`sources.txt` contains all `*.cpp` and `*.ui` files under `src` folder. To filter some of them
(e.g. when you're developing some functionalities, but translations are not yet ready)
you can create `filter.txt` with list of these files (new line separated).

**Remember:** removing files from `sources.txt` will have no effect, because every time you
rerun CMake it's regenerated. Filter file shouldn't be commited unless you're commiting
not-yet-ready sources (which shouldn't really occur anyway).

## Updating current translations

If you've updated some source/ui files with translatable strings you'd have to update existing
translations to make them comply with current source code and make the process easier for translators.

Here's how you should do it:

1. Update `sources.txt` by running `cmake ..` from `build` directory.
2. There are two possibilities:
    - To update all translations run `make update-ts` from `build` or directly `update.py`
      without parameters from `i18n`.
    - To update one specific translation run `update.py` from `i18n` with language code(s)
      as parameter(s) – e.g. `./update.py pl_PL de_DE`

## Generating new translation

You should repeat point 1 from previous paragraph and then run `update.py` with parameter(s)
like in point 1 – it'll generate new translation basing on `sources.txt`.

## Translating Kournal

To conveniently translate Kournal you should use **Qt5 Linguist**. You can of course use basic
text editor, but Linguist provides really nice features, which really simplify entire process.

## Passing additional args to `lupdate`

If you'd like to pass custom args to `lupdate` from `update.py` script you can do it by adding
hypen argument and after that custom arguments (e.g. `./update.py pl_PL - -no-obsolete`,
which will update `pl_PL.ts` file with `lupdate … -no-obsolete`).
