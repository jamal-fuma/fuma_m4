dnl (c) FumaSoftware 2015
dnl
dnl Platform detection for autotools
dnl
dnl Copying and distribution of this file, with or without modification,
dnl are permitted in any medium without royalty provided the copyright
dnl notice and this notice are preserved.  This file is offered as-is,
dnl without any warranty.
dnl
dnl platform detection
# SYNOPSIS
#   FUMA_AX_WEBTOOLKIT_DBO([MINIMUM-VERSION], [ACTION-IF-FOUND], [ACTION-IF-NOT-FOUND])
#
# DESCRIPTION
#
#   Test for the Webtoolkit C++ libraries of a particular version (or newer)
#
#   This macro calls:
#
#     AC_SUBST([WEBTOOLKIT_DBO_MYSQL_LIBS])
#     AC_SUBST([WEBTOOLKIT_DBO_POSTGRES_LIBS])
#     AC_SUBST([WEBTOOLKIT_DBO_SQLITE3_LIBS])
#     AC_SUBST([WEBTOOLKIT_DBO_LIBS])
#
#   And sets:
#
#     HAVE_WEBTOOLKIT_DBO
#     HAVE_WEBTOOLKIT_DBO_MYSQL
#     HAVE_WEBTOOLKIT_DBO_POSTGRES
#     HAVE_WEBTOOLKIT_DBO_SQLITE3
#     HAVE_WEBTOOLKIT_HTTP
#     HAVE_WEBTOOLKIT_TEST
#
# LICENSE
# (c) FumaSoftware 2015
AC_DEFUN_ONCE([FUMA_AX_WEBTOOLKIT_DBO],[dnl
#---------------------------------------------------------------
# FUMA_AX_WEBTOOLKIT_DBO start
#---------------------------------------------------------------
    AS_IF([test "x$fuma_ax_webtoolkit_found" = "xyes"],[dnl
        library_dir="${fuma_ax_webtoolkit_library_dir_path}"
        fuma_ax_webtoolkit_mysql_backend_found="no"

        AC_ARG_WITH([mysql],
            [AS_HELP_STRING([--with-mysql@<:@=ARG@:>@],
                [use Wt MySQL Database backend,
                @<:@ARG=yes@:>@ ])],
            [fuma_ax_with_mysql=${withval}], [fuma_ax_with_mysql="no";])

        AS_IF([test "x$fuma_ax_with_mysql" = "xyes"],[dnl
            AC_MSG_CHECKING(if should enable MySQL database backend for Wt)
            FUMA_AX_CHECK_WEBTOOLKIT_DBO_MYSQL_LIBRARY([fuma_ax_webtoolkit_mysql_backend_found],[library_dir])
            AS_IF([test "x${fuma_ax_webtoolkit_mysql_backend_found}" = "xyes"],[dnl
                WEBTOOLKIT_DBO_LIBS="${WEBTOOLKIT_DBO_LIBS} ${WEBTOOLKIT_DBO_MYSQL_LIBS}";
                AC_SUBST([WEBTOOLKIT_DBO_MYSQL_LIBS])
                AC_SUBST([WEBTOOLKIT_DBO_LIBS])
            ])
            AC_MSG_RESULT([${fuma_ax_webtoolkit_mysql_backend_found}])
        ])

        fuma_ax_webtoolkit_sqlite3_backend_found="no"

        AC_ARG_WITH([sqlite3],
            [AS_HELP_STRING([--with-sqlite3@<:@=ARG@:>@],
                [use Wt SQLite Database backend,
                @<:@ARG=yes@:>@ ])],
            [fuma_ax_with_sqlite3=${withval}], [fuma_ax_with_sqlite3="no";])

        AS_IF([test "x$fuma_ax_with_sqlite3" = "xyes"],[dnl
            AC_MSG_CHECKING(if should enable SQLite database backend for Wt)
            FUMA_AX_CHECK_WEBTOOLKIT_DBO_SQLITE3_LIBRARY([fuma_ax_webtoolkit_sqlite3_backend_found],[library_dir])
            AS_IF([test "x${fuma_ax_webtoolkit_sqlite3_backend_found}" = "xyes"],
                    [WEBTOOLKIT_DBO_LIBS="${WEBTOOLKIT_DBO_LIBS} ${WEBTOOLKIT_DBO_SQLITE3_LIBS}";
                    AC_SUBST([WEBTOOLKIT_DBO_SQLITE3_LIBS])
                    AC_SUBST([WEBTOOLKIT_DBO_LIBS])
            ])
            AC_MSG_RESULT([${fuma_ax_webtoolkit_sqlite3_backend_found}])
        ])

        fuma_ax_webtoolkit_postgres_backend_found="no"

        AC_ARG_WITH([postgres],
            [AS_HELP_STRING([--with-postgres@<:@=ARG@:>@],
                [use Wt PostgreSQL Database backend,
                @<:@ARG=yes@:>@ ])],
            [fuma_ax_with_postgres=${withval}], [fuma_ax_with_postgres="no";])

        AS_IF([test "x$fuma_ax_with_postgres" = "xyes"],[dnl
            AC_MSG_CHECKING(if should enable PostgreSQL database backend for Wt)
            FUMA_AX_CHECK_WEBTOOLKIT_DBO_POSTGRES_LIBRARY([fuma_ax_webtoolkit_postgres_backend_found],[library_dir])
            AS_IF([test "x${fuma_ax_webtoolkit_postgres_backend_found}" = "xyes"],
                    [WEBTOOLKIT_DBO_LIBS="${WEBTOOLKIT_DBO_LIBS} ${WEBTOOLKIT_DBO_POSTGRES_LIBS}";
                    AC_SUBST([WEBTOOLKIT_DBO_POSTGRES_LIBS])
                    AC_SUBST([WEBTOOLKIT_DBO_LIBS])
            ])
            AC_MSG_RESULT([${fuma_ax_webtoolkit_postgres_backend_found}])
        ])
    ],[ AC_ERROR([Could not find WebToolkit library to use]) ])
#---------------------------------------------------------------
# FUMA_AX_WEBTOOLKIT_DBO end
#---------------------------------------------------------------
])
