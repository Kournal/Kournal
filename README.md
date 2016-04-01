# Kournal

[![Join the chat at https://gitter.im/Kournal/Kournal](https://badges.gitter.im/Kournal/Kournal.svg)](https://gitter.im/Kournal/Kournal?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Kournal is written from scratch tablet journal application. Similar to Xournal(++), but based on Qt5 framework,
rather than GTK+. For now it's under heavy development, so it shouldn't be used in production environment.

## Contribution

If you'd like to contribute in making Kournal the best tablet journal software in the world you can contact
me by email: marek@pikula.co.

Translations are implemented, but strings will be surely changed a lot of times, so there's no point in
translating at the moment.

## Building

Kournal uses CMake as its build engine. You can configure and build it this way:

```bash
git clone https://github.com/Kournal/Kournal.git
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
