using BinaryBuilder

name = "readline"
version = v"8.0"

sources = [
    "https://ftp.gnu.org/gnu/readline/readline-8.0.tar.gz" =>
        "e339f51971478d369f8a053a330a190781acb9864cf4c541060f12078948e461",
]

script = raw"""
cd ${WORKSPACE}/srcdir/readline-*
./configure --prefix=${prefix} --host=${target} --with-curses
# work around binarybuilder dlopen checks
make -j${nproc} SHLIB_LIBS=-ltinfo
make install
"""

products(prefix) = [
    LibraryProduct(prefix, "libreadline", :libreadline)
]

# no libtermcap on windows
platforms = filter(x->!isa(x,Windows),supported_platforms())

dependencies = [
    "https://github.com/benlorenz/ncursesBuilder/releases/download/v6.1/build_ncurses.v6.1.0.jl"
]

build_tarballs(ARGS, name, version, sources, script, platforms, products, dependencies)
