@x [1] l.14
@s tetra int
@y
@s tetra int
@s octa int
@z

@x [1] l.20 Use standard C99 types. Use MMIX-ARITH interface stuff.
#include <string.h>
@<Prototype preparations@>@;
@<Type definitions@>@;
@y
#include <string.h>
#include <stdint.h>
@#
#include "mmix-arith.h" /* |@!ARGS|, |@!tetra|, |@!octa| */
@#
@<Type definition@>@;
@z

@x [1] l.34 CWEB 3.0 does this.
  do @<List the next item@>@;@+while (!postamble);
@y
  do @<List the next item@>@; while (!postamble);
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
@s uint8_t int
@<Type...@>=
typedef uint8_t byte; /* a monobyte */
@z

@x [39] l.457 Change from MMIX home.
else if (count!=stab_start+yz+1)
  fprintf(stderr,"YZ field at lop_end should have been %d!\n",count-yz-1);
@y
else if (count-stab_start-1!=yz)
  fprintf(stderr,"YZ field at lop_end should have been %d!\n",count-stab_start-1);
@z
