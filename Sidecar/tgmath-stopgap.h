// Sidecar
// Copyright (c) 2014, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

// This is a real shame..
// The modules feature in clang (-fmodules) breaks tgmath. Its rules about the visibility of
// macros means that tgmath's redefinitions of the math functions never make it out of the
// module. Frowny face.
// This is just a stopgap of the macro definitions. It can definitely be removed when that
// clang situation gets fixed. Also if they make drastic updates to tgmath.h, this should be
// updated (though that's probably unlikely...).
// Solution inspired by https://gist.github.com/a2/8465866

#if __has_feature(modules)

@import Darwin.C.tgmath;

// acos
#undef acos
#define acos(__x) __tg_acos(__tg_promote1((__x))(__x))

// asin
#undef asin
#define asin(__x) __tg_asin(__tg_promote1((__x))(__x))

// atan
#undef atan
#define atan(__x) __tg_atan(__tg_promote1((__x))(__x))

// acosh
#undef acosh
#define acosh(__x) __tg_acosh(__tg_promote1((__x))(__x))

// asinh
#undef asinh
#define asinh(__x) __tg_asinh(__tg_promote1((__x))(__x))

// atanh
#undef atanh
#define atanh(__x) __tg_atanh(__tg_promote1((__x))(__x))

// cos
#undef cos
#define cos(__x) __tg_cos(__tg_promote1((__x))(__x))

// sin
#undef sin
#define sin(__x) __tg_sin(__tg_promote1((__x))(__x))

// tan
#undef tan
#define tan(__x) __tg_tan(__tg_promote1((__x))(__x))

// cosh
#undef cosh
#define cosh(__x) __tg_cosh(__tg_promote1((__x))(__x))

// sinh
#undef sinh
#define sinh(__x) __tg_sinh(__tg_promote1((__x))(__x))

// tanh
#undef tanh
#define tanh(__x) __tg_tanh(__tg_promote1((__x))(__x))

// exp
#undef exp
#define exp(__x) __tg_exp(__tg_promote1((__x))(__x))

// log
#undef log
#define log(__x) __tg_log(__tg_promote1((__x))(__x))

// pow
#undef pow
#define pow(__x, __y) __tg_pow(__tg_promote2((__x), (__y))(__x), \
__tg_promote2((__x), (__y))(__y))

// sqrt
#undef sqrt
#define sqrt(__x) __tg_sqrt(__tg_promote1((__x))(__x))

// fabs
#undef fabs
#define fabs(__x) __tg_fabs(__tg_promote1((__x))(__x))

// atan2
#undef atan2
#define atan2(__x, __y) __tg_atan2(__tg_promote2((__x), (__y))(__x), \
__tg_promote2((__x), (__y))(__y))

// cbrt
#undef cbrt
#define cbrt(__x) __tg_cbrt(__tg_promote1((__x))(__x))

// ceil
#undef ceil
#define ceil(__x) __tg_ceil(__tg_promote1((__x))(__x))

// copysign
#undef copysign
#define copysign(__x, __y) __tg_copysign(__tg_promote2((__x), (__y))(__x), \
__tg_promote2((__x), (__y))(__y))

// erf
#undef erf
#define erf(__x) __tg_erf(__tg_promote1((__x))(__x))

// erfc
#undef erfc
#define erfc(__x) __tg_erfc(__tg_promote1((__x))(__x))

// exp2
#undef exp2
#define exp2(__x) __tg_exp2(__tg_promote1((__x))(__x))

// expm1
#undef expm1
#define expm1(__x) __tg_expm1(__tg_promote1((__x))(__x))

// fdim
#undef fdim
#define fdim(__x, __y) __tg_fdim(__tg_promote2((__x), (__y))(__x), \
__tg_promote2((__x), (__y))(__y))

// floor
#undef floor
#define floor(__x) __tg_floor(__tg_promote1((__x))(__x))

// fma
#undef fma
#define fma(__x, __y, __z)                                \
__tg_fma(__tg_promote3((__x), (__y), (__z))(__x), \
__tg_promote3((__x), (__y), (__z))(__y), \
__tg_promote3((__x), (__y), (__z))(__z))

