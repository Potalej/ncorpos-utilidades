module tipos_compat
  implicit none
#ifdef HAVE_TIPOS
  use tipos
#else
  integer, parameter, public :: pf32  = selected_real_kind(6, 37)
  integer, parameter, public :: pf64  = selected_real_kind(15, 307)
  integer, parameter, public :: pf128 = selected_real_kind(33, 4931)

#ifdef REAL32
  integer, parameter, public :: pf = pf32
#elif REAL64
  integer, parameter, public :: pf = pf64
#elif REAL128
  integer, parameter, public :: pf = pf128
#else
  integer, parameter, public :: pf = pf64
#endif
#endif
end module tipos_compat