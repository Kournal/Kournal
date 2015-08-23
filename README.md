# Kournal

Kournal is written from scratch tablet journal application. Similar to Xournal(++), but based on Qt5 framework,
rather than GTK+. For now it's under heavy development, so it shouldn't be used in production environment.

## Contribution

If you'd like to contribute in making Kournal the best tablet journal software in the world you can contact
me by email: marek@pikula.co.

For now there's no possibility to translate, as it'd be pointless in current state, but you can write to me,
so I can write back when i18n will be available.

## Building

Kournal uses CMake as its build engine. You can configure and build it this way:

```bash
git clone https://github.com/Kournal/Kournal.github
cd Kournal
mkdir build
cd build
cmake ..
make
```

## License

Entire Kournal project is licensed under GNU General Public License v2 or later.

The only exception are imported files licensed on their own, as well as some custom CMake scripts (under BSD
License).