// fmax
#undef fmax
#define fmax(__x, __y) __tg_fmax(__tg_promote2((__x), (__y))(__x), \
__tg_promote2((__x), (__y))(__y))

// fmin
#undef fmin
#define fmin(__x, __y) __tg_fmin(__tg_promote2((__x), (__y))(__x), \
__tg_promote2((__x), (__y))(__y))

// fmod
#undef fmod
#define fmod(__x, __y) __tg_fmod(__tg_promote2((__x), (__y))(__x), \
__tg_promote2((__x), (__y))(__y))

// frexp
#undef frexp
#define frexp(__x, __y) __tg_frexp(__tg_promote1((__x))(__x), __y)

// hypot
#undef hypot
#define hypot(__x, __y) __tg_hypot(__tg_promote2((__x), (__y))(__x), \
__tg_promote2((__x), (__y))(__y))

// ilogb
#undef ilogb
#define ilogb(__x) __tg_ilogb(__tg_promote1((__x))(__x))

// ldexp
#undef ldexp
#define ldexp(__x, __y) __tg_ldexp(__tg_promote1((__x))(__x), __y)

// lgamma
#undef lgamma
#define lgamma(__x) __tg_lgamma(__tg_promote1((__x))(__x))

// llrint
#undef llrint
#define llrint(__x) __tg_llrint(__tg_promote1((__x))(__x))

// llround
#undef llround
#define llround(__x) __tg_llround(__tg_promote1((__x))(__x))

// log10
#undef log10
#define log10(__x) __tg_log10(__tg_promote1((__x))(__x))

// log1p
#undef log1p
#define log1p(__x) __tg_log1p(__tg_promote1((__x))(__x))

// log2
#undef log2
#define log2(__x) __tg_log2(__tg_promote1((__x))(__x))

// logb
#undef logb
#define logb(__x) __tg_logb(__tg_promote1((__x))(__x))

// lrint
#undef lrint
#define lrint(__x) __tg_lrint(__tg_promote1((__x))(__x))

// lround
#undef lround
#define lround(__x) __tg_lround(__tg_promote1((__x))(__x))

// nearbyint
#undef nearbyint
#define nearbyint(__x) __tg_nearbyint(__tg_promote1((__x))(__x))

// nextafter
#undef nextafter
#define nextafter(__x, __y) __tg_nextafter(__tg_promote2((__x), (__y))(__x), \
__tg_promote2((__x), (__y))(__y))

// nexttoward
#undef nexttoward
#define nexttoward(__x, __y) __tg_nexttoward(__tg_promote1((__x))(__x), (__y))

// remainder
#undef remainder
#define remainder(__x, __y) __tg_remainder(__tg_promote2((__x), (__y))(__x), \
__tg_promote2((__x), (__y))(__y))

// remquo
#undef remquo
#define remquo(__x, __y, __z)                         \
__tg_remquo(__tg_promote2((__x), (__y))(__x), \
__tg_promote2((__x), (__y))(__y), \
(__z))

// rint
#undef rint
#define rint(__x) __tg_rint(__tg_promote1((__x))(__x))

// round
#undef round
#define round(__x) __tg_round(__tg_promote1((__x))(__x))

// scalbn
#undef scalbn
#define scalbn(__x, __y) __tg_scalbn(__tg_promote1((__x))(__x), __y)

// scalbln
#undef scalbln
#define scalbln(__x, __y) __tg_scalbln(__tg_promote1((__x))(__x), __y)

// tgamma
#undef tgamma
#define tgamma(__x) __tg_tgamma(__tg_promote1((__x))(__x))

// trunc
#undef trunc
#define trunc(__x) __tg_trunc(__tg_promote1((__x))(__x))

// carg
#undef carg
#define carg(__x) __tg_carg(__tg_promote1((__x))(__x))

// cimag
#undef cimag
#define cimag(__x) __tg_cimag(__tg_promote1((__x))(__x))

// conj
#undef conj
#define conj(__x) __tg_conj(__tg_promote1((__x))(__x))

// cproj
#undef cproj
#define cproj(__x) __tg_cproj(__tg_promote1((__x))(__x))

// creal
#undef creal
#define creal(__x) __tg_creal(__tg_promote1((__x))(__x))

#else

#include <tgmath.h>

#endif