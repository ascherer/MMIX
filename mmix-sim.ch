@x [0] l.12
@s bool normal @q unreserve a C++ keyword @>
@y
@z

@x [6] l.443
pointer to a string; the last such pointer is M$_8[\$0\ll3+\$1]$, and
M$_8[\$0\ll3+\$1+8]$ is zero. (Register~\$1 will point to an octabyte in
@y
pointer to a string; the last such pointer is M$_8[\$0\ll3+\$1-8]$, and
M$_8[\$0\ll3+\$1]$ is zero. (Register~\$1 will point to an octabyte in
@z

@x [9] l.546
@* Basics. To get started, we define a type that provides semantic sugar.

@<Type...@>=
typedef enum {@!false,@!true}@+@!bool;
@y
@* Basics. Most of the stuff in the following sections comes from the {\mc
MMIX-ARITH} module.
@z

@x [10] l.555
represents unsigned 32-bit integers. The definition of \&{tetra}
given here should be changed, if necessary, to agree with the
definition in that module.
@y
represents unsigned 32-bit integers.
@s uint32_t int
@s uint8_t int
@s tetra int
@s octa int
@z

@x [10] l.561
typedef unsigned int tetra;
  /* for systems conforming to the LP-64 data model */
typedef struct {tetra h,l;} octa; /* two tetrabytes make one octabyte */
typedef unsigned char byte; /* a monobyte */
@y
typedef uint8_t byte; /* a monobyte */
@z

@x [11] l.566
@ We declare subroutines twice, once with a prototype and once
with the old-style~\CEE/ conventions. The following hack makes
this work with new compilers as well as the old standbys.

@<Preprocessor macros@>=
#ifdef __STDC__
#define ARGS(list) list
#else
#define ARGS(list) ()
#endif
@y
@ We declare subroutines twice, once with a prototype and once
with the old-style~\CEE/ conventions.
@s mem_node int
@s mem_tetra int

@<Proto...@>=
void print_hex @,@,@[ARGS((octa))@];
void print_int @,@,@[ARGS((octa))@];
mem_node* new_mem @,@,@[ARGS((void))@];
mem_tetra* mem_find @,@,@[ARGS((octa))@];
void read_tet @,@,@[ARGS((void))@];
byte read_byte @,@,@[ARGS((void))@];
void make_map @,@,@[ARGS((void))@];
void print_line @,@,@[ARGS((int))@];
void show_line @,@,@[ARGS((void))@];
void print_freqs @,@,@[ARGS((mem_node*))@];
void stack_store @,@,@[ARGS((void))@];
void stack_load @,@,@[ARGS((void))@];
int register_truth @,@,@[ARGS((octa,mmix_opcode))@];
void trace_print @,@,@[ARGS((octa))@];
void show_stats @,@,@[ARGS((bool))@];
void scan_option @,@,@[ARGS((char*,bool))@];
void catchint @,@,@[ARGS((int))@];
octa scan_hex @,@,@[ARGS((char*,octa))@];
void print_string @,@,@[ARGS((octa))@];
void show_breaks @,@,@[ARGS((mem_node*))@];
void dump @,@,@[ARGS((mem_node*))@];
void dump_tet @,@,@[ARGS((tetra))@];
@z

@x [12] l.578
void print_hex @,@,@[ARGS((octa))@];@+@t}\6{@>
@y
@z

@x [13] l.592
@<Sub...@>=
extern octa zero_octa; /* |zero_octa.h=zero_octa.l=0| */
extern octa neg_one; /* |neg_one.h=neg_one.l=-1| */
extern octa aux,val; /* auxiliary data */
extern bool overflow; /* flag set by signed multiplication and division */
extern int exceptions; /* bits set by floating point operations */
extern int cur_round; /* the current rounding mode */
extern char *next_char; /* where a scanned constant ended */
extern octa oplus @,@,@[ARGS((octa y,octa z))@];
  /* unsigned $y+z$ */
extern octa ominus @,@,@[ARGS((octa y,octa z))@];
  /* unsigned $y-z$ */
extern octa incr @,@,@[ARGS((octa y,int delta))@];
  /* unsigned $y+\delta$ ($\delta$ is signed) */
extern octa oand @,@,@[ARGS((octa y,octa z))@];
  /* $y\land z$ */
extern octa shift_left @,@,@[ARGS((octa y,int s))@];
  /* $y\LL s$, $0\le s\le64$ */
extern octa shift_right @,@,@[ARGS((octa y,int s,int u))@];
  /* $y\GG s$, signed if |!u| */
extern octa omult @,@,@[ARGS((octa y,octa z))@];
  /* unsigned $(|aux|,x)=y\times z$ */
extern octa signed_omult @,@,@[ARGS((octa y,octa z))@];
  /* signed $x=y\times z$ */
extern octa odiv @,@,@[ARGS((octa x,octa y,octa z))@];
  /* unsigned $(x,y)/z$; $|aux|=(x,y)\bmod z$ */
extern octa signed_odiv @,@,@[ARGS((octa y,octa z))@];
  /* signed $x=y/z$ */
extern int count_bits @,@,@[ARGS((tetra z))@];
  /* $x=\nu(z)$ */
extern tetra byte_diff @,@,@[ARGS((tetra y,tetra z))@];
  /* half of \.{BDIF} */
extern tetra wyde_diff @,@,@[ARGS((tetra y,tetra z))@];
  /* half of \.{WDIF} */
extern octa bool_mult @,@,@[ARGS((octa y,octa z,bool xor))@];
  /* \.{MOR} or \.{MXOR} */
extern octa load_sf @,@,@[ARGS((tetra z))@];
  /* load short float */
extern tetra store_sf @,@,@[ARGS((octa x))@];
  /* store short float */
extern octa fplus @,@,@[ARGS((octa y,octa z))@];
  /* floating point $x=y\oplus z$ */
extern octa fmult @,@,@[ARGS((octa y ,octa z))@];
  /* floating point $x=y\otimes z$ */
extern octa fdivide @,@,@[ARGS((octa y,octa z))@];
  /* floating point $x=y\oslash z$ */
extern octa froot @,@,@[ARGS((octa,int))@];
  /* floating point $x=\sqrt z$ */
extern octa fremstep @,@,@[ARGS((octa y,octa z,int delta))@];
  /* floating point $x\,{\rm rem}\,z=y\,{\rm rem}\,z$ */
extern octa fintegerize @,@,@[ARGS((octa z,int mode))@];
  /* floating point $x={\rm round}(z)$ */
extern int fcomp @,@,@[ARGS((octa y,octa z))@];
  /* $-1$, 0, 1, or 2 if $y<z$, $y=z$, $y>z$, $y\parallel z$ */
extern int fepscomp @,@,@[ARGS((octa y,octa z,octa eps,int sim))@];
  /* $x=|sim|?\ [y\sim z\ (\epsilon)]:\ [y\approx z\ (\epsilon)]$ */
extern octa floatit @,@,@[ARGS((octa z,int mode,int unsgnd,int shrt))@];
  /* fix to float */
extern octa fixit @,@,@[ARGS((octa z,int mode))@];
  /* float to fix */
extern void print_float @,@,@[ARGS((octa z))@];
  /* print octabyte as floating decimal */
extern int scan_const @,@,@[ARGS((char* buf))@];
  /* |val| = floating or integer constant; returns the type */

@y
@z

@x [15] l.672
void print_int @,@,@[ARGS((octa))@];@+@t}\6{@>
@y
@z

@x [17] l.743
mem_node* new_mem @,@,@[ARGS((void))@];@+@t}\6{@>
@y
@z

@x [20] l.774
mem_tetra* mem_find @,@,@[ARGS((octa))@];@+@t}\6{@>
@y
@z

@x [26] l.890
void read_tet @,@,@[ARGS((void))@];@+@t}\6{@>
@y
@z

@x [27] l.899
byte read_byte @,@,@[ARGS((void))@];@+@t}\6{@>
@y
@z

@x [32] l.965
do @<Load the next item@>@;@+while (!postamble);
@y
do @<Load the next item@>@; while (!postamble);
@z

@x [34] l.999
case lop_fixr: delta=yzbytes; goto fixr;
@y
case lop_fixr: mmo_load(incr(cur_loc,-yzbytes<<2),yzbytes); continue;
@z

@x [34] l.1001
 read_tet(); delta=tet;
 if (delta&0xfe000000) mmo_err;
fixr: tmp=incr(cur_loc,-(delta>=0x1000000? (delta&0xffffff)-(1<<j): delta)<<2);
 mmo_load(tmp,delta);
@y
 read_tet();@+if (tet&0xfe000000) mmo_err;
 delta=(tet>=0x1000000? (tet&0xffffff)-(1<<j): tet);
 mmo_load(incr(cur_loc,-delta<<2),tet);
@z

@x [37] l.1054
G=zbyte;@+ L=0;
@y
G=zbyte;@+ L=0;@+ O=0;
@z

@x [42] l.1102
void make_map @,@,@[ARGS((void))@];@+@t}\6{@>
@y
@z

@x [45] l.1149
void print_line @,@,@[ARGS((int))@];@+@t}\6{@>
@y
@z

@x [47] l.1176
void show_line @,@,@[ARGS((void))@];@+@t}\6{@>
@y
@z

@x [47] l.1183
    if (shown_line>0)
      if (cur_line<shown_line) printf("--------\n"); /* indicate upward move */
      else printf("     ...\n"); /* indicate the gap */
@y
    if (shown_line>0) {
      if (cur_line<shown_line) printf("--------\n"); /* indicate upward move */
      else printf("     ...\n"); /* indicate the gap */ }
@z

@x [49] l.1204
  else freopen(file_info[cur_file].name,"r",src_file);
@y
  else if (freopen(file_info[cur_file].name,"r",src_file)) {}
@z

@x [50] l.1225
void print_freqs @,@,@[ARGS((mem_node*))@];@+@t}\6{@>
@y
@z

@x [62] l.1409
register int i,j,k; /* miscellaneous indices */
@y
register int i,j=0,k; /* miscellaneous indices */
@z

@x [75] l.1779
register int G,L,O; /* accessible copies of key registers */
@y
register int G,L,O=0; /* accessible copies of key registers */
@z

@x [77] l.1792
(The macro \.{ABSTIME} is defined externally in the file \.{abstime.h},
which should have just been created by {\mc ABSTIME}\kern.05em;
{\mc ABSTIME} is
a trivial program that computes the value of the standard library function
|time(NULL)|. We assume that this number, which is the number of seconds in
@y
(The macro \.{ABSTIME} will be set to a numeric value at compilation-time in
\.{Makefile}. We assume that this number, which is the number of seconds in
@z

@x l.1801
@d VERSION 1 /* version of the \MMIX\ architecture that we support */
@y
@d ABSTIME /* number of seconds in “the epoch” */
@d VERSION 1 /* version of the \MMIX\ architecture that we support */
@z

@x [77] l.1803
@d SUBSUBVERSION 1 /* further qualification to version number */
@y
@d SUBSUBVERSION 3 /* further qualification to version number */
@z

@x [80] l.1842
if (xx>=G) {
@y
{ if (xx>=G) {
@z

@x [80] l.1849
}
@y
} }
@z

@x [82] l.1865
void stack_store @,@,@[ARGS((void))@];@+@t}\6{@>
@y
@z

@x [83] l.1886
void stack_load @,@,@[ARGS((void))@];@+@t}\6{@>
@y
@z

@x [89] l.2027
 round_mode=(y.l? y.l: cur_round);@+goto store_fx;
@y
 round_mode=(y.l? y.l: (tetra)cur_round);@+goto store_fx;
@z

@x [90] l.2043
case CMPU: case CMPUI:@+if (y.h<z.h) goto cmp_neg;
@y
  @=/* else fall through */@>@;
case CMPU: case CMPUI:@+if (y.h<z.h) goto cmp_neg;
@z

@x l.2051
case FCMP: k=fcomp(y,z);
@y
  @=/* else fall through */@>@;
case FCMP: k=fcomp(y,z);
@z

@x [91] l.2068
int register_truth @,@,@[ARGS((octa,mmix_opcode))@];@+@t}\6{@>
@y
@z

@x [91] l.2079
{@+register int b;
@y
{@+register int b=0;
@z

@x [91] l.2075
 case 1: b=(o.h==0 && o.l==0);@+break; /* zero? */
@y
 default: case 1: b=(o.h==0 && o.l==0);@+break; /* zero? */
@z

@x [95] l.2159
case STO: case STOI: case STOU: case STOUI: case STUNC: case STUNCI:
@y
  @=/* fall through */@>@;
case STO: case STOI: case STOU: case STOUI: case STUNC: case STUNCI:
@z

@x [98] l.2216
  if (z.l>L || z.h) z.h=0, z.l=L;
@y
  if (z.l>(tetra)L || z.h) z.h=0, z.l=L;
@z

@x [99] l.2222
  if (z.h!=0 || z.l>255 || z.l<L || z.l<32) goto illegal_inst;
@y
  if (z.h!=0 || z.l>255 || z.l<(tetra)L || z.l<32) goto illegal_inst;
@z

@x [107] l.2366
case LDVTS: case LDVTSI: privileged_inst: strcpy(lhs,"!privileged");
@y
  @=/* else fall through */@>@;
case LDVTS: case LDVTSI: privileged_inst: strcpy(lhs,"!privileged");
@z

@x [112,113] l.2443
Here we need only declare those subroutines, and write three primitive
interfaces on which they depend.

@ @<Glob...@>=
extern void mmix_io_init @,@,@[ARGS((void))@];
extern octa mmix_fopen @,@,@[ARGS((unsigned char,octa,octa))@];
extern octa mmix_fclose @,@,@[ARGS((unsigned char))@];
extern octa mmix_fread @,@,@[ARGS((unsigned char,octa,octa))@];
extern octa mmix_fgets @,@,@[ARGS((unsigned char,octa,octa))@];
extern octa mmix_fgetws @,@,@[ARGS((unsigned char,octa,octa))@];
extern octa mmix_fwrite @,@,@[ARGS((unsigned char,octa,octa))@];
extern octa mmix_fputs @,@,@[ARGS((unsigned char,octa))@];
extern octa mmix_fputws @,@,@[ARGS((unsigned char,octa))@];
extern octa mmix_fseek @,@,@[ARGS((unsigned char,octa))@];
extern octa mmix_ftell @,@,@[ARGS((unsigned char))@];
extern void print_trip_warning @,@,@[ARGS((int,octa))@];
extern void mmix_fake_stdin @,@,@[ARGS((FILE*))@];
@y
Here we need only write three primitive
interfaces on which they depend.

@ The following three functions are not declared in any header file, although
they are used in {\mc MMIX-IO}. Similar functions are defined in the
meta-simulator {\mc MMIX-PIPE}.

@<Proto...@>=
int mmgetchars @,@,@[ARGS((char*,int,octa,int))@];
void mmputchars @,@,@[ARGS((unsigned char*,int,octa))@];
char stdin_chr @,@,@[ARGS((void))@];
@z

@x [114] l.2468
int mmgetchars @,@,@[ARGS((char*,int,octa,int))@];@+@t}\6{@>
@y
@z

@x [117] l.2516
void mmputchars @,@,@[ARGS((unsigned char*,int,octa))@];@+@t}\6{@>
@y
@z

@x [120] l.2558
char stdin_chr @,@,@[ARGS((void))@];@+@t}\6{@>
@y
@z

@x [125] l.2630
 case RESUME_SET: k=(b.l>>16)&0xff;
@y
  @=/* else fall through */@>@;
 case RESUME_SET: k=(b.l>>16)&0xff;
@z

@x l.2632
 case RESUME_AGAIN:@+if ((b.l>>24)==RESUME) goto illegal_inst;
@y
  @=/* else fall through */@>@;
 case RESUME_AGAIN:@+if ((b.l>>24)==RESUME) goto illegal_inst;
@z

@x [137] l.2820
fmt_style style;
char *stream_name[]={"StdIn","StdOut","StdErr"};
@.StdIn@>
@.StdOut@>
@.StdErr@>
@#
void trace_print @,@,@[ARGS((octa))@];@+@t}\6{@>
@y
@z

@x [137] l.2835
 case handle:@+if (o.h==0 && o.l<3) printf(stream_name[o.l]);
@y
 case handle:@+if (o.h==0 && o.l<3) printf("%s",stream_name[o.l]);
@z

@x [138] l.2846
case 's': printf(special_name[zz]);@+break;
@y
case 's': printf("%s",special_name[zz]);@+break;
@z

@x l.2848
case 'l': printf(lhs);@+break;
@y
case 'l': printf("%s",lhs);@+break;
@z

@x [139] l.
char left_paren[]={0,'[','^','_','('}; /* denotes the rounding mode */
@y
fmt_style style;
char *stream_name[]={"StdIn","StdOut","StdErr"};
@.StdIn@>
@.StdOut@>
@.StdErr@>
@#
char left_paren[]={0,'[','^','_','('}; /* denotes the rounding mode */
@z

@x [140] l.2862
void show_stats @,@,@[ARGS((bool))@];@+@t}\6{@>
@y
@z

@x [141] l.2887
#include "abstime.h"
@y
@#
#include "mmix-arith.h" /* |@!tetra|, |@!octa| */
#include "mmix-io.h" /* |@!mmix_io_init| */
@#
@z

@x [141] l.2891
@<Subroutines@>@;
@y
@<Prototypes@>@;
@<Subroutines@>@;
@z

@x [143] l.2946
void scan_option @,@,@[ARGS((char*,bool))@];@+@t}\6{@>
@y
@z

@x [143] l.2967
 case 'P': profiling=true;@+return;
@y
  @=/* else fall through */@>@;
 case 'P': profiling=true;@+return;
@z

@x l.2987
    for (k=0;usage_help[k][0];k++) fprintf(stderr,usage_help[k]);
@y
    for (k=0;usage_help[k][0];k++) fprintf(stderr,"%s",usage_help[k]);
@z

@x l.2989
  }@+else@+ for (k=0;usage_help[k][1]!='b';k++) printf(usage_help[k]);
@y
  }@+else@+ for (k=0;usage_help[k][1]!='b';k++) printf("%s",usage_help[k]);
@z

@x [148] l.3064
void catchint @,@,@[ARGS((int))@];@+@t}\6{@>
@y
@z

@x [148] l.3068
  interrupt=true;
@y
  if (n!=SIGINT) return;
  interrupt=true;
@z

@x [149] l.3093
  case 'h':@+ for (k=0;interactive_help[k][0];k++) printf(interactive_help[k]);
@y
  case 'h':@+ for (k=0;interactive_help[k][0];k++) printf("%s",interactive_help[k]);
@z

@x l.3096
 check_syntax:@+ if (*p!='\n') {
@y
  if (*p!='\n') {
@z

@x [150] l.3114
    }@+else if (command_buf[0]!='\n' && command_buf[0]!='i' &&
              command_buf[0]!='%')
      if (command_buf[0]==' ') printf("%s",command_buf);
      else ready=true;
@y
    }@+else if (command_buf[0]!='\n' && command_buf[0]!='i' &&
              command_buf[0]!='%') {
      if (command_buf[0]==' ') printf("%s",command_buf);
      else ready=true; }
@z

@x [154] l.3194
octa scan_hex @,@,@[ARGS((char*,octa))@];@+@t}\6{@>
@y
@z

@x [158] l.3266
    if (val.h!=0 || val.l>255 || val.l<L || val.l<32) break;
@y
    if (val.h!=0 || val.l>255 || val.l<(tetra)L || val.l<32) break;
@z

@x l.3270
    if (val.h==0 && val.l<L) L=val.l;
@y
    if (val.h==0 && val.l<(tetra)L) L=val.l;
@z

@x [160] l.3301
void print_string @,@,@[ARGS((octa))@];@+@t}\6{@>
@y
@z

@x [162] l.3347
void show_breaks @,@,@[ARGS((mem_node*))@];@+@t}\6{@>
@y
@z

@x [165] l.3412
void dump @,@,@[ARGS((mem_node*))@];@+@t}\6{@>
void dump_tet @,@,@[ARGS((tetra))@];@+@t}\6{@>
@y
@z
