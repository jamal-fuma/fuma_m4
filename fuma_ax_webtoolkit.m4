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
#   FUMA_AX_WEBTOOLKIT([MINIMUM-VERSION], [ACTION-IF-FOUND], [ACTION-IF-NOT-FOUND])
#
# DESCRIPTION
#
#   Test for the Webtoolkit C++ libraries of a particular version (or newer)
#
#   This macro calls:
#
#     AC_SUBST(WEBTOOLKIT_CPPFLAGS) / AC_SUBST(WEBTOOLKIT_LDFLAGS)
#     AC_SUBST([WEBTOOLKIT_HTTP_LIBS])
#     AC_SUBST([WEBTOOLKIT_TEST_LIBS])
#
#   And sets:
#
#     HAVE_WEBTOOLKIT
#     HAVE_WEBTOOLKIT_HTTP
#     HAVE_WEBTOOLKIT_TEST
#
# LICENSE
# (c) FumaSoftware 2015

AC_DEFUN_ONCE([FUMA_AX_WEBTOOLKIT],[
#---------------------------------------------------------------
# FUMA_AX_WEBTOOLKIT start
#---------------------------------------------------------------
    # set defaults for our shell variables
    fuma_ax_webtoolkit_default_version="4.0.5"
    fuma_ax_webtoolkit_user_version="$1"
    fuma_ax_webtoolkit_required="no"

# Check whether --with-webtoolkit was given.
    AC_ARG_WITH([webtoolkit],
        [AS_HELP_STRING([--with-webtoolkit=@<:@ARG@:>@],[
            use WebToolkit from a standard location (ARG=yes),
            from the specified location (ARG=<path>),
            or disable it (ARG=no)
            @<:@ARG=yes@:>@]
            )], [fuma_ax_with_webtoolkit="${withval}"],
        [fuma_ax_with_webtoolkit="${fuma_ax_webtoolkit_required}"])

# Check whether --with-webtoolkit-include-dir was given.
    AC_ARG_WITH([webtoolkit-include-dir],
            [AS_HELP_STRING([--with-webtoolkit-include-dir=@<:@ARG@:>@],[
                override include path for WebToolkit (ARG=<path>),
                or disable it (ARG=no)
                @<:@ARG=yes@:>@]
                )], [fuma_ax_with_webtoolkit_include_dir=${withval}],
            [fuma_ax_with_webtoolkit_include_dir="/usr/include"])

# Check whether --with-webtoolkit-library-dir was given.
    AC_ARG_WITH([webtoolkit-library-dir],
            [AS_HELP_STRING([--with-webtoolkit-library-dir=@<:@ARG@:>@], [
                override library path for WebToolkit (ARG=<path>),
                or disable it (ARG=no)
                @<:@ARG=yes@:>@]
                )], [fuma_ax_with_webtoolkit_library_dir=${withval}],
            [fuma_ax_with_webtoolkit_library_dir="/usr/lib/x86_64-linux-gnu"])

    # allow user to skip finding WebToolkit
    AS_IF([test "x$fuma_ax_with_webtoolkit" = "xno"], [fuma_ax_webtoolkit_required="no"],[
    #--------------------------------------------------------------------------------------
        AC_MSG_CHECKING([setting library and include paths for webtoolkit ])
    #--------------------------------------------------------------------------------------

# perform user supplied action if user indeed supplied it.
        AS_IF([test "x$fuma_ax_webtoolkit_http_library_found" = "xyes"],
            [# action on success
            ifelse([$2], , :, [$2])
            ],
            [ # action on failure
            ifelse([$3], , :, [$3])
            ])
	])
    #--------------------------------------------------------------------------------------
    #
    #--------------------------------------------------------------------------------------

#---------------------------------------------------------------
# FUMA_AX_WEBTOOLKIT end
#---------------------------------------------------------------
])
