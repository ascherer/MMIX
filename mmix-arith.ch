@x [0] l.13 Use C99 standard types instead of homebrewn typedefs.
@s bool normal @q unreserve a C++ keyword @>
@y
@z

@x [1] l.34 Improved module structure with interfaces.
#include <stdio.h>
#include <string.h>
#include <ctype.h>
@y
#include "mmix-arith.h" /* we use our own interface first;
  see |@(mmix-arith.h@>| */
@#
#include <stdio.h> /* |@!printf| */
#include <string.h> /* |@!strncmp| */
#include <ctype.h> /* |@!isdigit| */
@#
@h
@#
@z

@x [1] l.37 Move to interface.
@<Stuff for \CEE/ preprocessor@>@;
typedef enum{@+false,true@+} bool;
@<Tetrabyte and octabyte type definitions@>@;
@y
@z

@x [1] l.41 Factor out private stuff.
@<Global variables@>@;
@y
@<Global variables@>@;
@<Private variable@>@;
@<Internal prototypes@>@;
@z

@x [2] l.44 C99 prototypes for C2x.
@ Subroutines of this program are declared first with a prototype,
as in {\mc ANSI C}, then with an old-style \CEE/ function definition.
Here are some preprocessor commands that make this work correctly with both
new-style and old-style compilers.
@^prototypes for functions@>

@<Stuff for \CEE/ preprocessor@>=
#ifdef __STDC__
#define ARGS(list) list
#else
#define ARGS(list) ()
#endif
@y
@ Subroutines of this program are declared and defined with a prototype,
as in {\mc ANSI C}.
@z

@x [3] l.51 Use standard C99 types.
@<Tetra...@>=
typedef unsigned int tetra;
 /* for systems conforming to the LP-64 data model */
@y
@s uint32_t int
@<Tetra...@>=
typedef uint32_t tetra;
@z

@x [4] l.69 RAII.
octa zero_octa; /* |zero_octa.h=zero_octa.l=0| */
octa neg_one={-1,-1}; /* |neg_one.h=neg_one.l=-1| */
octa inf_octa={0x7ff00000,0}; /* floating point $+\infty$ */
octa standard_NaN={0x7ff80000,0}; /* floating point NaN(.5) */
@y
const octa zero_octa={0,0}; /* |zero_octa.h=zero_octa.l=0| */
const octa neg_one={-1,-1}; /* |neg_one.h=neg_one.l=-1| */
const octa inf_octa={0x7ff00000,0}; /* floating point $+\infty$ */
const octa standard_NaN={0x7ff80000,0}; /* floating point NaN(.5) */
@z

@x [5] l.78 C99 prototypes for C2x.
octa oplus @,@,@[ARGS((octa,octa))@];@+@t}\6{@>
octa oplus(y,z) /* compute $y+z$ */
  octa y,z;
@y
octa oplus( /* compute $y+z$ */
  octa y, octa z)
@z

@x [5] l.83 RAII.
{@+ octa x;
  x.h=y.h+z.h;@+
  x.l=y.l+z.l;
@y
{@+ octa x = {y.h+z.h, y.l+z.l};
@z

@x [5] l.88 C99 prototypes for C2x.
octa ominus @,@,@[ARGS((octa,octa))@];@+@t}\6{@>
octa ominus(y,z) /* compute $y-z$ */
  octa y,z;
@y
octa ominus( /* compute $y-z$ */
  octa y, octa z)
@z

@x [5] l.91 RAII.
{@+ octa x;
  x.h=y.h-z.h;@+
  x.l=y.l-z.l;
@y
{@+ octa x={y.h-z.h, y.l-z.l};
@z

@x [6] l.102 C99 prototypes for C2x.
octa incr @,@,@[ARGS((octa,int))@];@+@t}\6{@>
octa incr(y,delta) /* compute $y+\delta$ */
  octa y;
  int delta;
@y
octa incr( /* compute $y+\delta$ */
  octa y,
  int delta)
@z

@x [6] l.106 RAII.
{@+ octa x;
  x.h=y.h;@+ x.l=y.l+delta;
@y
{@+ octa x={y.h, y.l+delta};
@z

@x [6] l.110 Format improvement. (if-block requires braces.)
  }@+else if (x.l>y.l) x.h--;
@y
  }@+else {if (x.l>y.l) x.h--;}
@z

@x [7] l.117 C99 prototypes for C2x.
octa shift_left @,@,@[ARGS((octa,int))@];@+@t}\6{@>
octa shift_left(y,s) /* shift left by $s$ bits, where $0\le s\le64$ */
  octa y;
  int s;
@y
octa shift_left( /* shift left by $s$ bits, where $0\le s\le64$ */
  octa y,
  int s)
@z

@x [7] l.129 C99 prototypes for C2x.
octa shift_right @,@,@[ARGS((octa,int,int))@];@+@t}\6{@>
octa shift_right(y,s,u) /* shift right, arithmetically if $u=0$ */
  octa y;
  int s,u;
@y
octa shift_right( /* shift right, arithmetically if $u=0$ */
  octa y,
  int s, int u)
@z

@x [8] l.150 C99 prototypes for C2x.
octa omult @,@,@[ARGS((octa,octa))@];@+@t}\6{@>
octa omult(y,z)
  octa y,z;
@y
octa omult(
  octa y, octa z)
@z

@x [11] l.182 Compound literals.
aux.h=(w[7]<<16)+w[6], aux.l=(w[5]<<16)+w[4];
acc.h=(w[3]<<16)+w[2], acc.l=(w[1]<<16)+w[0];
@y
aux=(octa){(w[7]<<16)+w[6], (w[5]<<16)+w[4]};
acc=(octa){(w[3]<<16)+w[2], (w[1]<<16)+w[0]};
@z

@x [12] l.191 C99 prototypes for C2x.
octa signed_omult @,@,@[ARGS((octa,octa))@];@+@t}\6{@>
octa signed_omult(y,z)
  octa y,z;
@y
octa signed_omult(
  octa y, octa z)
@z

@x [12] l.195 RAII.
  octa acc;
  acc=omult(y,z);
@y
  octa acc=omult(y,z);
@z

@x [13] l.215 C99 prototypes for C2x.
octa odiv @,@,@[ARGS((octa,octa,octa))@];@+@t}\6{@>
octa odiv(x,y,z)
  octa x,y,z;
@y
octa odiv(
  octa x, octa y, octa z)
@z

@x [19] l.272 Compound literals.
acc.h=(q[3]<<16)+q[2], acc.l=(q[1]<<16)+q[0];
aux.h=(u[3]<<16)+u[2], aux.l=(u[1]<<16)+u[0];
@y
acc=(octa){(q[3]<<16)+q[2], (q[1]<<16)+q[0]};
aux=(octa){(u[3]<<16)+u[2], (u[1]<<16)+u[0]};
@z

@x [23] l.305 Change from MMIX home.
if (u[j+n]!=k) {
@y
if (u[j+n]!=(tetra)k) {
@z

@x [24] l.317 C99 prototypes for C2x.
octa signed_odiv @,@,@[ARGS((octa,octa))@];@+@t}\6{@>
octa signed_odiv(y,z)
  octa y,z;
@y
octa signed_odiv(
  octa y, octa z)
@z

@x [24] l.332 GCC warning. Change from MMIX home.
 case 0+0: return q;
@y
  @=/* else fall through */@>@;
 case 0+0: default: return q;
@z

@x [25] l.342 Add missing bit-fiddling functions.
implement directly, but three of them occur often enough to deserve
packaging as subroutines.
@y
implement directly, and they occur often enough to deserve
packaging as subroutines.
@z

@x [25] l.345 Add missing bit-fiddling functions.
@<Subr...@>=
@y
@<Subr...@>=
octa oor( /* compute $y\lor z$ */
  octa y, octa z)
{ @+ return (octa){y.h|z.h, y.l|z.l}; @+ }
@#
octa oorn( /* compute $y\lor\bar z$ */
  octa y, octa z)
{ @+ return (octa){y.h|~z.h, y.l|~z.l}; @+ }
@#
octa onor( /* compute $\overline{y\lor z}$ */
  octa y, octa z)
{ @+ return (octa){~(y.h|z.h), ~(y.l|z.l)}; @+ }
@#
@z

@x [25] l.346 C99 prototypes for C2x.
octa oand @,@,@[ARGS((octa,octa))@];@+@t}\6{@>
octa oand(y,z) /* compute $y\land z$ */
  octa y,z;
{@+ octa x;
  x.h=y.h&z.h;@+ x.l=y.l&z.l;
  return x;
}
@y
octa oand( /* compute $y\land z$ */
  octa y, octa z)
{ @+ return (octa){y.h&z.h, y.l&z.l}; @+ }
@z

@x [25] l.354 C99 prototypes for C2x.
octa oandn @,@,@[ARGS((octa,octa))@];@+@t}\6{@>
octa oandn(y,z) /* compute $y\land\bar z$ */
  octa y,z;
{@+ octa x;
  x.h=y.h&~z.h;@+ x.l=y.l&~z.l;
  return x;
}
@y
octa oandn( /* compute $y\land\bar z$ */
  octa y, octa z)
{ @+ return (octa){y.h&~z.h, y.l&~z.l}; @+ }
@#
octa onand( /* compute $\overline{y\land z}$ */
  octa y, octa z)
{ @+ return (octa){~(y.h&z.h), ~(y.l&z.l)}; @+ }
@z

@x [25] l.362 C99 prototypes for C2x.
octa oxor @,@,@[ARGS((octa,octa))@];@+@t}\6{@>
octa oxor(y,z) /* compute $y\oplus z$ */
  octa y,z;
{@+ octa x;
  x.h=y.h^z.h;@+ x.l=y.l^z.l;
  return x;
}
@y
octa oxor( /* compute $y\oplus z$ */
  octa y, octa z)
{ @+ return (octa){y.h^z.h, y.l^z.l}; @+ }
@#
octa onxor( /* compute $\overline{y\oplus z}$ */
  octa y, octa z)
{ @+ return (octa){~(y.h^z.h), ~(y.l^z.l)}; @+ }
@z

@x [26] l.387 C99 prototypes for C2x.
int count_bits @,@,@[ARGS((tetra))@];@+@t}\6{@>
int count_bits(x)
  tetra x;
@y
int count_bits(
  tetra x)
@z

@x [27] l.403 C99 prototypes for C2x.
tetra byte_diff @,@,@[ARGS((tetra,tetra))@];@+@t}\6{@>
tetra byte_diff(y,z)
  tetra y,z;
@y
tetra byte_diff(
  tetra y, tetra z)
@z

@x [28] l.421 C99 prototypes for C2x.
tetra wyde_diff @,@,@[ARGS((tetra,tetra))@];@+@t}\6{@>
tetra wyde_diff(y,z)
  tetra y,z;
@y
tetra wyde_diff(
  tetra y, tetra z)
@z

@x [29] l.434 C99 prototypes for C2x.
octa bool_mult @,@,@[ARGS((octa,octa,bool))@];@+@t}\6{@>
octa bool_mult(y,z,xor)
  octa y,z; /* the operands */
  bool xor; /* do we do xor instead of or? */
@y
octa bool_mult(
  octa y, octa z, /* the operands */
  bool xor) /* do we do xor instead of or? */
@z

@x [31] l.505 Factor out private stuff.
octa fpack @,@,@[ARGS((octa,int,char,int))@];@+@t}\6{@>
octa fpack(f,e,s,r)
  octa f; /* the normalized fraction part */
  int e; /* the raw exponent */
  char s; /* the sign */
  int r; /* the rounding mode */
@y
static octa fpack(
  octa f, /* the normalized fraction part */
  int e, /* the raw exponent */
  char s, /* the sign */
  int r) /* the rounding mode */
@z

@x [33] l.532 Change from MMIX home.
@ Everything falls together so nicely here, it's almost too good to be true!
@y
@ Everything falls together so nicely here, it's almost too good to be true!
The conditional expression in the case for |ROUND_NEAR|
rounds towards an even number in case of a tie.
@z

@x [33] l.540 Change from MMIX home.
 case ROUND_NEAR: o=incr(o, o.l&4? 2: 1);@+break;
@y
 case ROUND_NEAR: default: o=incr(o, o.l&4? 2: 1);@+break;
@z

@x [34] l.553 Factor out private stuff.
tetra sfpack @,@,@[ARGS((octa,int,char,int))@];@+@t}\6{@>
tetra sfpack(f,e,s,r)
  octa f; /* the fraction part */
  int e; /* the raw exponent */
  char s; /* the sign */
  int r; /* the rounding mode */
@y
static tetra sfpack(
  octa f, /* the fraction part */
  int e, /* the raw exponent */
  char s, /* the sign */
  int r) /* the rounding mode */
@z

@x [35] l.591 Change from MMIX home.
else if (o<0x100000) exceptions |= U_BIT; /* tininess */
@y
else if (o<0x800000) exceptions |= U_BIT; /* tininess */
@z

@x [37] l.610 Factor out private stuff.
ftype funpack @,@,@[ARGS((octa,octa*,int*,char*))@];@+@t}\6{@>
ftype funpack(x,f,e,s)
  octa x; /* the given floating point value */
  octa *f; /* address where the fraction part should be stored */
  int *e; /* address where the exponent part should be stored */
  char *s; /* address where the sign should be stored */
@y
static ftype funpack(
  octa x, /* the given floating point value */
  octa *f, /* address where the fraction part should be stored */
  int *e, /* address where the exponent part should be stored */
  char *s) /* address where the sign should be stored */
@z

@x [38] l.636 Factor out private stuff.
ftype sfunpack @,@,@[ARGS((tetra,octa*,int*,char*))@];@+@t}\6{@>
ftype sfunpack(x,f,e,s)
  tetra x; /* the given floating point value */
  octa *f; /* address where the fraction part should be stored */
  int *e; /* address where the exponent part should be stored */
  char *s; /* address where the sign should be stored */
@y
static ftype sfunpack(
  tetra x, /* the given floating point value */
  octa *f, /* address where the fraction part should be stored */
  int *e, /* address where the exponent part should be stored */
  char *s) /* address where the sign should be stored */
@z

@x [38] l.646 Compound literal.
  f->h=(x>>1)&0x3fffff, f->l=x<<31;
@y
  *f=(octa){(x>>1)&0x3fffff, x<<31};
@z

@x [39] l.665 C99 prototypes for C2x.
octa load_sf @,@,@[ARGS((tetra))@];@+@t}\6{@>
octa load_sf(z)
  tetra z; /* 32 bits to be loaded into a 64-bit register */
@y
octa load_sf(
  tetra z) /* 32 bits to be loaded into a 64-bit register */
@z

@x [39] l.669 RAII.
  octa f,x;@+int e;@+char s;@+ftype t;
  t=sfunpack(z,&f,&e,&s);
@y
  octa f,x;@+int e;@+char s;@+ftype t=sfunpack(z,&f,&e,&s);
@z

@x [40] l.682 C99 prototypes for C2x.
tetra store_sf @,@,@[ARGS((octa))@];@+@t}\6{@>
tetra store_sf(x)
  octa x; /* 64 bits to be loaded into a 32-bit word */
@y
tetra store_sf(
  octa x) /* 64 bits to be loaded into a 32-bit word */
@z

@x [40] l.686 RAII.
  octa f;@+tetra z;@+int e;@+char s;@+ftype t;
  t=funpack(x,&f,&e,&s);
@y
  octa f;@+tetra z;@+int e;@+char s;@+ftype t=funpack(x,&f,&e,&s);
@z

@x [40] l.689 Change from MMIX home.
 case zro: z=0;@+break;
@y
 default: case zro: z=0;@+break;
@z

@x [41] l.707 C99 prototypes for C2x.
octa fmult @,@,@[ARGS((octa,octa))@];@+@t}\6{@>
octa fmult(y,z)
  octa y,z;
@y
octa fmult(
  octa y, octa z)
@z

@x [41] l.711 RAII.
  ftype yt,zt;
  int ye,ze;
  char ys,zs;
  octa x,xf,yf,zf;
  register int xe;
  register char xs;
  yt=funpack(y,&yf,&ye,&ys);
  zt=funpack(z,&zf,&ze,&zs);
  xs=ys+zs-'+'; /* will be |'-'| when the result is negative */
@y
  octa x,xf,yf,zf;
  int ye,ze;
  char ys,zs;
  ftype yt=funpack(y,&yf,&ye,&ys),@|zt=funpack(z,&zf,&ze,&zs);
  register int xe;
  register char xs=ys+zs-'+'; /* will be |'-'| when the result is negative */
@z

@x [41] l.722 Change from MMIX home.
 case 4*zro+zro: case 4*zro+num: case 4*num+zro: x=zero_octa;@+break;
@y
 default: case 4*zro+zro: case 4*zro+num: case 4*num+zro: x=zero_octa;@+break;
@z

@x [42] l.734 GCC warning.
case 4*zro+nan: case 4*num+nan: case 4*inf+nan:
@y
  @=/* else fall through */@>@;
case 4*zro+nan: case 4*num+nan: case 4*inf+nan:
@z

@x [44] l.750 C99 prototypes for C2x.
octa fdivide @,@,@[ARGS((octa,octa))@];@+@t}\6{@>
octa fdivide(y,z)
  octa y,z;
@y
octa fdivide(
  octa y, octa z)
@z

@x [44] l.754 RAII.
  ftype yt,zt;
  int ye,ze;
  char ys,zs;
  octa x,xf,yf,zf;
  register int xe;
  register char xs;
  yt=funpack(y,&yf,&ye,&ys);
  zt=funpack(z,&zf,&ze,&zs);
  xs=ys+zs-'+'; /* will be |'-'| when the result is negative */
@y
  octa x,xf,yf,zf;
  int ye,ze;
  char ys,zs;
  ftype yt=funpack(y,&yf,&ye,&ys),@|zt=funpack(z,&zf,&ze,&zs);
  register int xe;
  register char xs=ys+zs-'+'; /* will be |'-'| when the result is negative */
@z

@x [44] l.767 GCC warning. Change from MMIX home.
 case 4*inf+num: case 4*inf+zro: x=inf_octa;@+break;
 case 4*zro+zro: case 4*inf+inf: x=standard_NaN;
@y
  @=/* fall through */@>@;
 case 4*inf+num: case 4*inf+zro: x=inf_octa;@+break;
 default: case 4*zro+zro: case 4*inf+inf: x=standard_NaN;
@z

@x [46] l.792 C99 prototypes for C2x.
octa fplus @,@,@[ARGS((octa,octa))@];@+@t}\6{@>
octa fplus(y,z)
  octa y,z;
@y
octa fplus(
  octa y, octa z)
@z

@x [46] l.796 RAII.
  ftype yt,zt;
  int ye,ze;
  char ys,zs;
  octa x,xf,yf,zf;
  register int xe,d;
  register char xs;
  yt=funpack(y,&yf,&ye,&ys);
  zt=funpack(z,&zf,&ze,&zs);
@y
  octa x,xf,yf,zf;
  int ye,ze;
  char ys,zs;
  ftype yt=funpack(y,&yf,&ye,&ys),@|zt=funpack(z,&zf,&ze,&zs);
  register int xe,d;
  register char xs;
@z

@x [46] l.811 GCC warning.
 case 4*num+inf: case 4*zro+inf: x=inf_octa;@+xs=zs;@+break;
@y
  @=/* else fall through */@>@;
 case 4*num+inf: case 4*zro+inf: x=inf_octa;@+xs=zs;@+break;
@z

@x [46] l.815 GCC warning. Change from MMIX home.
 case 4*zro+zro: x=zero_octa;
@y
  @=/* else fall through */@>@;
 default: case 4*zro+zro: x=zero_octa;
@z

@x [50] l.885 C99 prototypes for C2x.
int fepscomp @,@,@[ARGS((octa,octa,octa,int))@];@+@t}\6{@>
int fepscomp(y,z,e,s)
  octa y,z,e; /* the operands */
  int s; /* test similarity? */
@y
int fepscomp(
  octa y, octa z, octa e, /* the operands */
  int s) /* test similarity? */
@z

@x [54] l.974
static void bignum_times_ten @,@,@[ARGS((bignum*))@];
static void bignum_dec @,@,@[ARGS((bignum*,bignum*,tetra))@];
static int bignum_compare @,@,@[ARGS((bignum*,bignum*))@];
void print_float @,@,@[ARGS((octa))@];@+@t}\6{@>
void print_float(x)
  octa x;
@y
void print_float(
  octa x)
@z

@x [60] l.1122 C99 prototypes for C2x.
static void bignum_times_ten(f)
  bignum *f;
@y
static void bignum_times_ten(
  bignum *f)
@z

@x [61] l.1140 C99 prototypes for C2x.
static int bignum_compare(f,g)
  bignum *f,*g;
@y
static int bignum_compare(
  bignum *f, bignum *g)
@z

@x [63] l.1167 C99 prototypes for C2x.
static void bignum_dec(f,g,r)
  bignum *f,*g;
  tetra r; /* the radix */
@y
static void bignum_dec(
  bignum *f, bignum *g,
  tetra r) /* the radix */
@z

@x [67] l.1301 Change from MMIX home.
else if (strlen(s)>=e) printf("%.*s.%s",e,s,s+e);
@y
else if (strlen(s)>=(size_t)e) printf("%.*s.%s",e,s,s+e);
@z

@x [68] l.1342 C99 prototypes for C2x.
static void bignum_double @,@,@[ARGS((bignum*))@];
int scan_const @,@,@[ARGS((char*))@];@+@t}\6{@>
int scan_const(s)
  char *s;
@y
int scan_const(
  char *s)
@z

@x [68] l.1348 RAII.
  val.h=val.l=0;
@y
  val=zero_octa;
@z

@x [68] l.1357 Change from MMIX home.
 no_const_found: next_char=s;@+return -1;
@y
  next_char=s;@+return -1;
@z

@x [73] l.1402 GCC warning.
    if (q>buf0 || *p!='0')
       if (q<buf_max) *q++=*p;
       else if (*(q-1)=='0') *(q-1)=*p;
@y
    if (q>buf0 || *p!='0') {
       if (q<buf_max) *q++=*p;
       else if (*(q-1)=='0') *(q-1)=*p; }
@z

@x [75] l.1431 Factor out private stuff.
@d buf_max (buf+777)

@<Glob...@>=
@y
@d buf_max (buf+777)

@<Priv...@>=
@z

@x [76] l.1439 GCC warning.
register int zeros; /* leading zeros removed after decimal point */
@y
register int zeros=0; /* leading zeros removed after decimal point */
@z

@x [79] l.1483 Change from MMIX home.
 make_it_zero: exp=-99999;@+ goto packit;
@y
  exp=-99999;@+ goto packit;
@z

@x [82] l.1515 C99 prototypes for C2x.
static void bignum_double(f)
  bignum *f;
@y
static void bignum_double(
  bignum *f)
@z

@x [85] l.1579 C99 prototypes for C2x.
int fcomp @,@,@[ARGS((octa,octa))@];@+@t}\6{@>
int fcomp(y,z)
  octa y,z;
@y
int fcomp(
  octa y, octa z)
@z

@x [85] l.1583 RAII.
  ftype yt,zt;
  int ye,ze;
  char ys,zs;
  octa yf,zf;
  register int x;
  yt=funpack(y,&yf,&ye,&ys);
  zt=funpack(z,&zf,&ze,&zs);
@y
  octa yf,zf;
  int ye,ze;
  char ys,zs;
  ftype yt=funpack(y,&yf,&ye,&ys),@|zt=funpack(z,&zf,&ze,&zs);
  register int x=0;
@z

@x [85] l.1593 Change from MMIX home.
 case 4*zro+zro: return 0;
@y
 default: case 4*zro+zro: return 0;
@z

@x [86] l.1612 C99 prototypes for C2x.
octa fintegerize @,@,@[ARGS((octa,int))@];@+@t}\6{@>
octa fintegerize(z,r)
  octa z; /* the operand */
  int r; /* the rounding mode */
@y
octa fintegerize(
  octa z, /* the operand */
  int r) /* the rounding mode */
@z

@x [86] l.1617 RAII.
  ftype zt;
  int ze;
  char zs;
  octa xf,zf;
  zt=funpack(z,&zf,&ze,&zs);
@y
  octa xf,zf;
  int ze;
  char zs;
  ftype zt=funpack(z,&zf,&ze,&zs);
@z

@x [86] l.1625 GCC warning. Change from MMIX home.
 case inf: case zro: return z;
@y
  @=/* else fall through */@>@;
 case inf: case zro: default: return z;
@z

@x [87] l.1632 Compound literal.
if (ze<=1020) xf.h=0,xf.l=1;
@y
if (ze<=1020) xf=(octa){0,1};
@z

@x [87] l.1647 Compound literal.
if (xf.l) xf.h=0x3ff00000, xf.l=0;
@y
if (xf.l) xf=(octa){0x3ff00000, 0};
@z

@x [88] l.1654 C99 prototypes for C2x.
octa fixit @,@,@[ARGS((octa,int))@];@+@t}\6{@>
octa fixit(z,r)
  octa z; /* the operand */
  int r; /* the rounding mode */
@y
octa fixit(
  octa z, /* the operand */
  int r) /* the rounding mode */
@z

@x [88] l.1659 RAII.
  ftype zt;
  int ze;
  char zs;
  octa zf,o;
  zt=funpack(z,&zf,&ze,&zs);
@y
  octa zf,o;
  int ze;
  char zs;
  ftype zt=funpack(z,&zf,&ze,&zs);
@z

@x [88] l.1667 Change from MMIX home.
 case zro: return zero_octa;
@y
 case zro: default: return zero_octa;
@z

@x [89] l.1685 C99 prototypes for C2x.
octa floatit @,@,@[ARGS((octa,int,int,int))@];@+@t}\6{@>
octa floatit(z,r,u,p)
  octa z; /* octabyte to float */
  int r; /* rounding mode */
  int u; /* unsigned? */
  int p; /* short precision? */
@y
octa floatit(
  octa z, /* octabyte to float */
  int r, /* rounding mode */
  int u, /* unsigned? */
  int p) /* short precision? */
@z

@x [90] l.1712 RAII.
  register int ex;@+register tetra t;
  t=sfpack(z,e,s,r);
  ex=exceptions;
@y
  register tetra t=sfpack(z,e,s,r);
  register int ex=exceptions;
@z

@x [91] l.1722 C99 prototypes for C2x.
octa froot @,@,@[ARGS((octa,int))@];@+@t}\6{@>
octa froot(z,r)
  octa z; /* the operand */
  int r; /* the rounding mode */
@y
octa froot(
  octa z, /* the operand */
  int r) /* the rounding mode */
@z

@x [91] l.1727 RAII.
  ftype zt;
  int ze;
  char zs;
  octa x,xf,rf,zf;
  register int xe,k;
  if (!r) r=cur_round;
  zt=funpack(z,&zf,&ze,&zs);
@y
  octa x,xf,rf,zf;
  int ze;
  char zs;
  ftype zt=funpack(z,&zf,&ze,&zs);
  register int xe,k;
  if (!r) r=cur_round;
@z

@x [91] l.1738 Change from MMIX home.
 case inf: case zro: x=z;@+break;
@y
 default: case inf: case zro: x=z;@+break;
@z

@x [92] l.1754 Compound literal.
xf.h=0, xf.l=2;
@y
xf=(octa){0, 2};
@z

@x [92] l.1757 Compound literal.
rf.h=0, rf.l=(zf.h>>22)-1;
@y
rf=(octa){0, (zf.h>>22)-1};
@z

@x [93] l.1778 C99 prototypes for C2x.
octa fremstep @,@,@[ARGS((octa,octa,int))@];@+@t}\6{@>
octa fremstep(y,z,delta)
  octa y,z;
  int delta;
@y
octa fremstep(
  octa y, octa z,
  int delta)
@z

@x [93] l.1789 RAII.
  ftype yt,zt;
  int ye,ze;
  char xs,ys,zs;
  octa x,xf,yf,zf;
  register int xe,thresh,odd;
  yt=funpack(y,&yf,&ye,&ys);
  zt=funpack(z,&zf,&ze,&zs);
@y
  octa x,xf,yf,zf;
  int ye,ze;
  char xs,ys,zs;
  ftype yt=funpack(y,&yf,&ye,&ys),@|zt=funpack(z,&zf,&ze,&zs);
  register int xe,thresh,odd;
@z

@x [93] l.1797 Change from MMIX home.
 zero_out: x=zero_octa;
@y
 default: zero_out: x=zero_octa;
@z

@x [96] l.1845 Improved module structure with interface.
@* Index.  
@y
@* Public interface. This program module, {\mc MMIX-ARITH}, is central to the
whole \MMIX\ system. Each user of its functionality should include the
following header file.

@(mmix-arith.h@>=
#ifndef MMIX_ARITH_H
#define MMIX_ARITH_H
#include <stdbool.h> /* |@!bool| */
#include <stdint.h>  /* |@!uint32_t| */
@#
@<Tetrabyte and octabyte type definitions@>@;
@<Exported variables@>@;
@<External prototypes@>@;
@#
#endif /* |MMIX_ARITH_H| */

@ @<Exported...@>=
extern const octa zero_octa; /* |zero_octa.h=zero_octa.l=0| */
extern const octa neg_one; /* |neg_one.h=neg_one.l=-1| */
extern const octa inf_octa; /* floating point $+\infty$ */
extern const octa standard_NaN; /* floating point NaN(.5) */
@#
extern octa aux; /* auxiliary output of a subroutine */
extern bool overflow; /* set by certain subroutines for signed arithmetic */
extern int cur_round; /* the current rounding mode */
extern int exceptions; /* bits set by floating point operations */
extern octa val; /* value returned by |scan_const| */
extern char *next_char; /* where a scanned constant ended */

@ @<External proto...@>=
extern octa oplus(octa,octa);
  /* unsigned $y+z$ */
extern octa ominus(octa,octa);
  /* unsigned $y-z$ */
extern octa incr(octa,int);
  /* unsigned $y+\delta$ ($\delta$ is signed) */
extern octa shift_left(octa,int);
  /* $y\LL s$, $0\le s\le64$ */
extern octa shift_right(octa,int,int);
  /* $y\GG s$, signed if |!u| */
extern octa omult(octa,octa);
  /* unsigned $(|aux|,x)=y\times z$ */
extern octa signed_omult(octa,octa);
  /* signed $x=y\times z$, setting |overflow| */
extern octa odiv(octa,octa,octa);
  /* unsigned $(x,y)/z$; $|aux|=(x,y)\bmod z$ */
extern octa signed_odiv(octa,octa);
  /* signed $y/z$, when $z\ne0$; $|aux|=y\bmod z$ */
@#
extern octa oor(octa,octa);
  /* $y\lor z$ */
extern octa oorn(octa,octa);
  /* $y\lor\bar z$ */
extern octa onor(octa,octa);
  /* $\overline{y\lor z}$ */
extern octa oand(octa,octa);
  /* $y\land z$ */
extern octa oandn(octa,octa);
  /* $y\land \bar z$ */
extern octa onand(octa,octa);
  /* $\overline{y\land z}$ */
extern octa oxor(octa,octa);
  /* $y\oplus z$ */
extern octa onxor(octa,octa);
  /* $\overline{y\oplus z}$ */
@#
extern int count_bits(tetra);
  /* $x=\nu(z)$ */
@#
extern tetra byte_diff(tetra,tetra);
  /* half of \.{BDIF} */
extern tetra wyde_diff(tetra,tetra);
  /* half of \.{WDIF} */
extern octa bool_mult(octa,octa,bool);
  /* \.{MOR} or \.{MXOR} */
@#
extern octa load_sf(tetra);
  /* load short float */
extern tetra store_sf(octa);
  /* store short float */
extern octa fmult(octa,octa);
  /* floating point $x=y\otimes z$ */
extern octa fdivide(octa,octa);
  /* floating point $x=y\oslash z$ */
extern octa fplus(octa,octa);
  /* floating point $x=y\oplus z$ */
extern int fepscomp(octa,octa,octa,int);
  /* $x=|sim|?\ [y\sim z\ (\epsilon)]:\ [y\approx z\ (\epsilon)]$ */
extern void print_float(octa);
  /* print octabyte as floating decimal */
extern int scan_const(char*);
  /* |val| = floating or integer constant; returns the type */
extern int fcomp(octa,octa);
  /* $-1$, 0, 1, or 2 if $y<z$, $y=z$, $y>z$, $y\parallel z$ */
extern octa fintegerize(octa,int);
  /* floating point $x={\rm round}(z)$ */
extern octa fixit(octa,int);
  /* float to fix */
extern octa floatit(octa,int,int,int);
  /* fix to float */
extern octa froot(octa,int);
  /* floating point $x=\sqrt z$ */
extern octa fremstep(octa,octa,int);
  /* floating point $x\,{\rm rem}\,z=y\,{\rm rem}\,z$ */

@ @<Internal...@>=
static octa fpack(octa,int,char,int);
static tetra sfpack(octa,int,char,int);
static ftype funpack(octa,octa*,int*,char*);
static ftype sfunpack(tetra,octa*,int*,char*);
@#
static void bignum_times_ten(bignum*);
static void bignum_dec(bignum*,bignum*,tetra);
static int bignum_compare(bignum*,bignum*);
static void bignum_double(bignum*);

@* Index.
@z
