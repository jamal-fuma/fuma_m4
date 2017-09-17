dnl (c) FumaSoftware 2017
dnl
dnl vendor bundling for autotools
dnl
dnl Copying and distribution of this file, with or without modification,
dnl are permitted in any medium without royalty provided the copyright
dnl notice and this notice are preserved.  This file is offered as-is,
dnl without any warranty.
dnl
dnl platform detection
AC_DEFUN([FUMA_AX_VENDOR],[dnl
#---------------------------------------------------------------
# FUMA_AX_VENDOR start
#---------------------------------------------------------------
all_args_provided=ifelse([$4],[],f,$4)
AC_CONFIG_SUBDIRS([$2])
$1="$2"
AC_SUBST([WT_ROUTER])
VENDOR_INCLUDES="${VENDOR_INCLUDES} -I${top_srcdir}/${$1}/$3"
VENDOR_LIBS="${VENDOR_LIBS} ${top_builddir}/${$1}/$4"
export VENDOR_INCLUDES
export VENDOR_LIBS
#---------------------------------------------------------------
# FUMA_AX_VENDOR end
#---------------------------------------------------------------
        ])
