@x [1] l.14
@s tetra int
@y
@s byte int
@s tetra int
@s octa int
@z

@x [1] l.19 Use standard C99 types. Use MMIX-ARITH interface stuff.
#include <time.h>
#include <string.h>
@<Prototype preparations@>@;
@<Type definitions@>@;
@y
#include <string.h>
#include <time.h>
@#
#include "mmix-arith.h" /* |@!byte|, |@!tetra|, |@!octa|, |@!incr| */
@#
@z

@x [1] l.26 C99 prototypes for C2x.
int main(argc,argv)
  int argc;@+char*argv[];
@y
int main(
  int argc,char*argv[])
@z

@x [1] l.29
  register int j,delta,postamble=0;
  register char *p;
@y
  register int j,delta;
  register char *p;
  bool postamble=false;
@z

@x [1] l.34 CWEB 3.0 does this.
  do @<List the next item@>@;@+while (!postamble);
@y
  do @<List the next item@>@; while (!postamble);
@z

@x [2] l.41
listing=1, verbose=0;
@y
listing=true, verbose=false;
@z

@x [2] l.43
  if (argv[j][1]=='s') listing=0;
  else if (argv[j][1]=='v') verbose=1;
@y
  if (argv[j][1]=='s') listing=false;
  else if (argv[j][1]=='v') verbose=true;
@z

@x [4] l.62
int listing; /* are we listing everything? */
int verbose; /* are we also showing the tetras of input as they are read? */
@y
bool listing; /* are we listing everything? */
bool verbose; /* are we also showing the tetras of input as they are read? */
@z

@x [5] l.66 Purge MMIX-ARITH stuff.
@ @<Prototype preparations@>=
#ifdef __STDC__
#define ARGS(list) list
#else
#define ARGS(list) ()
#endif
@y
@ (This section remains empty for historic reasons.)
@z

@x [7] l.92 Improve typography.
whenever an |int| has at least 32 bits.
@y
whenever type |int| has at least 32~bits.
@z

@x [7] l.94 Use standard C99 types.
@<Type...@>=
typedef unsigned char byte; /* a monobyte */
typedef unsigned int tetra; /* a tetrabyte */
typedef struct {@+tetra h,l;}@+octa; /* an octabyte */
@y
@z

@x [8] l.99 Use 'incr' from MMIX-ARITH.
@ The |incr| subroutine adds a signed integer to an (unsigned) octabyte.

@<Sub...@>=
octa incr @,@,@[ARGS((octa,int))@];
octa incr(o,delta)
  octa o;
  int delta;
{
  register tetra t;
  octa x;
  if (delta>=0) {
    t=0xffffffff-delta;
    if (o.l<=t) x.l=o.l+delta, x.h=o.h;
    else x.l=o.l-t-1, x.h=o.h+1;
  } else {
    t=-delta;
    if (o.l>=t) x.l=o.l-t, x.h=o.h;
    else x.l=o.l+(0xffffffff+delta)+1, x.h=o.h-1;
  }
  return x;
}
@y
@ (This section remains empty for historic reasons.)
@z

@x [9] l.127 C99 prototypes for C2x.
void read_tet @,@,@[ARGS((void))@];
void read_tet()
@y
void read_tet(void)
@z

@x [9] l.142 C99 prototypes for C2x.
byte read_byte @,@,@[ARGS((void))@];
byte read_byte()
@y
byte read_byte(void)
@z

@x [17] l.217 Compound literal.
cur_loc.h=cur_loc.l=0;
@y
cur_loc=zero_octa;
@z

@x [21] l.302
 while(1) {
@y
 while (true) {
@z

@x [22] l.316
case lop_post: postamble=1;
@y
case lop_post: postamble=true;
@z

@x [26] l.386 C99 prototypes for C2x.
void print_stab @,@,@[ARGS((void))@];
void print_stab()
@y
void print_stab(void)
@z

@x [30] l.457 Change from MMIX home.
else if (count!=stab_start+yz+1)
  fprintf(stderr,"YZ field at lop_end should have been %d!\n",count-yz-1);
@y
else if (count-stab_start-1!=yz)
  fprintf(stderr,"YZ field at lop_end should have been %d!\n",count-stab_start-1);
@z
