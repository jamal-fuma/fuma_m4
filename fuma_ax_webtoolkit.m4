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

AC_DEFUN_ONCE([FUMA_AX_WEBTOOLKIT],[dnl
#---------------------------------------------------------------
# FUMA_AX_WEBTOOLKIT start
#---------------------------------------------------------------
    # set defaults for our shell variables
    fuma_ax_webtoolkit_default_version="4.0.5"
    fuma_ax_webtoolkit_default_library_ext="${fuma_ax_default_library_ext}"
    fuma_ax_webtoolkit_user_version="$1"
    fuma_ax_webtoolkit_found="no"
    fuma_ax_webtoolkit_required="no"
    fuma_ax_with_webtoolkit_library_dir="yes"
    fuma_ax_with_webtoolkit_include_dir="yes"

    # compare supplied version against the empty string,
    # if the caller supplied a version we use that otherwise we use fuma_ax_webtoolkit_default_version
    FUMA_AX_SET_WEBTOOLKIT_VERSION([ifelse([${fuma_ax_webtoolkit_user_version}],[],
            ["${fuma_ax_webtoolkit_default_version}"],
            ["${fuma_ax_webtoolkit_user_version}"])], [desired_webtoolkit])

    # Check whether --with-webtoolkit was given.
    AC_ARG_WITH([webtoolkit],
        [AS_HELP_STRING([--with-webtoolkit=@<:@ARG@:>@],
            [use WebToolkit from a standard location (ARG=yes), from the specified location (ARG=<path>), or disable it (ARG=no) @<:@ARG=yes@:>@])],
        [fuma_ax_with_webtoolkit="${withval}"],
        [fuma_ax_with_webtoolkit="${fuma_ax_webtoolkit_required}"])

    # allow user to skip finding WebToolkit
    AS_IF([test "x$fuma_ax_with_webtoolkit" = "xno"], [fuma_ax_webtoolkit_required="no"],[
    #--------------------------------------------------------------------------------------
    #
    #--------------------------------------------------------------------------------------
        # export path of WebToolkit top level directory
        FUMA_AX_SET_WEBTOOLKIT_PATH([fuma_ax_with_webtoolkit],[webtoolkit])

        # allow overriding paths for location of WebToolkit
        AS_IF([test -d "${fuma_ax_webtoolkit_path}"], [dnl
            fuma_ax_webtoolkit_include_dir_path="${fuma_ax_webtoolkit_path}/include"
            fuma_ax_webtoolkit_library_dir_path="${fuma_ax_webtoolkit_path}/lib"])

        # Check whether --with-webtoolkit-include-dir was given.
        AC_ARG_WITH([webtoolkit-include-dir], [dnl
            AS_HELP_STRING([--with-webtoolkit-include-dir=@<:@ARG@:>@],[override include path for WebToolkit (ARG=path)])],
            [fuma_ax_with_webtoolkit_include_dir=${withval}],
            [fuma_ax_with_webtoolkit_include_dir="${fuma_ax_webtoolkit_required}"])

        # export include path for WebToolkit
        FUMA_AX_SET_WEBTOOLKIT_PATH([fuma_ax_with_webtoolkit_include_dir],[webtoolkit_include_dir])

        # allow overriding include paths for location of WebToolkit
        AS_IF([test -d "${fuma_ax_webtoolkit_include_dir_path}"], [include_dir="${fuma_ax_webtoolkit_include_dir_path}"])

        # Check whether --with-webtoolkit-library-dir was given.
        AC_ARG_WITH([webtoolkit-library-dir], [dnl
            AS_HELP_STRING([--with-webtoolkit-library-dir=@<:@ARG@:>@],[override library path for WebToolkit (ARG=path)])],
            [fuma_ax_with_webtoolkit_library_dir=${withval}],
            [fuma_ax_with_webtoolkit_library_dir="${fuma_ax_webtoolkit_required}"])

        # export library path for WebToolkit
        FUMA_AX_SET_WEBTOOLKIT_PATH([fuma_ax_with_webtoolkit_library_dir],[webtoolkit_library_dir])

        # allow overriding library paths for location of WebToolkit
        AS_IF([test -d "${fuma_ax_webtoolkit_library_dir_path}"],
                [library_dir="${fuma_ax_webtoolkit_library_dir_path}"])

        # try paths until we find a match
        fuma_ax_webtoolkit_search_paths="
        $fuma_ax_webtoolkit_path
        /opt/webtoolkit/${fuma_ax_desired_webtoolkit_version_str}
        /usr/local
        ";

        # use a search path unless the user specified an explicit path
        for search_path in $fuma_ax_webtoolkit_search_paths;
        do
            FUMA_AX_SET_WEBTOOLKIT_DIRECTORY_UNLESS_SET([include],[${search_path}/include])
            FUMA_AX_SET_WEBTOOLKIT_DIRECTORY_UNLESS_SET([library],[${search_path}/lib])

            # check if the header is present
            fuma_ax_webtoolkit_version_header_found="no"
            AS_IF([test -f "${include_dir}/Wt/Http/Client"],
                    [fuma_ax_webtoolkit_version_header_found="yes"
                    FUMA_AX_COMPARE_WEBTOOLKIT_HEADER_VERSION([fuma_ax_desired_webtoolkit_version_number],
                    [fuma_ax_webtoolkit_version_header_found],[include_dir])
                FUMA_AX_CHECK_WEBTOOLKIT_HTTP_LIBRARY([fuma_ax_webtoolkit_http_library_found],[library_dir])
                FUMA_AX_CHECK_WEBTOOLKIT_TEST_LIBRARY([fuma_ax_webtoolkit_test_library_found],[library_dir])
                AS_IF([test "x${fuma_ax_webtoolkit_http_library_found}" = "xyes"],[dnl
                    AC_DEFINE([HAVE_WEBTOOLKIT],[1],[define if the Webtoolkit library is available])
                    break], [fuma_ax_webtoolkit_found="no"]) ])
        done

        AC_MSG_RESULT([${fuma_ax_webtoolkit_found}])

        # perform user supplied action if user indeed supplied it.
        AS_IF([test "x$fuma_ax_webtoolkit_found" = "xyes"],
            [# action on success
            ifelse([$2], , :, [$2])
            ],
            [ # action on failure
            ifelse([$3], , :, [$3])
            ])

        AS_IF([test "x$fuma_ax_webtoolkit_found" = "xyes"],
            [export fuma_ax_webtoolkit_library_dir_path="${library_dir}"
            export fuma_ax_webtoolkit_found="yes"],[dnl
            AC_ERROR([Could not find WebToolkit library to use]) ])
#--------------------------------------------------------------------------------------
#
#--------------------------------------------------------------------------------------
    ])
#---------------------------------------------------------------
# FUMA_AX_WEBTOOLKIT end
#---------------------------------------------------------------
])
