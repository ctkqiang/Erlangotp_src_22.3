/*
 * %CopyrightBegin%
 *
 * Copyright Ericsson AB 2004-2018. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * %CopyrightEnd%
 */

#define ASM
/*
 * %CopyrightBegin%
 *
 * Copyright Ericsson AB 2004-2016. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * %CopyrightEnd%
 */


#ifndef HIPE_AMD64_ASM_H
#define HIPE_AMD64_ASM_H


#define AMD64_LEAF_WORDS	24
#define LEAF_WORDS		24
#define AMD64_NR_ARG_REGS	4
#define NR_ARG_REGS		4

#define AMD64_HP_IN_REGISTER	1
#if AMD64_HP_IN_REGISTER
#define AMD64_HEAP_POINTER 15
#endif

#define AMD64_FCALLS_IN_REGISTER 0
#if AMD64_FCALLS_IN_REGISTER
#define AMD64_FCALLS_REGISTER 11
#endif

#define AMD64_HEAP_LIMIT_IN_REGISTER 0
#if AMD64_HEAP_LIMIT_IN_REGISTER
#define AMD64_HEAP_LIMIT_REGISTER 12
#endif

#define AMD64_SIMULATE_NSP	0


#ifdef ASM
/*
 * Only assembler stuff from here on (when included from *.S)
 */

/*
 * Workarounds for Darwin.
 */

/* Darwin */
#define TEXT		.text
#define JOIN(X,Y)	X##Y
#define CSYM(NAME)	JOIN(_,NAME)
#define ASYM(NAME)	CSYM(NAME)
#define GLOBAL(NAME)	.globl NAME
#define SET_SIZE(NAME)	/*empty*/
#define TYPE_FUNCTION(NAME)	/*empty*/


/*
 * Reserved registers.
 */
#define P		%rbp

#if AMD64_HP_IN_REGISTER
#define SAVE_HP	        movq %r15, P_HP(P)
#define RESTORE_HP	movq P_HP(P), %r15
#else
#define SAVE_HP		/*empty*/
#define RESTORE_HP	/*empty*/
#endif

#if AMD64_FCALLS_IN_REGISTER
#define SAVE_FCALLS	movq %r11, P_FCALLS(P)
#define RESTORE_FCALLS	movq P_FCALLS(P), %r11
#else
#define SAVE_FCALLS	/*empty*/
#define RESTORE_FCALLS	/*empty*/
#endif

#if AMD64_HEAP_LIMIT_IN_REGISTER
#define RESTORE_HEAP_LIMIT	movq P_HP_LIMIT(P), %r12
#else
#define RESTORE_HEAP_LIMIT	/*empty*/
#endif

#define NSP		%rsp
#define SAVE_CSP	movq	%rsp, P_CSP(P)
#define RESTORE_CSP	movq	P_CSP(P), %rsp


/*
 * Debugging macros
 *
 * Keeps track of whether context has been saved in the debug build, allowing us
 * to detect when the garbage collector is called when it shouldn't.
 */
#ifdef DEBUG
#  define SET_GC_UNSAFE			\
	movq	$1, P_GCUNSAFE(P)
#  define SET_GC_SAFE			\
	movq	$0, P_GCUNSAFE(P)
#else
#  define SET_GC_UNSAFE
#  define SET_GC_SAFE
#endif

/*
 * Context switching macros.
 */
#define SWITCH_C_TO_ERLANG_QUICK	\
	SAVE_CSP; \
	movq P_NSP(P), NSP

#define SWITCH_ERLANG_TO_C_QUICK	\
	movq NSP, P_NSP(P); \
	RESTORE_CSP

#define SAVE_CACHED_STATE	\
	SAVE_HP;		\
	SAVE_FCALLS;		\
	SET_GC_SAFE

#define RESTORE_CACHED_STATE	\
	RESTORE_HP;		\
	RESTORE_HEAP_LIMIT;	\
	RESTORE_FCALLS;		\
	SET_GC_UNSAFE

#define SWITCH_C_TO_ERLANG	\
	RESTORE_CACHED_STATE;	\
	SWITCH_C_TO_ERLANG_QUICK

#define SWITCH_ERLANG_TO_C	\
	SAVE_CACHED_STATE;	\
	SWITCH_ERLANG_TO_C_QUICK

/*
 * Argument (parameter) registers.
 */


#define ARG0	%rsi
#define ARG1	%rdx
#define ARG2	%rcx
#define ARG3	%r8

/*
 * TEMP_RV:
 *	Used in nbif_stack_trap_ra to preserve the return value.
 *	Must be a C callee-save register.
 *	Must be otherwise unused in the return path.
 */
#define TEMP_RV		%rbx


#define LOAD_ARG_REGS	movq P_ARG0(P), %rsi ; movq P_ARG1(P), %rdx ; movq P_ARG2(P), %rcx ; movq P_ARG3(P), %r8 ; 

#define STORE_ARG_REGS	movq %rsi, P_ARG0(P) ; movq %rdx, P_ARG1(P) ; movq %rcx, P_ARG2(P) ; movq %r8, P_ARG3(P) ; 

#define NSP_CALL(FUN)	call FUN
#define NSP_RETN(NPOP)	ret $NPOP
#define NSP_RET0	ret

/* #define NBIF_ARG_1_0	# movq	%rsi, %rsi */
/* #define NBIF_ARG_2_0	# movq	%rsi, %rsi */
/* #define NBIF_ARG_2_1	# movq	%rdx, %rdx */
/* #define NBIF_ARG_3_0	# movq	%rsi, %rsi */
/* #define NBIF_ARG_3_1	# movq	%rdx, %rdx */
/* #define NBIF_ARG_3_2	# movq	%rcx, %rcx */
/* #define NBIF_ARG_4_0	# movq	%rsi, %rsi */
/* #define NBIF_ARG_4_1	# movq	%rdx, %rdx */
/* #define NBIF_ARG_4_2	# movq	%rcx, %rcx */
/* #define NBIF_ARG_4_3	# movq	%r8, %r8 */
/* #define NBIF_ARG_5_0	# movq	%rsi, %rsi */
/* #define NBIF_ARG_5_1	# movq	%rdx, %rdx */
/* #define NBIF_ARG_5_2	# movq	%rcx, %rcx */
/* #define NBIF_ARG_5_3	# movq	%r8, %r8 */
/* #define NBIF_ARG_5_4	movq	8(%rsp), %r9 */


/* #define NBIF_RET_0	NSP_RET0 */
/* #define NBIF_RET_1	NSP_RET0 */
/* #define NBIF_RET_2	NSP_RET0 */
/* #define NBIF_RET_3	NSP_RET0 */
/* #define NBIF_RET_4	NSP_RET0 */
/* #define NBIF_RET_5	NSP_RETN(8) */

#endif /* ASM */

#endif /* HIPE_AMD64_ASM_H */

#include "config.h"
#include "hipe_literals.h"


#if THE_NON_VALUE == 0
#define TEST_GOT_EXN	testq	%rax, %rax
#else
#define TEST_GOT_EXN	cmpq	$THE_NON_VALUE, %rax
#endif




#if defined(ERTS_ENABLE_LOCK_CHECK)
#  define CALL_BIF(F) \
		movq CSYM(nbif_impl_##F)@GOTPCREL(%rip), %r11; \
		movq %r11, P_BIF_CALLEE(P); \
		call CSYM(hipe_debug_bif_wrapper)
#else
#  define CALL_BIF(F)	call	CSYM(nbif_impl_##F)
#endif

/*
 * standard_bif_interface_1(nbif_name, cbif_name)
 * standard_bif_interface_2(nbif_name, cbif_name)
 * standard_bif_interface_3(nbif_name, cbif_name)
 * standard_bif_interface_4(nbif_name, cbif_name)
 * standard_bif_interface_0(nbif_name, cbif_name)
 *
 * Generate native interface for a BIF with 0-4 parameters and
 * standard failure mode.
 */










/*
 * nofail_primop_interface_0(nbif_name, cbif_name)
 * nofail_primop_interface_1(nbif_name, cbif_name)
 * nofail_primop_interface_2(nbif_name, cbif_name)
 * nofail_primop_interface_3(nbif_name, cbif_name)
 *
 * Generate native interface for a primop with implicit P
 * parameter, 0-3 ordinary parameters and no failure mode.
 * Also used for guard BIFs.
 */








/*
 * nocons_nofail_primop_interface_0(nbif_name, cbif_name)
 * nocons_nofail_primop_interface_1(nbif_name, cbif_name)
 * nocons_nofail_primop_interface_2(nbif_name, cbif_name)
 * nocons_nofail_primop_interface_3(nbif_name, cbif_name)
 * nocons_nofail_primop_interface_5(nbif_name, cbif_name)
 *
 * Generate native interface for a primop with implicit P
 * parameter, 0-3 or 5 ordinary parameters, and no failure mode.
 * The primop cannot CONS or gc.
 */











/*
 * noproc_primop_interface_0(nbif_name, cbif_name)
 * noproc_primop_interface_1(nbif_name, cbif_name)
 * noproc_primop_interface_2(nbif_name, cbif_name)
 * noproc_primop_interface_3(nbif_name, cbif_name)
 * noproc_primop_interface_5(nbif_name, cbif_name)
 *
 * Generate native interface for a primop with no implicit P
 * parameter, 0-3 or 5 ordinary parameters, and no failure mode.
 * The primop cannot CONS or gc.
 */










/*
 * AMD64-specific primops.
 */
#ifndef NO_FPE_SIGNALS

#ifndef HAVE_nbif_handle_fp_exception
#define HAVE_nbif_handle_fp_exception
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_handle_fp_exception))
ASYM(nbif_handle_fp_exception):
	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C_QUICK
	call	CSYM(erts_restore_fpu)
	SWITCH_C_TO_ERLANG_QUICK

	/* return */
	NSP_RET0
	SET_SIZE(ASYM(nbif_handle_fp_exception))
	TYPE_FUNCTION(ASYM(nbif_handle_fp_exception))
#endif
#endif /* NO_FPE_SIGNALS */

/*
 * Implement gc_bif_interface_N as standard_bif_interface_N.
 */





/*
 * Implement gc_nofail_primop_interface_1 as nofail_primop_interface_1.
 */


/*
 * %CopyrightBegin%
 *
 * Copyright Ericsson AB 2004-2018. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * %CopyrightEnd%
 */
/*
 *
 * List all non architecture-specific BIFs and primops, and
 * classify each as belonging to one of the classes below.
 * This list is included in hipe_${ARCH}_bifs.m4, which is
 * responsible for translating these classifications to the
 * best possible native code wrappers.
 *
 * XXX: We should have a more detailed BIF classification
 * with a number of orthogonal properties (e.g., UPDATES_HP,
 * NEEDS_NSP, CAN_FAIL, CAN_GC, etc), from which we should
 * generate appropriate interfaces.
 *
 * The classification is expressed in terms of the resources
 * and BIF failure modes described below.
 *
 * Resources:
 * - NSP: native stack pointer
 *   NSP is read by GC BIFs and primops, and hipe_handle_exception().
 *   NSP is updated at compiler-inserted calls to hipe_inc_nstack().
 *   No other BIF or primop may access NSP.
 * - NSP_LIMIT: native stack limit
 *   NSP_LIMIT is only updated at compiler-inserted calls to inc_stack.
 *   Everywhere else, the cached value equals the value stored in P.
 * - NRA: native return address
 *   NRA is read by GC BIFs and primops, and hipe_handle_exception().
 *   No BIF or primop may update NRA.
 * - HP: heap pointer
 *   All BIFs can read and update HP.
 *   Primops with access to P that do not access HP are called "nocons".
 * - HP_LIMIT: heap limit
 *   HP_LIMIT is only updated by GC BIFs and primops.
 *   Everywhere else, the cached value equals the value stored in P.
 * - FCALLS: reduction counter
 *   All BIFs can read and update FCALLS (because BEAM abuses FCALLS
 *   to trigger GCs). XXX: can we avoid that overhead?
 *   All nocons primops do not access FCALLS.
 *   All other primops with access to P can read and update FCALLS.
 * - P: pointer to the state record for the process
 *
 * BIF failure modes:
 * - none: may not signal any exception
 *   The BIF wrapper needs no checks before returning.
 * - standard: may signal any exception
 *   The BIF wrapper must check for an exception before returning.
 *   Zero-arity BIFs signal no exceptions, except in a small number
 *   of cases explicitly enumerated here.
 */

/****************************************************************
 *			BIF CLASS DESCRIPTIONS			*
 ****************************************************************/

/*
 * NOTE:
 *  Beam BIFs have the prototype:
 *    Eterm (*BIF)(Process *c_p, Eterm *regs, UWord *I)
 *  Native BIFs have the prototype:
 *    Eterm (*BIF)(Process *c_p, Eterm *regs)
 *
 * Beam BIFs expect 'I' to contain current instruction
 * pointer when called from beam, and expect 'I' to
 * contain a pointer to the export entry of the BIF
 * when called from native code. In order to facilitate
 * this, beam BIFs are called via wrapper functions
 * when called from native code. These wrapper functions
 * are auto-generated (by utils/make_tables) and have
 * the function names nbif_impl_<BIF>.
 *
 * The standard_bif_interface_*() and
 * gc_bif_interface_*() will add the prefix and
 * thus call nbif_impl_<cbif_name>. That is, all
 * functions (true BIFs as well as other c-functions)
 * called via these interfaces have to be named
 * nbif_impl_<FUNC>.
 */

/*
 * See NOTE above!
 *
 * standard_bif_interface_0(nbif_name, cbif_name)
 * standard_bif_interface_1(nbif_name, cbif_name)
 * standard_bif_interface_2(nbif_name, cbif_name)
 * standard_bif_interface_3(nbif_name, cbif_name)
 *
 * A BIF with implicit P parameter, 0-3 ordinary parameters,
 * which may fail.
 * HP and FCALLS may be read and updated.
 * HP_LIMIT, NSP, NSP_LIMIT, and NRA may not be accessed.
 */

/*
 * nofail_primop_interface_0(nbif_name, cbif_name)
 * nofail_primop_interface_1(nbif_name, cbif_name)
 * nofail_primop_interface_2(nbif_name, cbif_name)
 * nofail_primop_interface_3(nbif_name, cbif_name)
 *
 * A primop or guard BIF with no failure mode, otherwise
 * identical to standard_bif_interface_N.
 */

/*
 * See NOTE above!
 *
 * gc_bif_interface_0(nbif_name, cbif_name)
 * gc_bif_interface_1(nbif_name, cbif_name)
 * gc_bif_interface_2(nbif_name, cbif_name)
 * gc_bif_interface_3(nbif_name, cbif_name)
 *
 * A BIF which may do a GC or walk the native stack.
 * May read NSP, NSP_LIMIT, NRA, HP, HP_LIMIT, and FCALLS.
 * May update HP, HP_LIMIT, and FCALLS.
 * May not update NSP, NSP_LIMIT, or NRA.
 * Otherwise identical to standard_bif_interface_N.
 */

/*
 * gc_nofail_primop_interface_1(nbif_name, cbif_name)
 *
 * A primop with implicit P parameter, 1 ordinary parameter,
 * and no failure mode.
 * May read NSP, NSP_LIMIT, NRA, HP, HP_LIMIT, and FCALLS.
 * May update HP, HP_LIMIT, and FCALLS.
 * May not update NSP, NSP_LIMIT, or NRA.
 */

/*
 * nocons_nofail_primop_interface_0(nbif_name, cbif_name)
 * nocons_nofail_primop_interface_1(nbif_name, cbif_name)
 * nocons_nofail_primop_interface_2(nbif_name, cbif_name)
 * nocons_nofail_primop_interface_3(nbif_name, cbif_name)
 * nocons_nofail_primop_interface_5(nbif_name, cbif_name)
 *
 * A primop with implicit P parameter, 0-3 or 5 ordinary parameters,
 * and no failure mode.
 * HP, HP_LIMIT, FCALLS, NSP, NSP_LIMIT, and NRA may not be accessed.
 */

/*
 * noproc_primop_interface_0(nbif_name, cbif_name)
 * noproc_primop_interface_1(nbif_name, cbif_name)
 * noproc_primop_interface_2(nbif_name, cbif_name)
 * noproc_primop_interface_3(nbif_name, cbif_name)
 * noproc_primop_interface_5(nbif_name, cbif_name)
 *
 * A primop with no P parameter, 0-3 or 5 ordinary parameters,
 * and no failure mode.
 * HP, HP_LIMIT, FCALLS, NSP, NSP_LIMIT, and NRA may not be accessed.
 */

/****************************************************************
 *			BIF CLASSIFICATION			*
 ****************************************************************/

/*
 * Zero-arity BIFs that can fail.
 */

#ifndef HAVE_nbif_processes_0
#define HAVE_nbif_processes_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_processes_0))
ASYM(nbif_processes_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(processes_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_processes_0))
	TYPE_FUNCTION(ASYM(nbif_processes_0))
#endif

#ifndef HAVE_nbif_ports_0
#define HAVE_nbif_ports_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ports_0))
ASYM(nbif_ports_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(ports_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ports_0))
	TYPE_FUNCTION(ASYM(nbif_ports_0))
#endif

/*
 * BIFs and primops that may do a GC (change heap limit and walk the native stack).
 * XXX: erase/1 and put/2 cannot fail
 */

#ifndef HAVE_nbif_erts_internal_check_process_code_1
#define HAVE_nbif_erts_internal_check_process_code_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_check_process_code_1))
ASYM(nbif_erts_internal_check_process_code_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(hipe_erts_internal_check_process_code_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_check_process_code_1))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_check_process_code_1))
#endif

#ifndef HAVE_nbif_erase_1
#define HAVE_nbif_erase_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erase_1))
ASYM(nbif_erase_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(erase_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erase_1))
	TYPE_FUNCTION(ASYM(nbif_erase_1))
#endif

#ifndef HAVE_nbif_erts_internal_garbage_collect_1
#define HAVE_nbif_erts_internal_garbage_collect_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_garbage_collect_1))
ASYM(nbif_erts_internal_garbage_collect_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(erts_internal_garbage_collect_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_garbage_collect_1))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_garbage_collect_1))
#endif

#ifndef HAVE_nbif_gc_1
#define HAVE_nbif_gc_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_gc_1))
ASYM(nbif_gc_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	call	CSYM(hipe_gc)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* return */
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_gc_1))
	TYPE_FUNCTION(ASYM(nbif_gc_1))
#endif

#ifndef HAVE_nbif_put_2
#define HAVE_nbif_put_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_put_2))
ASYM(nbif_put_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(put_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_put_2))
	TYPE_FUNCTION(ASYM(nbif_put_2))
#endif

#ifndef HAVE_nbif_hipe_bifs_build_stacktrace
#define HAVE_nbif_hipe_bifs_build_stacktrace
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_build_stacktrace))
ASYM(nbif_hipe_bifs_build_stacktrace):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(hipe_bifs_build_stacktrace_1)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_build_stacktrace))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_build_stacktrace))
#endif

/*
 * Debug BIFs that need read access to the full state.
 * hipe_bifs:nstack_used_size/0 only needs read access to NSP.
 * They are classified as GC BIFs for simplicity.
 */

#ifndef HAVE_nbif_hipe_bifs_show_nstack_1
#define HAVE_nbif_hipe_bifs_show_nstack_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_show_nstack_1))
ASYM(nbif_hipe_bifs_show_nstack_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(hipe_show_nstack_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_show_nstack_1))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_show_nstack_1))
#endif

#ifndef HAVE_nbif_hipe_bifs_show_pcb_1
#define HAVE_nbif_hipe_bifs_show_pcb_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_show_pcb_1))
ASYM(nbif_hipe_bifs_show_pcb_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(hipe_bifs_show_pcb_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_show_pcb_1))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_show_pcb_1))
#endif

#ifndef HAVE_nbif_hipe_bifs_nstack_used_size_0
#define HAVE_nbif_hipe_bifs_nstack_used_size_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_nstack_used_size_0))
ASYM(nbif_hipe_bifs_nstack_used_size_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(hipe_bifs_nstack_used_size_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_nstack_used_size_0))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_nstack_used_size_0))
#endif

#ifndef HAVE_nbif_hipe_bifs_debug_native_called
#define HAVE_nbif_hipe_bifs_debug_native_called
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_debug_native_called))
ASYM(nbif_hipe_bifs_debug_native_called):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(hipe_bifs_debug_native_called_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_debug_native_called))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_debug_native_called))
#endif

/*
 * Arithmetic operators called indirectly by the HiPE compiler.
 */

#ifndef HAVE_nbif_add_2
#define HAVE_nbif_add_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_add_2))
ASYM(nbif_add_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(splus_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_add_2))
	TYPE_FUNCTION(ASYM(nbif_add_2))
#endif

#ifndef HAVE_nbif_sub_2
#define HAVE_nbif_sub_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_sub_2))
ASYM(nbif_sub_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(sminus_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_sub_2))
	TYPE_FUNCTION(ASYM(nbif_sub_2))
#endif

#ifndef HAVE_nbif_mul_2
#define HAVE_nbif_mul_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_mul_2))
ASYM(nbif_mul_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(stimes_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_mul_2))
	TYPE_FUNCTION(ASYM(nbif_mul_2))
#endif

#ifndef HAVE_nbif_div_2
#define HAVE_nbif_div_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_div_2))
ASYM(nbif_div_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(div_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_div_2))
	TYPE_FUNCTION(ASYM(nbif_div_2))
#endif

#ifndef HAVE_nbif_intdiv_2
#define HAVE_nbif_intdiv_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_intdiv_2))
ASYM(nbif_intdiv_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(intdiv_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_intdiv_2))
	TYPE_FUNCTION(ASYM(nbif_intdiv_2))
#endif

#ifndef HAVE_nbif_rem_2
#define HAVE_nbif_rem_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_rem_2))
ASYM(nbif_rem_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(rem_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_rem_2))
	TYPE_FUNCTION(ASYM(nbif_rem_2))
#endif

#ifndef HAVE_nbif_bsl_2
#define HAVE_nbif_bsl_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_bsl_2))
ASYM(nbif_bsl_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(bsl_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_bsl_2))
	TYPE_FUNCTION(ASYM(nbif_bsl_2))
#endif

#ifndef HAVE_nbif_bsr_2
#define HAVE_nbif_bsr_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_bsr_2))
ASYM(nbif_bsr_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(bsr_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_bsr_2))
	TYPE_FUNCTION(ASYM(nbif_bsr_2))
#endif

#ifndef HAVE_nbif_band_2
#define HAVE_nbif_band_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_band_2))
ASYM(nbif_band_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(band_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_band_2))
	TYPE_FUNCTION(ASYM(nbif_band_2))
#endif

#ifndef HAVE_nbif_bor_2
#define HAVE_nbif_bor_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_bor_2))
ASYM(nbif_bor_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(bor_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_bor_2))
	TYPE_FUNCTION(ASYM(nbif_bor_2))
#endif

#ifndef HAVE_nbif_bxor_2
#define HAVE_nbif_bxor_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_bxor_2))
ASYM(nbif_bxor_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(bxor_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_bxor_2))
	TYPE_FUNCTION(ASYM(nbif_bxor_2))
#endif

#ifndef HAVE_nbif_bnot_1
#define HAVE_nbif_bnot_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_bnot_1))
ASYM(nbif_bnot_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(bnot_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_bnot_1))
	TYPE_FUNCTION(ASYM(nbif_bnot_1))
#endif

/*
 * Miscellaneous primops.
 */

#ifndef HAVE_nbif_set_timeout
#define HAVE_nbif_set_timeout
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_set_timeout))
ASYM(nbif_set_timeout):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(hipe_set_timeout)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_set_timeout))
	TYPE_FUNCTION(ASYM(nbif_set_timeout))
#endif

#ifndef HAVE_nbif_conv_big_to_float
#define HAVE_nbif_conv_big_to_float
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_conv_big_to_float))
ASYM(nbif_conv_big_to_float):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(hipe_conv_big_to_float)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_conv_big_to_float))
	TYPE_FUNCTION(ASYM(nbif_conv_big_to_float))
#endif

#ifndef HAVE_nbif_rethrow
#define HAVE_nbif_rethrow
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_rethrow))
ASYM(nbif_rethrow):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(hipe_rethrow)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_rethrow))
	TYPE_FUNCTION(ASYM(nbif_rethrow))
#endif

#ifndef HAVE_nbif_raw_raise
#define HAVE_nbif_raw_raise
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_raw_raise))
ASYM(nbif_raw_raise):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(hipe_raw_raise)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_raw_raise))
	TYPE_FUNCTION(ASYM(nbif_raw_raise))
#endif

#ifndef HAVE_nbif_find_na_or_make_stub
#define HAVE_nbif_find_na_or_make_stub
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_find_na_or_make_stub))
ASYM(nbif_find_na_or_make_stub):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(hipe_find_na_or_make_stub)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_find_na_or_make_stub))
	TYPE_FUNCTION(ASYM(nbif_find_na_or_make_stub))
#endif

#ifndef HAVE_nbif_nonclosure_address
#define HAVE_nbif_nonclosure_address
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_nonclosure_address))
ASYM(nbif_nonclosure_address):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(hipe_nonclosure_address)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_nonclosure_address))
	TYPE_FUNCTION(ASYM(nbif_nonclosure_address))
#endif

#ifndef HAVE_nbif_fclearerror_error
#define HAVE_nbif_fclearerror_error
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_fclearerror_error))
ASYM(nbif_fclearerror_error):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C_QUICK
	call	CSYM(hipe_fclearerror_error)
	SWITCH_C_TO_ERLANG_QUICK

	/* return */
	NSP_RET0
	SET_SIZE(ASYM(nbif_fclearerror_error))
	TYPE_FUNCTION(ASYM(nbif_fclearerror_error))
#endif

#ifndef HAVE_nbif_is_divisible
#define HAVE_nbif_is_divisible
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_is_divisible))
ASYM(nbif_is_divisible):
	/* set up the parameters */
	movq	%rsi, %rdi
	movq	%rdx, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C_QUICK
	call	CSYM(hipe_is_divisible)
	SWITCH_C_TO_ERLANG_QUICK

	/* return */
	NSP_RET0
	SET_SIZE(ASYM(nbif_is_divisible))
	TYPE_FUNCTION(ASYM(nbif_is_divisible))
#endif

#ifndef HAVE_nbif_is_unicode
#define HAVE_nbif_is_unicode
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_is_unicode))
ASYM(nbif_is_unicode):
	/* set up the parameters */
	movq	%rsi, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C_QUICK
	call	CSYM(hipe_is_unicode)
	SWITCH_C_TO_ERLANG_QUICK

	/* return */
	NSP_RET0
	SET_SIZE(ASYM(nbif_is_unicode))
	TYPE_FUNCTION(ASYM(nbif_is_unicode))
#endif

/*
 * Mbox primops with implicit P parameter.
 */

#ifndef HAVE_nbif_select_msg
#define HAVE_nbif_select_msg
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_select_msg))
ASYM(nbif_select_msg):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C_QUICK
	call	CSYM(hipe_select_msg)
	SWITCH_C_TO_ERLANG_QUICK

	/* return */
	NSP_RET0
	SET_SIZE(ASYM(nbif_select_msg))
	TYPE_FUNCTION(ASYM(nbif_select_msg))
#endif

/*
 * Primops without any P parameter.
 * These cannot CONS or gc.
 */

#ifndef HAVE_nbif_cmp_2
#define HAVE_nbif_cmp_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_cmp_2))
ASYM(nbif_cmp_2):
	/* set up the parameters */
	movq	%rsi, %rdi
	movq	%rdx, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C_QUICK
	call	CSYM(cmp)
	SWITCH_C_TO_ERLANG_QUICK

	/* return */
	NSP_RET0
	SET_SIZE(ASYM(nbif_cmp_2))
	TYPE_FUNCTION(ASYM(nbif_cmp_2))
#endif

#ifndef HAVE_nbif_eq_2
#define HAVE_nbif_eq_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_eq_2))
ASYM(nbif_eq_2):
	/* set up the parameters */
	movq	%rsi, %rdi
	movq	%rdx, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C_QUICK
	call	CSYM(eq)
	SWITCH_C_TO_ERLANG_QUICK

	/* return */
	NSP_RET0
	SET_SIZE(ASYM(nbif_eq_2))
	TYPE_FUNCTION(ASYM(nbif_eq_2))
#endif

/*
 * Bit-syntax primops with implicit P parameter.
 * XXX: all of the _2 versions cons on the ordinary heap
 * XXX: all of them can cons and thus update FCALLS
 */

#ifndef HAVE_nbif_bs_get_integer_2
#define HAVE_nbif_bs_get_integer_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_bs_get_integer_2))
ASYM(nbif_bs_get_integer_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	call	CSYM(erts_bs_get_integer_2)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* return */
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_bs_get_integer_2))
	TYPE_FUNCTION(ASYM(nbif_bs_get_integer_2))
#endif

#ifndef HAVE_nbif_bs_get_binary_2
#define HAVE_nbif_bs_get_binary_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_bs_get_binary_2))
ASYM(nbif_bs_get_binary_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	call	CSYM(erts_bs_get_binary_2)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* return */
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_bs_get_binary_2))
	TYPE_FUNCTION(ASYM(nbif_bs_get_binary_2))
#endif

#ifndef HAVE_nbif_bs_get_float_2
#define HAVE_nbif_bs_get_float_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_bs_get_float_2))
ASYM(nbif_bs_get_float_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	call	CSYM(erts_bs_get_float_2)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* return */
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_bs_get_float_2))
	TYPE_FUNCTION(ASYM(nbif_bs_get_float_2))
#endif

#ifndef HAVE_nbif_bs_put_utf8
#define HAVE_nbif_bs_put_utf8
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_bs_put_utf8))
ASYM(nbif_bs_put_utf8):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C_QUICK
	call	CSYM(hipe_bs_put_utf8)
	SWITCH_C_TO_ERLANG_QUICK

	/* return */
	NSP_RET0
	SET_SIZE(ASYM(nbif_bs_put_utf8))
	TYPE_FUNCTION(ASYM(nbif_bs_put_utf8))
#endif

#ifndef HAVE_nbif_bs_put_utf16be
#define HAVE_nbif_bs_put_utf16be
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_bs_put_utf16be))
ASYM(nbif_bs_put_utf16be):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(hipe_bs_put_utf16be)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_bs_put_utf16be))
	TYPE_FUNCTION(ASYM(nbif_bs_put_utf16be))
#endif

#ifndef HAVE_nbif_bs_put_utf16le
#define HAVE_nbif_bs_put_utf16le
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_bs_put_utf16le))
ASYM(nbif_bs_put_utf16le):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(hipe_bs_put_utf16le)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_bs_put_utf16le))
	TYPE_FUNCTION(ASYM(nbif_bs_put_utf16le))
#endif

/*
 * Bit-syntax primops without any P parameter.
 * These cannot CONS or gc.
 */

#ifndef HAVE_nbif_bs_allocate
#define HAVE_nbif_bs_allocate
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_bs_allocate))
ASYM(nbif_bs_allocate):
	/* set up the parameters */
	movq	%rsi, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C_QUICK
	call	CSYM(hipe_bs_allocate)
	SWITCH_C_TO_ERLANG_QUICK

	/* return */
	NSP_RET0
	SET_SIZE(ASYM(nbif_bs_allocate))
	TYPE_FUNCTION(ASYM(nbif_bs_allocate))
#endif

#ifndef HAVE_nbif_bs_reallocate
#define HAVE_nbif_bs_reallocate
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_bs_reallocate))
ASYM(nbif_bs_reallocate):
	/* set up the parameters */
	movq	%rsi, %rdi
	movq	%rdx, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C_QUICK
	call	CSYM(hipe_bs_reallocate)
	SWITCH_C_TO_ERLANG_QUICK

	/* return */
	NSP_RET0
	SET_SIZE(ASYM(nbif_bs_reallocate))
	TYPE_FUNCTION(ASYM(nbif_bs_reallocate))
#endif

#ifndef HAVE_nbif_bs_utf8_size
#define HAVE_nbif_bs_utf8_size
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_bs_utf8_size))
ASYM(nbif_bs_utf8_size):
	/* set up the parameters */
	movq	%rsi, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C_QUICK
	call	CSYM(hipe_bs_utf8_size)
	SWITCH_C_TO_ERLANG_QUICK

	/* return */
	NSP_RET0
	SET_SIZE(ASYM(nbif_bs_utf8_size))
	TYPE_FUNCTION(ASYM(nbif_bs_utf8_size))
#endif

#ifndef HAVE_nbif_bs_get_utf8
#define HAVE_nbif_bs_get_utf8
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_bs_get_utf8))
ASYM(nbif_bs_get_utf8):
	/* set up the parameters */
	movq	%rsi, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C_QUICK
	call	CSYM(erts_bs_get_utf8)
	SWITCH_C_TO_ERLANG_QUICK

	/* return */
	NSP_RET0
	SET_SIZE(ASYM(nbif_bs_get_utf8))
	TYPE_FUNCTION(ASYM(nbif_bs_get_utf8))
#endif

#ifndef HAVE_nbif_bs_utf16_size
#define HAVE_nbif_bs_utf16_size
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_bs_utf16_size))
ASYM(nbif_bs_utf16_size):
	/* set up the parameters */
	movq	%rsi, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C_QUICK
	call	CSYM(hipe_bs_utf16_size)
	SWITCH_C_TO_ERLANG_QUICK

	/* return */
	NSP_RET0
	SET_SIZE(ASYM(nbif_bs_utf16_size))
	TYPE_FUNCTION(ASYM(nbif_bs_utf16_size))
#endif

#ifndef HAVE_nbif_bs_get_utf16
#define HAVE_nbif_bs_get_utf16
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_bs_get_utf16))
ASYM(nbif_bs_get_utf16):
	/* set up the parameters */
	movq	%rsi, %rdi
	movq	%rdx, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C_QUICK
	call	CSYM(erts_bs_get_utf16)
	SWITCH_C_TO_ERLANG_QUICK

	/* return */
	NSP_RET0
	SET_SIZE(ASYM(nbif_bs_get_utf16))
	TYPE_FUNCTION(ASYM(nbif_bs_get_utf16))
#endif

#ifndef HAVE_nbif_bs_validate_unicode_retract
#define HAVE_nbif_bs_validate_unicode_retract
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_bs_validate_unicode_retract))
ASYM(nbif_bs_validate_unicode_retract):
	/* set up the parameters */
	movq	%rsi, %rdi
	movq	%rdx, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C_QUICK
	call	CSYM(hipe_bs_validate_unicode_retract)
	SWITCH_C_TO_ERLANG_QUICK

	/* return */
	NSP_RET0
	SET_SIZE(ASYM(nbif_bs_validate_unicode_retract))
	TYPE_FUNCTION(ASYM(nbif_bs_validate_unicode_retract))
#endif

/*
 * Bit-syntax primops. The runtime system requires P,
 * hence the use of nocons_nofail_primop_interface_N().
 */

#ifndef HAVE_nbif_bs_put_small_float
#define HAVE_nbif_bs_put_small_float
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_bs_put_small_float))
ASYM(nbif_bs_put_small_float):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx
	# movq	%r8, %r8
	movq	8(%rsp), %r9

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C_QUICK
	call	CSYM(hipe_bs_put_small_float)
	SWITCH_C_TO_ERLANG_QUICK

	/* return */
	NSP_RETN(8)
	SET_SIZE(ASYM(nbif_bs_put_small_float))
	TYPE_FUNCTION(ASYM(nbif_bs_put_small_float))
#endif

#ifndef HAVE_nbif_bs_put_bits
#define HAVE_nbif_bs_put_bits
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_bs_put_bits))
ASYM(nbif_bs_put_bits):
	/* set up the parameters */
	movq	%rsi, %rdi
	movq	%rdx, %rsi
	movq	%rcx, %rdx
	movq	%r8, %rcx
	movq	8(%rsp), %r8

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C_QUICK
	call	CSYM(hipe_bs_put_bits)
	SWITCH_C_TO_ERLANG_QUICK

	/* return */
	NSP_RETN(8)
	SET_SIZE(ASYM(nbif_bs_put_bits))
	TYPE_FUNCTION(ASYM(nbif_bs_put_bits))
#endif

#ifndef HAVE_nbif_bs_put_big_integer
#define HAVE_nbif_bs_put_big_integer
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_bs_put_big_integer))
ASYM(nbif_bs_put_big_integer):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx
	# movq	%r8, %r8
	movq	8(%rsp), %r9

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C_QUICK
	call	CSYM(hipe_bs_put_big_integer)
	SWITCH_C_TO_ERLANG_QUICK

	/* return */
	NSP_RETN(8)
	SET_SIZE(ASYM(nbif_bs_put_big_integer))
	TYPE_FUNCTION(ASYM(nbif_bs_put_big_integer))
#endif


#ifndef HAVE_nbif_check_get_msg
#define HAVE_nbif_check_get_msg
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_check_get_msg))
ASYM(nbif_check_get_msg):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	call	CSYM(hipe_check_get_msg)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* return */
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_check_get_msg))
	TYPE_FUNCTION(ASYM(nbif_check_get_msg))
#endif

#ifdef NO_FPE_SIGNALS

#ifndef HAVE_nbif_emulate_fpe
#define HAVE_nbif_emulate_fpe
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_emulate_fpe))
ASYM(nbif_emulate_fpe):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C_QUICK
	call	CSYM(hipe_emulate_fpe)
	SWITCH_C_TO_ERLANG_QUICK

	/* return */
	NSP_RET0
	SET_SIZE(ASYM(nbif_emulate_fpe))
	TYPE_FUNCTION(ASYM(nbif_emulate_fpe))
#endif
#endif


#ifndef HAVE_nbif_emasculate_binary
#define HAVE_nbif_emasculate_binary
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_emasculate_binary))
ASYM(nbif_emasculate_binary):
	/* set up the parameters */
	movq	%rsi, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C_QUICK
	call	CSYM(hipe_emasculate_binary)
	SWITCH_C_TO_ERLANG_QUICK

	/* return */
	NSP_RET0
	SET_SIZE(ASYM(nbif_emasculate_binary))
	TYPE_FUNCTION(ASYM(nbif_emasculate_binary))
#endif


#ifndef HAVE_nbif_clear_timeout
#define HAVE_nbif_clear_timeout
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_clear_timeout))
ASYM(nbif_clear_timeout):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C_QUICK
	call	CSYM(hipe_clear_timeout)
	SWITCH_C_TO_ERLANG_QUICK

	/* return */
	NSP_RET0
	SET_SIZE(ASYM(nbif_clear_timeout))
	TYPE_FUNCTION(ASYM(nbif_clear_timeout))
#endif

#ifndef HAVE_nbif_atomic_inc
#define HAVE_nbif_atomic_inc
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_atomic_inc))
ASYM(nbif_atomic_inc):
	/* set up the parameters */
	movq	%rsi, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C_QUICK
	call	CSYM(hipe_atomic_inc)
	SWITCH_C_TO_ERLANG_QUICK

	/* return */
	NSP_RET0
	SET_SIZE(ASYM(nbif_atomic_inc))
	TYPE_FUNCTION(ASYM(nbif_atomic_inc))
#endif

/*
 * BIFs that disable GC while trapping are called via a wrapper
 * to reserve stack space for the "trap frame".
 * They occasionally need to call the garbage collector in order to make room
 * for the trap frame on the BEAM stack.
 */

#ifndef HAVE_nbif_term_to_binary_1
#define HAVE_nbif_term_to_binary_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_term_to_binary_1))
ASYM(nbif_term_to_binary_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(hipe_wrapper_term_to_binary_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_term_to_binary_1))
	TYPE_FUNCTION(ASYM(nbif_term_to_binary_1))
#endif

#ifndef HAVE_nbif_term_to_binary_2
#define HAVE_nbif_term_to_binary_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_term_to_binary_2))
ASYM(nbif_term_to_binary_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(hipe_wrapper_term_to_binary_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_term_to_binary_2))
	TYPE_FUNCTION(ASYM(nbif_term_to_binary_2))
#endif

#ifndef HAVE_nbif_binary_to_term_1
#define HAVE_nbif_binary_to_term_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_binary_to_term_1))
ASYM(nbif_binary_to_term_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(hipe_wrapper_binary_to_term_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_binary_to_term_1))
	TYPE_FUNCTION(ASYM(nbif_binary_to_term_1))
#endif

#ifndef HAVE_nbif_binary_to_term_2
#define HAVE_nbif_binary_to_term_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_binary_to_term_2))
ASYM(nbif_binary_to_term_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(hipe_wrapper_binary_to_term_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_binary_to_term_2))
	TYPE_FUNCTION(ASYM(nbif_binary_to_term_2))
#endif

#ifndef HAVE_nbif_binary_to_list_1
#define HAVE_nbif_binary_to_list_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_binary_to_list_1))
ASYM(nbif_binary_to_list_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(hipe_wrapper_binary_to_list_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_binary_to_list_1))
	TYPE_FUNCTION(ASYM(nbif_binary_to_list_1))
#endif

#ifndef HAVE_nbif_binary_to_list_3
#define HAVE_nbif_binary_to_list_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_binary_to_list_3))
ASYM(nbif_binary_to_list_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(hipe_wrapper_binary_to_list_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_binary_to_list_3))
	TYPE_FUNCTION(ASYM(nbif_binary_to_list_3))
#endif

#ifndef HAVE_nbif_bitstring_to_list_1
#define HAVE_nbif_bitstring_to_list_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_bitstring_to_list_1))
ASYM(nbif_bitstring_to_list_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(hipe_wrapper_bitstring_to_list_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_bitstring_to_list_1))
	TYPE_FUNCTION(ASYM(nbif_bitstring_to_list_1))
#endif

#ifndef HAVE_nbif_list_to_binary_1
#define HAVE_nbif_list_to_binary_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_list_to_binary_1))
ASYM(nbif_list_to_binary_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(hipe_wrapper_list_to_binary_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_list_to_binary_1))
	TYPE_FUNCTION(ASYM(nbif_list_to_binary_1))
#endif

#ifndef HAVE_nbif_iolist_to_binary_1
#define HAVE_nbif_iolist_to_binary_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_iolist_to_binary_1))
ASYM(nbif_iolist_to_binary_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(hipe_wrapper_iolist_to_binary_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_iolist_to_binary_1))
	TYPE_FUNCTION(ASYM(nbif_iolist_to_binary_1))
#endif

#ifndef HAVE_nbif_binary_list_to_bin_1
#define HAVE_nbif_binary_list_to_bin_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_binary_list_to_bin_1))
ASYM(nbif_binary_list_to_bin_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(hipe_wrapper_binary_list_to_bin_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_binary_list_to_bin_1))
	TYPE_FUNCTION(ASYM(nbif_binary_list_to_bin_1))
#endif

#ifndef HAVE_nbif_list_to_bitstring_1
#define HAVE_nbif_list_to_bitstring_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_list_to_bitstring_1))
ASYM(nbif_list_to_bitstring_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(hipe_wrapper_list_to_bitstring_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_list_to_bitstring_1))
	TYPE_FUNCTION(ASYM(nbif_list_to_bitstring_1))
#endif

#ifndef HAVE_nbif_send_2
#define HAVE_nbif_send_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_send_2))
ASYM(nbif_send_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(hipe_wrapper_send_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_send_2))
	TYPE_FUNCTION(ASYM(nbif_send_2))
#endif

#ifndef HAVE_nbif_send_3
#define HAVE_nbif_send_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_send_3))
ASYM(nbif_send_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(hipe_wrapper_send_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_send_3))
	TYPE_FUNCTION(ASYM(nbif_send_3))
#endif

#ifndef HAVE_nbif_ebif_bang_2
#define HAVE_nbif_ebif_bang_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ebif_bang_2))
ASYM(nbif_ebif_bang_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(hipe_wrapper_ebif_bang_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ebif_bang_2))
	TYPE_FUNCTION(ASYM(nbif_ebif_bang_2))
#endif

#ifndef HAVE_nbif_maps_merge_2
#define HAVE_nbif_maps_merge_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_maps_merge_2))
ASYM(nbif_maps_merge_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(hipe_wrapper_maps_merge_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_maps_merge_2))
	TYPE_FUNCTION(ASYM(nbif_maps_merge_2))
#endif


/*
 * Standard BIFs.
 * BIF_LIST(ModuleAtom,FunctionAtom,Arity,CFun,Index)
 */


/*
 *  Warning: Do not edit this file.  It was automatically
 *  generated by 'make_tables' on Fri Jul 10 15:45:19 2020.
 */


#ifndef HAVE_nbif_abs_1
#define HAVE_nbif_abs_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_abs_1))
ASYM(nbif_abs_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(abs_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_abs_1))
	TYPE_FUNCTION(ASYM(nbif_abs_1))
#endif

#ifndef HAVE_nbif_adler32_1
#define HAVE_nbif_adler32_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_adler32_1))
ASYM(nbif_adler32_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(adler32_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_adler32_1))
	TYPE_FUNCTION(ASYM(nbif_adler32_1))
#endif

#ifndef HAVE_nbif_adler32_2
#define HAVE_nbif_adler32_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_adler32_2))
ASYM(nbif_adler32_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(adler32_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_adler32_2))
	TYPE_FUNCTION(ASYM(nbif_adler32_2))
#endif

#ifndef HAVE_nbif_adler32_combine_3
#define HAVE_nbif_adler32_combine_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_adler32_combine_3))
ASYM(nbif_adler32_combine_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(adler32_combine_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_adler32_combine_3))
	TYPE_FUNCTION(ASYM(nbif_adler32_combine_3))
#endif

#ifndef HAVE_nbif_apply_3
#define HAVE_nbif_apply_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_apply_3))
ASYM(nbif_apply_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(apply_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_apply_3))
	TYPE_FUNCTION(ASYM(nbif_apply_3))
#endif

#ifndef HAVE_nbif_atom_to_list_1
#define HAVE_nbif_atom_to_list_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_atom_to_list_1))
ASYM(nbif_atom_to_list_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(atom_to_list_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_atom_to_list_1))
	TYPE_FUNCTION(ASYM(nbif_atom_to_list_1))
#endif

#ifndef HAVE_nbif_binary_to_list_1
#define HAVE_nbif_binary_to_list_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_binary_to_list_1))
ASYM(nbif_binary_to_list_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(binary_to_list_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_binary_to_list_1))
	TYPE_FUNCTION(ASYM(nbif_binary_to_list_1))
#endif

#ifndef HAVE_nbif_binary_to_list_3
#define HAVE_nbif_binary_to_list_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_binary_to_list_3))
ASYM(nbif_binary_to_list_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(binary_to_list_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_binary_to_list_3))
	TYPE_FUNCTION(ASYM(nbif_binary_to_list_3))
#endif

#ifndef HAVE_nbif_binary_to_term_1
#define HAVE_nbif_binary_to_term_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_binary_to_term_1))
ASYM(nbif_binary_to_term_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(binary_to_term_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_binary_to_term_1))
	TYPE_FUNCTION(ASYM(nbif_binary_to_term_1))
#endif

#ifndef HAVE_nbif_crc32_1
#define HAVE_nbif_crc32_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_crc32_1))
ASYM(nbif_crc32_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(crc32_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_crc32_1))
	TYPE_FUNCTION(ASYM(nbif_crc32_1))
#endif

#ifndef HAVE_nbif_crc32_2
#define HAVE_nbif_crc32_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_crc32_2))
ASYM(nbif_crc32_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(crc32_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_crc32_2))
	TYPE_FUNCTION(ASYM(nbif_crc32_2))
#endif

#ifndef HAVE_nbif_crc32_combine_3
#define HAVE_nbif_crc32_combine_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_crc32_combine_3))
ASYM(nbif_crc32_combine_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(crc32_combine_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_crc32_combine_3))
	TYPE_FUNCTION(ASYM(nbif_crc32_combine_3))
#endif

#ifndef HAVE_nbif_date_0
#define HAVE_nbif_date_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_date_0))
ASYM(nbif_date_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(date_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_date_0))
	TYPE_FUNCTION(ASYM(nbif_date_0))
#endif

#ifndef HAVE_nbif_delete_module_1
#define HAVE_nbif_delete_module_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_delete_module_1))
ASYM(nbif_delete_module_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(delete_module_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_delete_module_1))
	TYPE_FUNCTION(ASYM(nbif_delete_module_1))
#endif

#ifndef HAVE_nbif_display_1
#define HAVE_nbif_display_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_display_1))
ASYM(nbif_display_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(display_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_display_1))
	TYPE_FUNCTION(ASYM(nbif_display_1))
#endif

#ifndef HAVE_nbif_display_string_1
#define HAVE_nbif_display_string_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_display_string_1))
ASYM(nbif_display_string_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(display_string_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_display_string_1))
	TYPE_FUNCTION(ASYM(nbif_display_string_1))
#endif

#ifndef HAVE_nbif_display_nl_0
#define HAVE_nbif_display_nl_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_display_nl_0))
ASYM(nbif_display_nl_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(display_nl_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_display_nl_0))
	TYPE_FUNCTION(ASYM(nbif_display_nl_0))
#endif

#ifndef HAVE_nbif_element_2
#define HAVE_nbif_element_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_element_2))
ASYM(nbif_element_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(element_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_element_2))
	TYPE_FUNCTION(ASYM(nbif_element_2))
#endif

#ifndef HAVE_nbif_erase_0
#define HAVE_nbif_erase_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erase_0))
ASYM(nbif_erase_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(erase_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erase_0))
	TYPE_FUNCTION(ASYM(nbif_erase_0))
#endif

#ifndef HAVE_nbif_erase_1
#define HAVE_nbif_erase_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erase_1))
ASYM(nbif_erase_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(erase_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erase_1))
	TYPE_FUNCTION(ASYM(nbif_erase_1))
#endif

#ifndef HAVE_nbif_exit_1
#define HAVE_nbif_exit_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_exit_1))
ASYM(nbif_exit_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(exit_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_exit_1))
	TYPE_FUNCTION(ASYM(nbif_exit_1))
#endif

#ifndef HAVE_nbif_exit_2
#define HAVE_nbif_exit_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_exit_2))
ASYM(nbif_exit_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(exit_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_exit_2))
	TYPE_FUNCTION(ASYM(nbif_exit_2))
#endif

#ifndef HAVE_nbif_exit_signal_2
#define HAVE_nbif_exit_signal_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_exit_signal_2))
ASYM(nbif_exit_signal_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(exit_signal_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_exit_signal_2))
	TYPE_FUNCTION(ASYM(nbif_exit_signal_2))
#endif

#ifndef HAVE_nbif_external_size_1
#define HAVE_nbif_external_size_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_external_size_1))
ASYM(nbif_external_size_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(external_size_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_external_size_1))
	TYPE_FUNCTION(ASYM(nbif_external_size_1))
#endif

#ifndef HAVE_nbif_external_size_2
#define HAVE_nbif_external_size_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_external_size_2))
ASYM(nbif_external_size_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(external_size_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_external_size_2))
	TYPE_FUNCTION(ASYM(nbif_external_size_2))
#endif

#ifndef HAVE_nbif_float_1
#define HAVE_nbif_float_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_float_1))
ASYM(nbif_float_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(float_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_float_1))
	TYPE_FUNCTION(ASYM(nbif_float_1))
#endif

#ifndef HAVE_nbif_float_to_list_1
#define HAVE_nbif_float_to_list_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_float_to_list_1))
ASYM(nbif_float_to_list_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(float_to_list_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_float_to_list_1))
	TYPE_FUNCTION(ASYM(nbif_float_to_list_1))
#endif

#ifndef HAVE_nbif_float_to_list_2
#define HAVE_nbif_float_to_list_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_float_to_list_2))
ASYM(nbif_float_to_list_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(float_to_list_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_float_to_list_2))
	TYPE_FUNCTION(ASYM(nbif_float_to_list_2))
#endif

#ifndef HAVE_nbif_fun_info_2
#define HAVE_nbif_fun_info_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_fun_info_2))
ASYM(nbif_fun_info_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(fun_info_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_fun_info_2))
	TYPE_FUNCTION(ASYM(nbif_fun_info_2))
#endif

#ifndef HAVE_nbif_erts_internal_garbage_collect_1
#define HAVE_nbif_erts_internal_garbage_collect_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_garbage_collect_1))
ASYM(nbif_erts_internal_garbage_collect_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(erts_internal_garbage_collect_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_garbage_collect_1))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_garbage_collect_1))
#endif

#ifndef HAVE_nbif_get_0
#define HAVE_nbif_get_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_get_0))
ASYM(nbif_get_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(get_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_get_0))
	TYPE_FUNCTION(ASYM(nbif_get_0))
#endif

#ifndef HAVE_nbif_get_1
#define HAVE_nbif_get_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_get_1))
ASYM(nbif_get_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(get_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_get_1))
	TYPE_FUNCTION(ASYM(nbif_get_1))
#endif

#ifndef HAVE_nbif_get_keys_1
#define HAVE_nbif_get_keys_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_get_keys_1))
ASYM(nbif_get_keys_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(get_keys_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_get_keys_1))
	TYPE_FUNCTION(ASYM(nbif_get_keys_1))
#endif

#ifndef HAVE_nbif_group_leader_0
#define HAVE_nbif_group_leader_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_group_leader_0))
ASYM(nbif_group_leader_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(group_leader_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_group_leader_0))
	TYPE_FUNCTION(ASYM(nbif_group_leader_0))
#endif

#ifndef HAVE_nbif_erts_internal_group_leader_2
#define HAVE_nbif_erts_internal_group_leader_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_group_leader_2))
ASYM(nbif_erts_internal_group_leader_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(erts_internal_group_leader_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_group_leader_2))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_group_leader_2))
#endif

#ifndef HAVE_nbif_erts_internal_group_leader_3
#define HAVE_nbif_erts_internal_group_leader_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_group_leader_3))
ASYM(nbif_erts_internal_group_leader_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(erts_internal_group_leader_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_group_leader_3))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_group_leader_3))
#endif

#ifndef HAVE_nbif_halt_2
#define HAVE_nbif_halt_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_halt_2))
ASYM(nbif_halt_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(halt_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_halt_2))
	TYPE_FUNCTION(ASYM(nbif_halt_2))
#endif

#ifndef HAVE_nbif_phash_2
#define HAVE_nbif_phash_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_phash_2))
ASYM(nbif_phash_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(phash_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_phash_2))
	TYPE_FUNCTION(ASYM(nbif_phash_2))
#endif

#ifndef HAVE_nbif_phash2_1
#define HAVE_nbif_phash2_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_phash2_1))
ASYM(nbif_phash2_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(phash2_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_phash2_1))
	TYPE_FUNCTION(ASYM(nbif_phash2_1))
#endif

#ifndef HAVE_nbif_phash2_2
#define HAVE_nbif_phash2_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_phash2_2))
ASYM(nbif_phash2_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(phash2_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_phash2_2))
	TYPE_FUNCTION(ASYM(nbif_phash2_2))
#endif

#ifndef HAVE_nbif_hd_1
#define HAVE_nbif_hd_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hd_1))
ASYM(nbif_hd_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(hd_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hd_1))
	TYPE_FUNCTION(ASYM(nbif_hd_1))
#endif

#ifndef HAVE_nbif_integer_to_list_1
#define HAVE_nbif_integer_to_list_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_integer_to_list_1))
ASYM(nbif_integer_to_list_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(integer_to_list_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_integer_to_list_1))
	TYPE_FUNCTION(ASYM(nbif_integer_to_list_1))
#endif

#ifndef HAVE_nbif_is_alive_0
#define HAVE_nbif_is_alive_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_is_alive_0))
ASYM(nbif_is_alive_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(is_alive_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_is_alive_0))
	TYPE_FUNCTION(ASYM(nbif_is_alive_0))
#endif

#ifndef HAVE_nbif_length_1
#define HAVE_nbif_length_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_length_1))
ASYM(nbif_length_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(length_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_length_1))
	TYPE_FUNCTION(ASYM(nbif_length_1))
#endif

#ifndef HAVE_nbif_link_1
#define HAVE_nbif_link_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_link_1))
ASYM(nbif_link_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(link_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_link_1))
	TYPE_FUNCTION(ASYM(nbif_link_1))
#endif

#ifndef HAVE_nbif_list_to_atom_1
#define HAVE_nbif_list_to_atom_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_list_to_atom_1))
ASYM(nbif_list_to_atom_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(list_to_atom_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_list_to_atom_1))
	TYPE_FUNCTION(ASYM(nbif_list_to_atom_1))
#endif

#ifndef HAVE_nbif_list_to_binary_1
#define HAVE_nbif_list_to_binary_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_list_to_binary_1))
ASYM(nbif_list_to_binary_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(list_to_binary_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_list_to_binary_1))
	TYPE_FUNCTION(ASYM(nbif_list_to_binary_1))
#endif

#ifndef HAVE_nbif_list_to_float_1
#define HAVE_nbif_list_to_float_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_list_to_float_1))
ASYM(nbif_list_to_float_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(list_to_float_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_list_to_float_1))
	TYPE_FUNCTION(ASYM(nbif_list_to_float_1))
#endif

#ifndef HAVE_nbif_list_to_integer_1
#define HAVE_nbif_list_to_integer_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_list_to_integer_1))
ASYM(nbif_list_to_integer_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(list_to_integer_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_list_to_integer_1))
	TYPE_FUNCTION(ASYM(nbif_list_to_integer_1))
#endif

#ifndef HAVE_nbif_list_to_pid_1
#define HAVE_nbif_list_to_pid_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_list_to_pid_1))
ASYM(nbif_list_to_pid_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(list_to_pid_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_list_to_pid_1))
	TYPE_FUNCTION(ASYM(nbif_list_to_pid_1))
#endif

#ifndef HAVE_nbif_list_to_port_1
#define HAVE_nbif_list_to_port_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_list_to_port_1))
ASYM(nbif_list_to_port_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(list_to_port_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_list_to_port_1))
	TYPE_FUNCTION(ASYM(nbif_list_to_port_1))
#endif

#ifndef HAVE_nbif_list_to_ref_1
#define HAVE_nbif_list_to_ref_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_list_to_ref_1))
ASYM(nbif_list_to_ref_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(list_to_ref_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_list_to_ref_1))
	TYPE_FUNCTION(ASYM(nbif_list_to_ref_1))
#endif

#ifndef HAVE_nbif_list_to_tuple_1
#define HAVE_nbif_list_to_tuple_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_list_to_tuple_1))
ASYM(nbif_list_to_tuple_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(list_to_tuple_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_list_to_tuple_1))
	TYPE_FUNCTION(ASYM(nbif_list_to_tuple_1))
#endif

#ifndef HAVE_nbif_loaded_0
#define HAVE_nbif_loaded_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_loaded_0))
ASYM(nbif_loaded_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(loaded_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_loaded_0))
	TYPE_FUNCTION(ASYM(nbif_loaded_0))
#endif

#ifndef HAVE_nbif_localtime_0
#define HAVE_nbif_localtime_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_localtime_0))
ASYM(nbif_localtime_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(localtime_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_localtime_0))
	TYPE_FUNCTION(ASYM(nbif_localtime_0))
#endif

#ifndef HAVE_nbif_localtime_to_universaltime_2
#define HAVE_nbif_localtime_to_universaltime_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_localtime_to_universaltime_2))
ASYM(nbif_localtime_to_universaltime_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(localtime_to_universaltime_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_localtime_to_universaltime_2))
	TYPE_FUNCTION(ASYM(nbif_localtime_to_universaltime_2))
#endif

#ifndef HAVE_nbif_make_ref_0
#define HAVE_nbif_make_ref_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_make_ref_0))
ASYM(nbif_make_ref_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(make_ref_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_make_ref_0))
	TYPE_FUNCTION(ASYM(nbif_make_ref_0))
#endif

#ifndef HAVE_nbif_unique_integer_0
#define HAVE_nbif_unique_integer_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_unique_integer_0))
ASYM(nbif_unique_integer_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(unique_integer_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_unique_integer_0))
	TYPE_FUNCTION(ASYM(nbif_unique_integer_0))
#endif

#ifndef HAVE_nbif_unique_integer_1
#define HAVE_nbif_unique_integer_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_unique_integer_1))
ASYM(nbif_unique_integer_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(unique_integer_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_unique_integer_1))
	TYPE_FUNCTION(ASYM(nbif_unique_integer_1))
#endif

#ifndef HAVE_nbif_md5_1
#define HAVE_nbif_md5_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_md5_1))
ASYM(nbif_md5_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(md5_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_md5_1))
	TYPE_FUNCTION(ASYM(nbif_md5_1))
#endif

#ifndef HAVE_nbif_md5_init_0
#define HAVE_nbif_md5_init_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_md5_init_0))
ASYM(nbif_md5_init_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(md5_init_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_md5_init_0))
	TYPE_FUNCTION(ASYM(nbif_md5_init_0))
#endif

#ifndef HAVE_nbif_md5_update_2
#define HAVE_nbif_md5_update_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_md5_update_2))
ASYM(nbif_md5_update_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(md5_update_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_md5_update_2))
	TYPE_FUNCTION(ASYM(nbif_md5_update_2))
#endif

#ifndef HAVE_nbif_md5_final_1
#define HAVE_nbif_md5_final_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_md5_final_1))
ASYM(nbif_md5_final_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(md5_final_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_md5_final_1))
	TYPE_FUNCTION(ASYM(nbif_md5_final_1))
#endif

#ifndef HAVE_nbif_module_loaded_1
#define HAVE_nbif_module_loaded_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_module_loaded_1))
ASYM(nbif_module_loaded_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(module_loaded_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_module_loaded_1))
	TYPE_FUNCTION(ASYM(nbif_module_loaded_1))
#endif

#ifndef HAVE_nbif_function_exported_3
#define HAVE_nbif_function_exported_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_function_exported_3))
ASYM(nbif_function_exported_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(function_exported_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_function_exported_3))
	TYPE_FUNCTION(ASYM(nbif_function_exported_3))
#endif

#ifndef HAVE_nbif_monitor_node_2
#define HAVE_nbif_monitor_node_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_monitor_node_2))
ASYM(nbif_monitor_node_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(monitor_node_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_monitor_node_2))
	TYPE_FUNCTION(ASYM(nbif_monitor_node_2))
#endif

#ifndef HAVE_nbif_monitor_node_3
#define HAVE_nbif_monitor_node_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_monitor_node_3))
ASYM(nbif_monitor_node_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(monitor_node_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_monitor_node_3))
	TYPE_FUNCTION(ASYM(nbif_monitor_node_3))
#endif

#ifndef HAVE_nbif_node_1
#define HAVE_nbif_node_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_node_1))
ASYM(nbif_node_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(node_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_node_1))
	TYPE_FUNCTION(ASYM(nbif_node_1))
#endif

#ifndef HAVE_nbif_node_0
#define HAVE_nbif_node_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_node_0))
ASYM(nbif_node_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(node_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_node_0))
	TYPE_FUNCTION(ASYM(nbif_node_0))
#endif

#ifndef HAVE_nbif_nodes_1
#define HAVE_nbif_nodes_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_nodes_1))
ASYM(nbif_nodes_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(nodes_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_nodes_1))
	TYPE_FUNCTION(ASYM(nbif_nodes_1))
#endif

#ifndef HAVE_nbif_now_0
#define HAVE_nbif_now_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_now_0))
ASYM(nbif_now_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(now_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_now_0))
	TYPE_FUNCTION(ASYM(nbif_now_0))
#endif

#ifndef HAVE_nbif_monotonic_time_0
#define HAVE_nbif_monotonic_time_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_monotonic_time_0))
ASYM(nbif_monotonic_time_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(monotonic_time_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_monotonic_time_0))
	TYPE_FUNCTION(ASYM(nbif_monotonic_time_0))
#endif

#ifndef HAVE_nbif_monotonic_time_1
#define HAVE_nbif_monotonic_time_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_monotonic_time_1))
ASYM(nbif_monotonic_time_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(monotonic_time_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_monotonic_time_1))
	TYPE_FUNCTION(ASYM(nbif_monotonic_time_1))
#endif

#ifndef HAVE_nbif_system_time_0
#define HAVE_nbif_system_time_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_system_time_0))
ASYM(nbif_system_time_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(system_time_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_system_time_0))
	TYPE_FUNCTION(ASYM(nbif_system_time_0))
#endif

#ifndef HAVE_nbif_system_time_1
#define HAVE_nbif_system_time_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_system_time_1))
ASYM(nbif_system_time_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(system_time_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_system_time_1))
	TYPE_FUNCTION(ASYM(nbif_system_time_1))
#endif

#ifndef HAVE_nbif_time_offset_0
#define HAVE_nbif_time_offset_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_time_offset_0))
ASYM(nbif_time_offset_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(time_offset_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_time_offset_0))
	TYPE_FUNCTION(ASYM(nbif_time_offset_0))
#endif

#ifndef HAVE_nbif_time_offset_1
#define HAVE_nbif_time_offset_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_time_offset_1))
ASYM(nbif_time_offset_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(time_offset_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_time_offset_1))
	TYPE_FUNCTION(ASYM(nbif_time_offset_1))
#endif

#ifndef HAVE_nbif_timestamp_0
#define HAVE_nbif_timestamp_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_timestamp_0))
ASYM(nbif_timestamp_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(timestamp_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_timestamp_0))
	TYPE_FUNCTION(ASYM(nbif_timestamp_0))
#endif

#ifndef HAVE_nbif_erts_internal_open_port_2
#define HAVE_nbif_erts_internal_open_port_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_open_port_2))
ASYM(nbif_erts_internal_open_port_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(erts_internal_open_port_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_open_port_2))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_open_port_2))
#endif

#ifndef HAVE_nbif_pid_to_list_1
#define HAVE_nbif_pid_to_list_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_pid_to_list_1))
ASYM(nbif_pid_to_list_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(pid_to_list_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_pid_to_list_1))
	TYPE_FUNCTION(ASYM(nbif_pid_to_list_1))
#endif

#ifndef HAVE_nbif_ports_0
#define HAVE_nbif_ports_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ports_0))
ASYM(nbif_ports_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(ports_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ports_0))
	TYPE_FUNCTION(ASYM(nbif_ports_0))
#endif

#ifndef HAVE_nbif_pre_loaded_0
#define HAVE_nbif_pre_loaded_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_pre_loaded_0))
ASYM(nbif_pre_loaded_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(pre_loaded_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_pre_loaded_0))
	TYPE_FUNCTION(ASYM(nbif_pre_loaded_0))
#endif

#ifndef HAVE_nbif_process_flag_2
#define HAVE_nbif_process_flag_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_process_flag_2))
ASYM(nbif_process_flag_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(process_flag_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_process_flag_2))
	TYPE_FUNCTION(ASYM(nbif_process_flag_2))
#endif

#ifndef HAVE_nbif_erts_internal_process_flag_3
#define HAVE_nbif_erts_internal_process_flag_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_process_flag_3))
ASYM(nbif_erts_internal_process_flag_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(erts_internal_process_flag_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_process_flag_3))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_process_flag_3))
#endif

#ifndef HAVE_nbif_process_info_1
#define HAVE_nbif_process_info_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_process_info_1))
ASYM(nbif_process_info_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(process_info_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_process_info_1))
	TYPE_FUNCTION(ASYM(nbif_process_info_1))
#endif

#ifndef HAVE_nbif_process_info_2
#define HAVE_nbif_process_info_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_process_info_2))
ASYM(nbif_process_info_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(process_info_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_process_info_2))
	TYPE_FUNCTION(ASYM(nbif_process_info_2))
#endif

#ifndef HAVE_nbif_processes_0
#define HAVE_nbif_processes_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_processes_0))
ASYM(nbif_processes_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(processes_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_processes_0))
	TYPE_FUNCTION(ASYM(nbif_processes_0))
#endif

#ifndef HAVE_nbif_put_2
#define HAVE_nbif_put_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_put_2))
ASYM(nbif_put_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(put_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_put_2))
	TYPE_FUNCTION(ASYM(nbif_put_2))
#endif

#ifndef HAVE_nbif_register_2
#define HAVE_nbif_register_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_register_2))
ASYM(nbif_register_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(register_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_register_2))
	TYPE_FUNCTION(ASYM(nbif_register_2))
#endif

#ifndef HAVE_nbif_registered_0
#define HAVE_nbif_registered_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_registered_0))
ASYM(nbif_registered_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(registered_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_registered_0))
	TYPE_FUNCTION(ASYM(nbif_registered_0))
#endif

#ifndef HAVE_nbif_round_1
#define HAVE_nbif_round_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_round_1))
ASYM(nbif_round_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(round_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_round_1))
	TYPE_FUNCTION(ASYM(nbif_round_1))
#endif

#ifndef HAVE_nbif_self_0
#define HAVE_nbif_self_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_self_0))
ASYM(nbif_self_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(self_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_self_0))
	TYPE_FUNCTION(ASYM(nbif_self_0))
#endif

#ifndef HAVE_nbif_setelement_3
#define HAVE_nbif_setelement_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_setelement_3))
ASYM(nbif_setelement_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(setelement_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_setelement_3))
	TYPE_FUNCTION(ASYM(nbif_setelement_3))
#endif

#ifndef HAVE_nbif_size_1
#define HAVE_nbif_size_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_size_1))
ASYM(nbif_size_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(size_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_size_1))
	TYPE_FUNCTION(ASYM(nbif_size_1))
#endif

#ifndef HAVE_nbif_spawn_3
#define HAVE_nbif_spawn_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_spawn_3))
ASYM(nbif_spawn_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(spawn_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_spawn_3))
	TYPE_FUNCTION(ASYM(nbif_spawn_3))
#endif

#ifndef HAVE_nbif_spawn_link_3
#define HAVE_nbif_spawn_link_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_spawn_link_3))
ASYM(nbif_spawn_link_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(spawn_link_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_spawn_link_3))
	TYPE_FUNCTION(ASYM(nbif_spawn_link_3))
#endif

#ifndef HAVE_nbif_split_binary_2
#define HAVE_nbif_split_binary_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_split_binary_2))
ASYM(nbif_split_binary_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(split_binary_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_split_binary_2))
	TYPE_FUNCTION(ASYM(nbif_split_binary_2))
#endif

#ifndef HAVE_nbif_statistics_1
#define HAVE_nbif_statistics_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_statistics_1))
ASYM(nbif_statistics_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(statistics_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_statistics_1))
	TYPE_FUNCTION(ASYM(nbif_statistics_1))
#endif

#ifndef HAVE_nbif_term_to_binary_1
#define HAVE_nbif_term_to_binary_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_term_to_binary_1))
ASYM(nbif_term_to_binary_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(term_to_binary_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_term_to_binary_1))
	TYPE_FUNCTION(ASYM(nbif_term_to_binary_1))
#endif

#ifndef HAVE_nbif_term_to_binary_2
#define HAVE_nbif_term_to_binary_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_term_to_binary_2))
ASYM(nbif_term_to_binary_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(term_to_binary_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_term_to_binary_2))
	TYPE_FUNCTION(ASYM(nbif_term_to_binary_2))
#endif

#ifndef HAVE_nbif_throw_1
#define HAVE_nbif_throw_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_throw_1))
ASYM(nbif_throw_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(throw_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_throw_1))
	TYPE_FUNCTION(ASYM(nbif_throw_1))
#endif

#ifndef HAVE_nbif_time_0
#define HAVE_nbif_time_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_time_0))
ASYM(nbif_time_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(time_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_time_0))
	TYPE_FUNCTION(ASYM(nbif_time_0))
#endif

#ifndef HAVE_nbif_tl_1
#define HAVE_nbif_tl_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_tl_1))
ASYM(nbif_tl_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(tl_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_tl_1))
	TYPE_FUNCTION(ASYM(nbif_tl_1))
#endif

#ifndef HAVE_nbif_trunc_1
#define HAVE_nbif_trunc_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_trunc_1))
ASYM(nbif_trunc_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(trunc_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_trunc_1))
	TYPE_FUNCTION(ASYM(nbif_trunc_1))
#endif

#ifndef HAVE_nbif_tuple_to_list_1
#define HAVE_nbif_tuple_to_list_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_tuple_to_list_1))
ASYM(nbif_tuple_to_list_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(tuple_to_list_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_tuple_to_list_1))
	TYPE_FUNCTION(ASYM(nbif_tuple_to_list_1))
#endif

#ifndef HAVE_nbif_universaltime_0
#define HAVE_nbif_universaltime_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_universaltime_0))
ASYM(nbif_universaltime_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(universaltime_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_universaltime_0))
	TYPE_FUNCTION(ASYM(nbif_universaltime_0))
#endif

#ifndef HAVE_nbif_universaltime_to_localtime_1
#define HAVE_nbif_universaltime_to_localtime_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_universaltime_to_localtime_1))
ASYM(nbif_universaltime_to_localtime_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(universaltime_to_localtime_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_universaltime_to_localtime_1))
	TYPE_FUNCTION(ASYM(nbif_universaltime_to_localtime_1))
#endif

#ifndef HAVE_nbif_unlink_1
#define HAVE_nbif_unlink_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_unlink_1))
ASYM(nbif_unlink_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(unlink_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_unlink_1))
	TYPE_FUNCTION(ASYM(nbif_unlink_1))
#endif

#ifndef HAVE_nbif_unregister_1
#define HAVE_nbif_unregister_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_unregister_1))
ASYM(nbif_unregister_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(unregister_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_unregister_1))
	TYPE_FUNCTION(ASYM(nbif_unregister_1))
#endif

#ifndef HAVE_nbif_whereis_1
#define HAVE_nbif_whereis_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_whereis_1))
ASYM(nbif_whereis_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(whereis_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_whereis_1))
	TYPE_FUNCTION(ASYM(nbif_whereis_1))
#endif

#ifndef HAVE_nbif_spawn_opt_1
#define HAVE_nbif_spawn_opt_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_spawn_opt_1))
ASYM(nbif_spawn_opt_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(spawn_opt_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_spawn_opt_1))
	TYPE_FUNCTION(ASYM(nbif_spawn_opt_1))
#endif

#ifndef HAVE_nbif_setnode_2
#define HAVE_nbif_setnode_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_setnode_2))
ASYM(nbif_setnode_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(setnode_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_setnode_2))
	TYPE_FUNCTION(ASYM(nbif_setnode_2))
#endif

#ifndef HAVE_nbif_dist_get_stat_1
#define HAVE_nbif_dist_get_stat_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_dist_get_stat_1))
ASYM(nbif_dist_get_stat_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(dist_get_stat_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_dist_get_stat_1))
	TYPE_FUNCTION(ASYM(nbif_dist_get_stat_1))
#endif

#ifndef HAVE_nbif_dist_ctrl_input_handler_2
#define HAVE_nbif_dist_ctrl_input_handler_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_dist_ctrl_input_handler_2))
ASYM(nbif_dist_ctrl_input_handler_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(dist_ctrl_input_handler_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_dist_ctrl_input_handler_2))
	TYPE_FUNCTION(ASYM(nbif_dist_ctrl_input_handler_2))
#endif

#ifndef HAVE_nbif_dist_ctrl_put_data_2
#define HAVE_nbif_dist_ctrl_put_data_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_dist_ctrl_put_data_2))
ASYM(nbif_dist_ctrl_put_data_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(dist_ctrl_put_data_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_dist_ctrl_put_data_2))
	TYPE_FUNCTION(ASYM(nbif_dist_ctrl_put_data_2))
#endif

#ifndef HAVE_nbif_dist_ctrl_get_data_1
#define HAVE_nbif_dist_ctrl_get_data_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_dist_ctrl_get_data_1))
ASYM(nbif_dist_ctrl_get_data_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(dist_ctrl_get_data_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_dist_ctrl_get_data_1))
	TYPE_FUNCTION(ASYM(nbif_dist_ctrl_get_data_1))
#endif

#ifndef HAVE_nbif_dist_ctrl_get_data_notification_1
#define HAVE_nbif_dist_ctrl_get_data_notification_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_dist_ctrl_get_data_notification_1))
ASYM(nbif_dist_ctrl_get_data_notification_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(dist_ctrl_get_data_notification_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_dist_ctrl_get_data_notification_1))
	TYPE_FUNCTION(ASYM(nbif_dist_ctrl_get_data_notification_1))
#endif

#ifndef HAVE_nbif_dist_ctrl_get_opt_2
#define HAVE_nbif_dist_ctrl_get_opt_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_dist_ctrl_get_opt_2))
ASYM(nbif_dist_ctrl_get_opt_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(dist_ctrl_get_opt_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_dist_ctrl_get_opt_2))
	TYPE_FUNCTION(ASYM(nbif_dist_ctrl_get_opt_2))
#endif

#ifndef HAVE_nbif_dist_ctrl_set_opt_3
#define HAVE_nbif_dist_ctrl_set_opt_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_dist_ctrl_set_opt_3))
ASYM(nbif_dist_ctrl_set_opt_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(dist_ctrl_set_opt_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_dist_ctrl_set_opt_3))
	TYPE_FUNCTION(ASYM(nbif_dist_ctrl_set_opt_3))
#endif

#ifndef HAVE_nbif_erts_internal_port_info_1
#define HAVE_nbif_erts_internal_port_info_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_port_info_1))
ASYM(nbif_erts_internal_port_info_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(erts_internal_port_info_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_port_info_1))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_port_info_1))
#endif

#ifndef HAVE_nbif_erts_internal_port_info_2
#define HAVE_nbif_erts_internal_port_info_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_port_info_2))
ASYM(nbif_erts_internal_port_info_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(erts_internal_port_info_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_port_info_2))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_port_info_2))
#endif

#ifndef HAVE_nbif_erts_internal_port_call_3
#define HAVE_nbif_erts_internal_port_call_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_port_call_3))
ASYM(nbif_erts_internal_port_call_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(erts_internal_port_call_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_port_call_3))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_port_call_3))
#endif

#ifndef HAVE_nbif_erts_internal_port_command_3
#define HAVE_nbif_erts_internal_port_command_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_port_command_3))
ASYM(nbif_erts_internal_port_command_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(erts_internal_port_command_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_port_command_3))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_port_command_3))
#endif

#ifndef HAVE_nbif_erts_internal_port_control_3
#define HAVE_nbif_erts_internal_port_control_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_port_control_3))
ASYM(nbif_erts_internal_port_control_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(erts_internal_port_control_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_port_control_3))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_port_control_3))
#endif

#ifndef HAVE_nbif_erts_internal_port_close_1
#define HAVE_nbif_erts_internal_port_close_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_port_close_1))
ASYM(nbif_erts_internal_port_close_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(erts_internal_port_close_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_port_close_1))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_port_close_1))
#endif

#ifndef HAVE_nbif_erts_internal_port_connect_2
#define HAVE_nbif_erts_internal_port_connect_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_port_connect_2))
ASYM(nbif_erts_internal_port_connect_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(erts_internal_port_connect_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_port_connect_2))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_port_connect_2))
#endif

#ifndef HAVE_nbif_erts_internal_request_system_task_3
#define HAVE_nbif_erts_internal_request_system_task_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_request_system_task_3))
ASYM(nbif_erts_internal_request_system_task_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(erts_internal_request_system_task_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_request_system_task_3))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_request_system_task_3))
#endif

#ifndef HAVE_nbif_erts_internal_request_system_task_4
#define HAVE_nbif_erts_internal_request_system_task_4
	TEXT
	.align  4
	GLOBAL(ASYM(nbif_erts_internal_request_system_task_4))
ASYM(nbif_erts_internal_request_system_task_4):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx
	# movq	%r8, %r8

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%r8
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(erts_internal_request_system_task_4)
	add	$(4*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_4_simple_exception
	NSP_RET0
	
3:	call nbif_4_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_request_system_task_4))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_request_system_task_4))
#endif

#ifndef HAVE_nbif_erts_internal_check_process_code_1
#define HAVE_nbif_erts_internal_check_process_code_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_check_process_code_1))
ASYM(nbif_erts_internal_check_process_code_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(erts_internal_check_process_code_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_check_process_code_1))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_check_process_code_1))
#endif

#ifndef HAVE_nbif_erts_internal_map_to_tuple_keys_1
#define HAVE_nbif_erts_internal_map_to_tuple_keys_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_map_to_tuple_keys_1))
ASYM(nbif_erts_internal_map_to_tuple_keys_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(erts_internal_map_to_tuple_keys_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_map_to_tuple_keys_1))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_map_to_tuple_keys_1))
#endif

#ifndef HAVE_nbif_erts_internal_term_type_1
#define HAVE_nbif_erts_internal_term_type_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_term_type_1))
ASYM(nbif_erts_internal_term_type_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(erts_internal_term_type_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_term_type_1))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_term_type_1))
#endif

#ifndef HAVE_nbif_erts_internal_map_hashmap_children_1
#define HAVE_nbif_erts_internal_map_hashmap_children_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_map_hashmap_children_1))
ASYM(nbif_erts_internal_map_hashmap_children_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(erts_internal_map_hashmap_children_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_map_hashmap_children_1))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_map_hashmap_children_1))
#endif

#ifndef HAVE_nbif_erts_internal_time_unit_0
#define HAVE_nbif_erts_internal_time_unit_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_time_unit_0))
ASYM(nbif_erts_internal_time_unit_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(erts_internal_time_unit_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_time_unit_0))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_time_unit_0))
#endif

#ifndef HAVE_nbif_erts_internal_perf_counter_unit_0
#define HAVE_nbif_erts_internal_perf_counter_unit_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_perf_counter_unit_0))
ASYM(nbif_erts_internal_perf_counter_unit_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(erts_internal_perf_counter_unit_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_perf_counter_unit_0))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_perf_counter_unit_0))
#endif

#ifndef HAVE_nbif_erts_internal_is_system_process_1
#define HAVE_nbif_erts_internal_is_system_process_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_is_system_process_1))
ASYM(nbif_erts_internal_is_system_process_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(erts_internal_is_system_process_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_is_system_process_1))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_is_system_process_1))
#endif

#ifndef HAVE_nbif_erts_internal_system_check_1
#define HAVE_nbif_erts_internal_system_check_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_system_check_1))
ASYM(nbif_erts_internal_system_check_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(erts_internal_system_check_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_system_check_1))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_system_check_1))
#endif

#ifndef HAVE_nbif_erts_internal_release_literal_area_switch_0
#define HAVE_nbif_erts_internal_release_literal_area_switch_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_release_literal_area_switch_0))
ASYM(nbif_erts_internal_release_literal_area_switch_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(erts_internal_release_literal_area_switch_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_release_literal_area_switch_0))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_release_literal_area_switch_0))
#endif

#ifndef HAVE_nbif_erts_internal_scheduler_wall_time_1
#define HAVE_nbif_erts_internal_scheduler_wall_time_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_scheduler_wall_time_1))
ASYM(nbif_erts_internal_scheduler_wall_time_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(erts_internal_scheduler_wall_time_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_scheduler_wall_time_1))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_scheduler_wall_time_1))
#endif

#ifndef HAVE_nbif_erts_internal_dirty_process_handle_signals_1
#define HAVE_nbif_erts_internal_dirty_process_handle_signals_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_dirty_process_handle_signals_1))
ASYM(nbif_erts_internal_dirty_process_handle_signals_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(erts_internal_dirty_process_handle_signals_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_dirty_process_handle_signals_1))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_dirty_process_handle_signals_1))
#endif

#ifndef HAVE_nbif_erts_internal_create_dist_channel_4
#define HAVE_nbif_erts_internal_create_dist_channel_4
	TEXT
	.align  4
	GLOBAL(ASYM(nbif_erts_internal_create_dist_channel_4))
ASYM(nbif_erts_internal_create_dist_channel_4):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx
	# movq	%r8, %r8

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%r8
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(erts_internal_create_dist_channel_4)
	add	$(4*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_4_simple_exception
	NSP_RET0
	
3:	call nbif_4_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_create_dist_channel_4))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_create_dist_channel_4))
#endif

#ifndef HAVE_nbif_erts_internal_ets_super_user_1
#define HAVE_nbif_erts_internal_ets_super_user_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_ets_super_user_1))
ASYM(nbif_erts_internal_ets_super_user_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(erts_internal_ets_super_user_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_ets_super_user_1))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_ets_super_user_1))
#endif

#ifndef HAVE_nbif_port_set_data_2
#define HAVE_nbif_port_set_data_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_port_set_data_2))
ASYM(nbif_port_set_data_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(port_set_data_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_port_set_data_2))
	TYPE_FUNCTION(ASYM(nbif_port_set_data_2))
#endif

#ifndef HAVE_nbif_port_get_data_1
#define HAVE_nbif_port_get_data_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_port_get_data_1))
ASYM(nbif_port_get_data_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(port_get_data_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_port_get_data_1))
	TYPE_FUNCTION(ASYM(nbif_port_get_data_1))
#endif

#ifndef HAVE_nbif_erts_internal_trace_pattern_3
#define HAVE_nbif_erts_internal_trace_pattern_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_trace_pattern_3))
ASYM(nbif_erts_internal_trace_pattern_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(erts_internal_trace_pattern_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_trace_pattern_3))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_trace_pattern_3))
#endif

#ifndef HAVE_nbif_erts_internal_trace_3
#define HAVE_nbif_erts_internal_trace_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_trace_3))
ASYM(nbif_erts_internal_trace_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(erts_internal_trace_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_trace_3))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_trace_3))
#endif

#ifndef HAVE_nbif_trace_info_2
#define HAVE_nbif_trace_info_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_trace_info_2))
ASYM(nbif_trace_info_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(trace_info_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_trace_info_2))
	TYPE_FUNCTION(ASYM(nbif_trace_info_2))
#endif

#ifndef HAVE_nbif_trace_delivered_1
#define HAVE_nbif_trace_delivered_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_trace_delivered_1))
ASYM(nbif_trace_delivered_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(trace_delivered_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_trace_delivered_1))
	TYPE_FUNCTION(ASYM(nbif_trace_delivered_1))
#endif

#ifndef HAVE_nbif_seq_trace_2
#define HAVE_nbif_seq_trace_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_seq_trace_2))
ASYM(nbif_seq_trace_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(seq_trace_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_seq_trace_2))
	TYPE_FUNCTION(ASYM(nbif_seq_trace_2))
#endif

#ifndef HAVE_nbif_seq_trace_info_1
#define HAVE_nbif_seq_trace_info_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_seq_trace_info_1))
ASYM(nbif_seq_trace_info_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(seq_trace_info_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_seq_trace_info_1))
	TYPE_FUNCTION(ASYM(nbif_seq_trace_info_1))
#endif

#ifndef HAVE_nbif_seq_trace_print_1
#define HAVE_nbif_seq_trace_print_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_seq_trace_print_1))
ASYM(nbif_seq_trace_print_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(seq_trace_print_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_seq_trace_print_1))
	TYPE_FUNCTION(ASYM(nbif_seq_trace_print_1))
#endif

#ifndef HAVE_nbif_seq_trace_print_2
#define HAVE_nbif_seq_trace_print_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_seq_trace_print_2))
ASYM(nbif_seq_trace_print_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(seq_trace_print_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_seq_trace_print_2))
	TYPE_FUNCTION(ASYM(nbif_seq_trace_print_2))
#endif

#ifndef HAVE_nbif_erts_internal_suspend_process_2
#define HAVE_nbif_erts_internal_suspend_process_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_suspend_process_2))
ASYM(nbif_erts_internal_suspend_process_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(erts_internal_suspend_process_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_suspend_process_2))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_suspend_process_2))
#endif

#ifndef HAVE_nbif_resume_process_1
#define HAVE_nbif_resume_process_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_resume_process_1))
ASYM(nbif_resume_process_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(resume_process_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_resume_process_1))
	TYPE_FUNCTION(ASYM(nbif_resume_process_1))
#endif

#ifndef HAVE_nbif_erts_internal_process_display_2
#define HAVE_nbif_erts_internal_process_display_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_process_display_2))
ASYM(nbif_erts_internal_process_display_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(erts_internal_process_display_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_process_display_2))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_process_display_2))
#endif

#ifndef HAVE_nbif_bump_reductions_1
#define HAVE_nbif_bump_reductions_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_bump_reductions_1))
ASYM(nbif_bump_reductions_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(bump_reductions_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_bump_reductions_1))
	TYPE_FUNCTION(ASYM(nbif_bump_reductions_1))
#endif

#ifndef HAVE_nbif_math_cos_1
#define HAVE_nbif_math_cos_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_math_cos_1))
ASYM(nbif_math_cos_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(math_cos_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_math_cos_1))
	TYPE_FUNCTION(ASYM(nbif_math_cos_1))
#endif

#ifndef HAVE_nbif_math_cosh_1
#define HAVE_nbif_math_cosh_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_math_cosh_1))
ASYM(nbif_math_cosh_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(math_cosh_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_math_cosh_1))
	TYPE_FUNCTION(ASYM(nbif_math_cosh_1))
#endif

#ifndef HAVE_nbif_math_sin_1
#define HAVE_nbif_math_sin_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_math_sin_1))
ASYM(nbif_math_sin_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(math_sin_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_math_sin_1))
	TYPE_FUNCTION(ASYM(nbif_math_sin_1))
#endif

#ifndef HAVE_nbif_math_sinh_1
#define HAVE_nbif_math_sinh_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_math_sinh_1))
ASYM(nbif_math_sinh_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(math_sinh_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_math_sinh_1))
	TYPE_FUNCTION(ASYM(nbif_math_sinh_1))
#endif

#ifndef HAVE_nbif_math_tan_1
#define HAVE_nbif_math_tan_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_math_tan_1))
ASYM(nbif_math_tan_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(math_tan_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_math_tan_1))
	TYPE_FUNCTION(ASYM(nbif_math_tan_1))
#endif

#ifndef HAVE_nbif_math_tanh_1
#define HAVE_nbif_math_tanh_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_math_tanh_1))
ASYM(nbif_math_tanh_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(math_tanh_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_math_tanh_1))
	TYPE_FUNCTION(ASYM(nbif_math_tanh_1))
#endif

#ifndef HAVE_nbif_math_acos_1
#define HAVE_nbif_math_acos_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_math_acos_1))
ASYM(nbif_math_acos_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(math_acos_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_math_acos_1))
	TYPE_FUNCTION(ASYM(nbif_math_acos_1))
#endif

#ifndef HAVE_nbif_math_acosh_1
#define HAVE_nbif_math_acosh_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_math_acosh_1))
ASYM(nbif_math_acosh_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(math_acosh_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_math_acosh_1))
	TYPE_FUNCTION(ASYM(nbif_math_acosh_1))
#endif

#ifndef HAVE_nbif_math_asin_1
#define HAVE_nbif_math_asin_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_math_asin_1))
ASYM(nbif_math_asin_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(math_asin_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_math_asin_1))
	TYPE_FUNCTION(ASYM(nbif_math_asin_1))
#endif

#ifndef HAVE_nbif_math_asinh_1
#define HAVE_nbif_math_asinh_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_math_asinh_1))
ASYM(nbif_math_asinh_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(math_asinh_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_math_asinh_1))
	TYPE_FUNCTION(ASYM(nbif_math_asinh_1))
#endif

#ifndef HAVE_nbif_math_atan_1
#define HAVE_nbif_math_atan_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_math_atan_1))
ASYM(nbif_math_atan_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(math_atan_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_math_atan_1))
	TYPE_FUNCTION(ASYM(nbif_math_atan_1))
#endif

#ifndef HAVE_nbif_math_atanh_1
#define HAVE_nbif_math_atanh_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_math_atanh_1))
ASYM(nbif_math_atanh_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(math_atanh_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_math_atanh_1))
	TYPE_FUNCTION(ASYM(nbif_math_atanh_1))
#endif

#ifndef HAVE_nbif_math_erf_1
#define HAVE_nbif_math_erf_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_math_erf_1))
ASYM(nbif_math_erf_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(math_erf_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_math_erf_1))
	TYPE_FUNCTION(ASYM(nbif_math_erf_1))
#endif

#ifndef HAVE_nbif_math_erfc_1
#define HAVE_nbif_math_erfc_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_math_erfc_1))
ASYM(nbif_math_erfc_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(math_erfc_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_math_erfc_1))
	TYPE_FUNCTION(ASYM(nbif_math_erfc_1))
#endif

#ifndef HAVE_nbif_math_exp_1
#define HAVE_nbif_math_exp_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_math_exp_1))
ASYM(nbif_math_exp_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(math_exp_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_math_exp_1))
	TYPE_FUNCTION(ASYM(nbif_math_exp_1))
#endif

#ifndef HAVE_nbif_math_log_1
#define HAVE_nbif_math_log_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_math_log_1))
ASYM(nbif_math_log_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(math_log_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_math_log_1))
	TYPE_FUNCTION(ASYM(nbif_math_log_1))
#endif

#ifndef HAVE_nbif_math_log2_1
#define HAVE_nbif_math_log2_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_math_log2_1))
ASYM(nbif_math_log2_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(math_log2_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_math_log2_1))
	TYPE_FUNCTION(ASYM(nbif_math_log2_1))
#endif

#ifndef HAVE_nbif_math_log10_1
#define HAVE_nbif_math_log10_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_math_log10_1))
ASYM(nbif_math_log10_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(math_log10_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_math_log10_1))
	TYPE_FUNCTION(ASYM(nbif_math_log10_1))
#endif

#ifndef HAVE_nbif_math_sqrt_1
#define HAVE_nbif_math_sqrt_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_math_sqrt_1))
ASYM(nbif_math_sqrt_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(math_sqrt_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_math_sqrt_1))
	TYPE_FUNCTION(ASYM(nbif_math_sqrt_1))
#endif

#ifndef HAVE_nbif_math_atan2_2
#define HAVE_nbif_math_atan2_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_math_atan2_2))
ASYM(nbif_math_atan2_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(math_atan2_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_math_atan2_2))
	TYPE_FUNCTION(ASYM(nbif_math_atan2_2))
#endif

#ifndef HAVE_nbif_math_pow_2
#define HAVE_nbif_math_pow_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_math_pow_2))
ASYM(nbif_math_pow_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(math_pow_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_math_pow_2))
	TYPE_FUNCTION(ASYM(nbif_math_pow_2))
#endif

#ifndef HAVE_nbif_start_timer_3
#define HAVE_nbif_start_timer_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_start_timer_3))
ASYM(nbif_start_timer_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(start_timer_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_start_timer_3))
	TYPE_FUNCTION(ASYM(nbif_start_timer_3))
#endif

#ifndef HAVE_nbif_start_timer_4
#define HAVE_nbif_start_timer_4
	TEXT
	.align  4
	GLOBAL(ASYM(nbif_start_timer_4))
ASYM(nbif_start_timer_4):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx
	# movq	%r8, %r8

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%r8
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(start_timer_4)
	add	$(4*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_4_simple_exception
	NSP_RET0
	
3:	call nbif_4_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_start_timer_4))
	TYPE_FUNCTION(ASYM(nbif_start_timer_4))
#endif

#ifndef HAVE_nbif_send_after_3
#define HAVE_nbif_send_after_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_send_after_3))
ASYM(nbif_send_after_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(send_after_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_send_after_3))
	TYPE_FUNCTION(ASYM(nbif_send_after_3))
#endif

#ifndef HAVE_nbif_send_after_4
#define HAVE_nbif_send_after_4
	TEXT
	.align  4
	GLOBAL(ASYM(nbif_send_after_4))
ASYM(nbif_send_after_4):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx
	# movq	%r8, %r8

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%r8
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(send_after_4)
	add	$(4*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_4_simple_exception
	NSP_RET0
	
3:	call nbif_4_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_send_after_4))
	TYPE_FUNCTION(ASYM(nbif_send_after_4))
#endif

#ifndef HAVE_nbif_cancel_timer_1
#define HAVE_nbif_cancel_timer_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_cancel_timer_1))
ASYM(nbif_cancel_timer_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(cancel_timer_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_cancel_timer_1))
	TYPE_FUNCTION(ASYM(nbif_cancel_timer_1))
#endif

#ifndef HAVE_nbif_cancel_timer_2
#define HAVE_nbif_cancel_timer_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_cancel_timer_2))
ASYM(nbif_cancel_timer_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(cancel_timer_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_cancel_timer_2))
	TYPE_FUNCTION(ASYM(nbif_cancel_timer_2))
#endif

#ifndef HAVE_nbif_read_timer_1
#define HAVE_nbif_read_timer_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_read_timer_1))
ASYM(nbif_read_timer_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(read_timer_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_read_timer_1))
	TYPE_FUNCTION(ASYM(nbif_read_timer_1))
#endif

#ifndef HAVE_nbif_read_timer_2
#define HAVE_nbif_read_timer_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_read_timer_2))
ASYM(nbif_read_timer_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(read_timer_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_read_timer_2))
	TYPE_FUNCTION(ASYM(nbif_read_timer_2))
#endif

#ifndef HAVE_nbif_make_tuple_2
#define HAVE_nbif_make_tuple_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_make_tuple_2))
ASYM(nbif_make_tuple_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(make_tuple_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_make_tuple_2))
	TYPE_FUNCTION(ASYM(nbif_make_tuple_2))
#endif

#ifndef HAVE_nbif_append_element_2
#define HAVE_nbif_append_element_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_append_element_2))
ASYM(nbif_append_element_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(append_element_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_append_element_2))
	TYPE_FUNCTION(ASYM(nbif_append_element_2))
#endif

#ifndef HAVE_nbif_make_tuple_3
#define HAVE_nbif_make_tuple_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_make_tuple_3))
ASYM(nbif_make_tuple_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(make_tuple_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_make_tuple_3))
	TYPE_FUNCTION(ASYM(nbif_make_tuple_3))
#endif

#ifndef HAVE_nbif_system_flag_2
#define HAVE_nbif_system_flag_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_system_flag_2))
ASYM(nbif_system_flag_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(system_flag_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_system_flag_2))
	TYPE_FUNCTION(ASYM(nbif_system_flag_2))
#endif

#ifndef HAVE_nbif_system_info_1
#define HAVE_nbif_system_info_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_system_info_1))
ASYM(nbif_system_info_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(system_info_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_system_info_1))
	TYPE_FUNCTION(ASYM(nbif_system_info_1))
#endif

#ifndef HAVE_nbif_system_monitor_0
#define HAVE_nbif_system_monitor_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_system_monitor_0))
ASYM(nbif_system_monitor_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(system_monitor_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_system_monitor_0))
	TYPE_FUNCTION(ASYM(nbif_system_monitor_0))
#endif

#ifndef HAVE_nbif_system_monitor_1
#define HAVE_nbif_system_monitor_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_system_monitor_1))
ASYM(nbif_system_monitor_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(system_monitor_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_system_monitor_1))
	TYPE_FUNCTION(ASYM(nbif_system_monitor_1))
#endif

#ifndef HAVE_nbif_system_monitor_2
#define HAVE_nbif_system_monitor_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_system_monitor_2))
ASYM(nbif_system_monitor_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(system_monitor_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_system_monitor_2))
	TYPE_FUNCTION(ASYM(nbif_system_monitor_2))
#endif

#ifndef HAVE_nbif_system_profile_2
#define HAVE_nbif_system_profile_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_system_profile_2))
ASYM(nbif_system_profile_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(system_profile_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_system_profile_2))
	TYPE_FUNCTION(ASYM(nbif_system_profile_2))
#endif

#ifndef HAVE_nbif_system_profile_0
#define HAVE_nbif_system_profile_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_system_profile_0))
ASYM(nbif_system_profile_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(system_profile_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_system_profile_0))
	TYPE_FUNCTION(ASYM(nbif_system_profile_0))
#endif

#ifndef HAVE_nbif_ref_to_list_1
#define HAVE_nbif_ref_to_list_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ref_to_list_1))
ASYM(nbif_ref_to_list_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(ref_to_list_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ref_to_list_1))
	TYPE_FUNCTION(ASYM(nbif_ref_to_list_1))
#endif

#ifndef HAVE_nbif_port_to_list_1
#define HAVE_nbif_port_to_list_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_port_to_list_1))
ASYM(nbif_port_to_list_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(port_to_list_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_port_to_list_1))
	TYPE_FUNCTION(ASYM(nbif_port_to_list_1))
#endif

#ifndef HAVE_nbif_fun_to_list_1
#define HAVE_nbif_fun_to_list_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_fun_to_list_1))
ASYM(nbif_fun_to_list_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(fun_to_list_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_fun_to_list_1))
	TYPE_FUNCTION(ASYM(nbif_fun_to_list_1))
#endif

#ifndef HAVE_nbif_monitor_2
#define HAVE_nbif_monitor_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_monitor_2))
ASYM(nbif_monitor_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(monitor_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_monitor_2))
	TYPE_FUNCTION(ASYM(nbif_monitor_2))
#endif

#ifndef HAVE_nbif_demonitor_1
#define HAVE_nbif_demonitor_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_demonitor_1))
ASYM(nbif_demonitor_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(demonitor_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_demonitor_1))
	TYPE_FUNCTION(ASYM(nbif_demonitor_1))
#endif

#ifndef HAVE_nbif_demonitor_2
#define HAVE_nbif_demonitor_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_demonitor_2))
ASYM(nbif_demonitor_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(demonitor_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_demonitor_2))
	TYPE_FUNCTION(ASYM(nbif_demonitor_2))
#endif

#ifndef HAVE_nbif_is_process_alive_1
#define HAVE_nbif_is_process_alive_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_is_process_alive_1))
ASYM(nbif_is_process_alive_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(is_process_alive_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_is_process_alive_1))
	TYPE_FUNCTION(ASYM(nbif_is_process_alive_1))
#endif

#ifndef HAVE_nbif_erts_internal_is_process_alive_2
#define HAVE_nbif_erts_internal_is_process_alive_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_is_process_alive_2))
ASYM(nbif_erts_internal_is_process_alive_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(erts_internal_is_process_alive_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_is_process_alive_2))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_is_process_alive_2))
#endif

#ifndef HAVE_nbif_error_1
#define HAVE_nbif_error_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_error_1))
ASYM(nbif_error_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(error_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_error_1))
	TYPE_FUNCTION(ASYM(nbif_error_1))
#endif

#ifndef HAVE_nbif_error_2
#define HAVE_nbif_error_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_error_2))
ASYM(nbif_error_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(error_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_error_2))
	TYPE_FUNCTION(ASYM(nbif_error_2))
#endif

#ifndef HAVE_nbif_raise_3
#define HAVE_nbif_raise_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_raise_3))
ASYM(nbif_raise_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(raise_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_raise_3))
	TYPE_FUNCTION(ASYM(nbif_raise_3))
#endif

#ifndef HAVE_nbif_get_stacktrace_0
#define HAVE_nbif_get_stacktrace_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_get_stacktrace_0))
ASYM(nbif_get_stacktrace_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(get_stacktrace_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_get_stacktrace_0))
	TYPE_FUNCTION(ASYM(nbif_get_stacktrace_0))
#endif

#ifndef HAVE_nbif_is_builtin_3
#define HAVE_nbif_is_builtin_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_is_builtin_3))
ASYM(nbif_is_builtin_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(is_builtin_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_is_builtin_3))
	TYPE_FUNCTION(ASYM(nbif_is_builtin_3))
#endif

#ifndef HAVE_nbif_and_2
#define HAVE_nbif_and_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_and_2))
ASYM(nbif_and_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(and_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_and_2))
	TYPE_FUNCTION(ASYM(nbif_and_2))
#endif

#ifndef HAVE_nbif_or_2
#define HAVE_nbif_or_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_or_2))
ASYM(nbif_or_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(or_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_or_2))
	TYPE_FUNCTION(ASYM(nbif_or_2))
#endif

#ifndef HAVE_nbif_xor_2
#define HAVE_nbif_xor_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_xor_2))
ASYM(nbif_xor_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(xor_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_xor_2))
	TYPE_FUNCTION(ASYM(nbif_xor_2))
#endif

#ifndef HAVE_nbif_not_1
#define HAVE_nbif_not_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_not_1))
ASYM(nbif_not_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(not_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_not_1))
	TYPE_FUNCTION(ASYM(nbif_not_1))
#endif

#ifndef HAVE_nbif_sgt_2
#define HAVE_nbif_sgt_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_sgt_2))
ASYM(nbif_sgt_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(sgt_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_sgt_2))
	TYPE_FUNCTION(ASYM(nbif_sgt_2))
#endif

#ifndef HAVE_nbif_sge_2
#define HAVE_nbif_sge_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_sge_2))
ASYM(nbif_sge_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(sge_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_sge_2))
	TYPE_FUNCTION(ASYM(nbif_sge_2))
#endif

#ifndef HAVE_nbif_slt_2
#define HAVE_nbif_slt_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_slt_2))
ASYM(nbif_slt_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(slt_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_slt_2))
	TYPE_FUNCTION(ASYM(nbif_slt_2))
#endif

#ifndef HAVE_nbif_sle_2
#define HAVE_nbif_sle_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_sle_2))
ASYM(nbif_sle_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(sle_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_sle_2))
	TYPE_FUNCTION(ASYM(nbif_sle_2))
#endif

#ifndef HAVE_nbif_seq_2
#define HAVE_nbif_seq_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_seq_2))
ASYM(nbif_seq_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(seq_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_seq_2))
	TYPE_FUNCTION(ASYM(nbif_seq_2))
#endif

#ifndef HAVE_nbif_seqeq_2
#define HAVE_nbif_seqeq_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_seqeq_2))
ASYM(nbif_seqeq_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(seqeq_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_seqeq_2))
	TYPE_FUNCTION(ASYM(nbif_seqeq_2))
#endif

#ifndef HAVE_nbif_sneq_2
#define HAVE_nbif_sneq_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_sneq_2))
ASYM(nbif_sneq_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(sneq_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_sneq_2))
	TYPE_FUNCTION(ASYM(nbif_sneq_2))
#endif

#ifndef HAVE_nbif_sneqeq_2
#define HAVE_nbif_sneqeq_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_sneqeq_2))
ASYM(nbif_sneqeq_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(sneqeq_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_sneqeq_2))
	TYPE_FUNCTION(ASYM(nbif_sneqeq_2))
#endif

#ifndef HAVE_nbif_splus_2
#define HAVE_nbif_splus_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_splus_2))
ASYM(nbif_splus_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(splus_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_splus_2))
	TYPE_FUNCTION(ASYM(nbif_splus_2))
#endif

#ifndef HAVE_nbif_sminus_2
#define HAVE_nbif_sminus_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_sminus_2))
ASYM(nbif_sminus_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(sminus_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_sminus_2))
	TYPE_FUNCTION(ASYM(nbif_sminus_2))
#endif

#ifndef HAVE_nbif_stimes_2
#define HAVE_nbif_stimes_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_stimes_2))
ASYM(nbif_stimes_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(stimes_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_stimes_2))
	TYPE_FUNCTION(ASYM(nbif_stimes_2))
#endif

#ifndef HAVE_nbif_div_2
#define HAVE_nbif_div_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_div_2))
ASYM(nbif_div_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(div_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_div_2))
	TYPE_FUNCTION(ASYM(nbif_div_2))
#endif

#ifndef HAVE_nbif_intdiv_2
#define HAVE_nbif_intdiv_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_intdiv_2))
ASYM(nbif_intdiv_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(intdiv_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_intdiv_2))
	TYPE_FUNCTION(ASYM(nbif_intdiv_2))
#endif

#ifndef HAVE_nbif_rem_2
#define HAVE_nbif_rem_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_rem_2))
ASYM(nbif_rem_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(rem_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_rem_2))
	TYPE_FUNCTION(ASYM(nbif_rem_2))
#endif

#ifndef HAVE_nbif_bor_2
#define HAVE_nbif_bor_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_bor_2))
ASYM(nbif_bor_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(bor_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_bor_2))
	TYPE_FUNCTION(ASYM(nbif_bor_2))
#endif

#ifndef HAVE_nbif_band_2
#define HAVE_nbif_band_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_band_2))
ASYM(nbif_band_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(band_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_band_2))
	TYPE_FUNCTION(ASYM(nbif_band_2))
#endif

#ifndef HAVE_nbif_bxor_2
#define HAVE_nbif_bxor_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_bxor_2))
ASYM(nbif_bxor_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(bxor_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_bxor_2))
	TYPE_FUNCTION(ASYM(nbif_bxor_2))
#endif

#ifndef HAVE_nbif_bsl_2
#define HAVE_nbif_bsl_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_bsl_2))
ASYM(nbif_bsl_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(bsl_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_bsl_2))
	TYPE_FUNCTION(ASYM(nbif_bsl_2))
#endif

#ifndef HAVE_nbif_bsr_2
#define HAVE_nbif_bsr_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_bsr_2))
ASYM(nbif_bsr_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(bsr_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_bsr_2))
	TYPE_FUNCTION(ASYM(nbif_bsr_2))
#endif

#ifndef HAVE_nbif_bnot_1
#define HAVE_nbif_bnot_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_bnot_1))
ASYM(nbif_bnot_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(bnot_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_bnot_1))
	TYPE_FUNCTION(ASYM(nbif_bnot_1))
#endif

#ifndef HAVE_nbif_sminus_1
#define HAVE_nbif_sminus_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_sminus_1))
ASYM(nbif_sminus_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(sminus_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_sminus_1))
	TYPE_FUNCTION(ASYM(nbif_sminus_1))
#endif

#ifndef HAVE_nbif_splus_1
#define HAVE_nbif_splus_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_splus_1))
ASYM(nbif_splus_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(splus_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_splus_1))
	TYPE_FUNCTION(ASYM(nbif_splus_1))
#endif

#ifndef HAVE_nbif_ebif_bang_2
#define HAVE_nbif_ebif_bang_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ebif_bang_2))
ASYM(nbif_ebif_bang_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(ebif_bang_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ebif_bang_2))
	TYPE_FUNCTION(ASYM(nbif_ebif_bang_2))
#endif

#ifndef HAVE_nbif_send_2
#define HAVE_nbif_send_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_send_2))
ASYM(nbif_send_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(send_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_send_2))
	TYPE_FUNCTION(ASYM(nbif_send_2))
#endif

#ifndef HAVE_nbif_send_3
#define HAVE_nbif_send_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_send_3))
ASYM(nbif_send_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(send_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_send_3))
	TYPE_FUNCTION(ASYM(nbif_send_3))
#endif

#ifndef HAVE_nbif_ebif_plusplus_2
#define HAVE_nbif_ebif_plusplus_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ebif_plusplus_2))
ASYM(nbif_ebif_plusplus_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(ebif_plusplus_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ebif_plusplus_2))
	TYPE_FUNCTION(ASYM(nbif_ebif_plusplus_2))
#endif

#ifndef HAVE_nbif_append_2
#define HAVE_nbif_append_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_append_2))
ASYM(nbif_append_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(append_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_append_2))
	TYPE_FUNCTION(ASYM(nbif_append_2))
#endif

#ifndef HAVE_nbif_ebif_minusminus_2
#define HAVE_nbif_ebif_minusminus_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ebif_minusminus_2))
ASYM(nbif_ebif_minusminus_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(ebif_minusminus_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ebif_minusminus_2))
	TYPE_FUNCTION(ASYM(nbif_ebif_minusminus_2))
#endif

#ifndef HAVE_nbif_subtract_2
#define HAVE_nbif_subtract_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_subtract_2))
ASYM(nbif_subtract_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(subtract_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_subtract_2))
	TYPE_FUNCTION(ASYM(nbif_subtract_2))
#endif

#ifndef HAVE_nbif_is_atom_1
#define HAVE_nbif_is_atom_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_is_atom_1))
ASYM(nbif_is_atom_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(is_atom_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_is_atom_1))
	TYPE_FUNCTION(ASYM(nbif_is_atom_1))
#endif

#ifndef HAVE_nbif_is_list_1
#define HAVE_nbif_is_list_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_is_list_1))
ASYM(nbif_is_list_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(is_list_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_is_list_1))
	TYPE_FUNCTION(ASYM(nbif_is_list_1))
#endif

#ifndef HAVE_nbif_is_tuple_1
#define HAVE_nbif_is_tuple_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_is_tuple_1))
ASYM(nbif_is_tuple_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(is_tuple_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_is_tuple_1))
	TYPE_FUNCTION(ASYM(nbif_is_tuple_1))
#endif

#ifndef HAVE_nbif_is_float_1
#define HAVE_nbif_is_float_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_is_float_1))
ASYM(nbif_is_float_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(is_float_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_is_float_1))
	TYPE_FUNCTION(ASYM(nbif_is_float_1))
#endif

#ifndef HAVE_nbif_is_integer_1
#define HAVE_nbif_is_integer_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_is_integer_1))
ASYM(nbif_is_integer_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(is_integer_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_is_integer_1))
	TYPE_FUNCTION(ASYM(nbif_is_integer_1))
#endif

#ifndef HAVE_nbif_is_number_1
#define HAVE_nbif_is_number_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_is_number_1))
ASYM(nbif_is_number_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(is_number_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_is_number_1))
	TYPE_FUNCTION(ASYM(nbif_is_number_1))
#endif

#ifndef HAVE_nbif_is_pid_1
#define HAVE_nbif_is_pid_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_is_pid_1))
ASYM(nbif_is_pid_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(is_pid_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_is_pid_1))
	TYPE_FUNCTION(ASYM(nbif_is_pid_1))
#endif

#ifndef HAVE_nbif_is_port_1
#define HAVE_nbif_is_port_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_is_port_1))
ASYM(nbif_is_port_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(is_port_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_is_port_1))
	TYPE_FUNCTION(ASYM(nbif_is_port_1))
#endif

#ifndef HAVE_nbif_is_reference_1
#define HAVE_nbif_is_reference_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_is_reference_1))
ASYM(nbif_is_reference_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(is_reference_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_is_reference_1))
	TYPE_FUNCTION(ASYM(nbif_is_reference_1))
#endif

#ifndef HAVE_nbif_is_binary_1
#define HAVE_nbif_is_binary_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_is_binary_1))
ASYM(nbif_is_binary_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(is_binary_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_is_binary_1))
	TYPE_FUNCTION(ASYM(nbif_is_binary_1))
#endif

#ifndef HAVE_nbif_is_function_1
#define HAVE_nbif_is_function_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_is_function_1))
ASYM(nbif_is_function_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(is_function_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_is_function_1))
	TYPE_FUNCTION(ASYM(nbif_is_function_1))
#endif

#ifndef HAVE_nbif_is_function_2
#define HAVE_nbif_is_function_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_is_function_2))
ASYM(nbif_is_function_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(is_function_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_is_function_2))
	TYPE_FUNCTION(ASYM(nbif_is_function_2))
#endif

#ifndef HAVE_nbif_is_record_2
#define HAVE_nbif_is_record_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_is_record_2))
ASYM(nbif_is_record_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(is_record_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_is_record_2))
	TYPE_FUNCTION(ASYM(nbif_is_record_2))
#endif

#ifndef HAVE_nbif_is_record_3
#define HAVE_nbif_is_record_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_is_record_3))
ASYM(nbif_is_record_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(is_record_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_is_record_3))
	TYPE_FUNCTION(ASYM(nbif_is_record_3))
#endif

#ifndef HAVE_nbif_match_spec_test_3
#define HAVE_nbif_match_spec_test_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_match_spec_test_3))
ASYM(nbif_match_spec_test_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(match_spec_test_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_match_spec_test_3))
	TYPE_FUNCTION(ASYM(nbif_match_spec_test_3))
#endif

#ifndef HAVE_nbif_ets_internal_request_all_0
#define HAVE_nbif_ets_internal_request_all_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ets_internal_request_all_0))
ASYM(nbif_ets_internal_request_all_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(ets_internal_request_all_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ets_internal_request_all_0))
	TYPE_FUNCTION(ASYM(nbif_ets_internal_request_all_0))
#endif

#ifndef HAVE_nbif_ets_new_2
#define HAVE_nbif_ets_new_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ets_new_2))
ASYM(nbif_ets_new_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(ets_new_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ets_new_2))
	TYPE_FUNCTION(ASYM(nbif_ets_new_2))
#endif

#ifndef HAVE_nbif_ets_delete_1
#define HAVE_nbif_ets_delete_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ets_delete_1))
ASYM(nbif_ets_delete_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(ets_delete_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ets_delete_1))
	TYPE_FUNCTION(ASYM(nbif_ets_delete_1))
#endif

#ifndef HAVE_nbif_ets_delete_2
#define HAVE_nbif_ets_delete_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ets_delete_2))
ASYM(nbif_ets_delete_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(ets_delete_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ets_delete_2))
	TYPE_FUNCTION(ASYM(nbif_ets_delete_2))
#endif

#ifndef HAVE_nbif_ets_delete_object_2
#define HAVE_nbif_ets_delete_object_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ets_delete_object_2))
ASYM(nbif_ets_delete_object_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(ets_delete_object_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ets_delete_object_2))
	TYPE_FUNCTION(ASYM(nbif_ets_delete_object_2))
#endif

#ifndef HAVE_nbif_ets_first_1
#define HAVE_nbif_ets_first_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ets_first_1))
ASYM(nbif_ets_first_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(ets_first_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ets_first_1))
	TYPE_FUNCTION(ASYM(nbif_ets_first_1))
#endif

#ifndef HAVE_nbif_ets_is_compiled_ms_1
#define HAVE_nbif_ets_is_compiled_ms_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ets_is_compiled_ms_1))
ASYM(nbif_ets_is_compiled_ms_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(ets_is_compiled_ms_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ets_is_compiled_ms_1))
	TYPE_FUNCTION(ASYM(nbif_ets_is_compiled_ms_1))
#endif

#ifndef HAVE_nbif_ets_lookup_2
#define HAVE_nbif_ets_lookup_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ets_lookup_2))
ASYM(nbif_ets_lookup_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(ets_lookup_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ets_lookup_2))
	TYPE_FUNCTION(ASYM(nbif_ets_lookup_2))
#endif

#ifndef HAVE_nbif_ets_lookup_element_3
#define HAVE_nbif_ets_lookup_element_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ets_lookup_element_3))
ASYM(nbif_ets_lookup_element_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(ets_lookup_element_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ets_lookup_element_3))
	TYPE_FUNCTION(ASYM(nbif_ets_lookup_element_3))
#endif

#ifndef HAVE_nbif_ets_info_1
#define HAVE_nbif_ets_info_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ets_info_1))
ASYM(nbif_ets_info_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(ets_info_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ets_info_1))
	TYPE_FUNCTION(ASYM(nbif_ets_info_1))
#endif

#ifndef HAVE_nbif_ets_info_2
#define HAVE_nbif_ets_info_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ets_info_2))
ASYM(nbif_ets_info_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(ets_info_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ets_info_2))
	TYPE_FUNCTION(ASYM(nbif_ets_info_2))
#endif

#ifndef HAVE_nbif_ets_last_1
#define HAVE_nbif_ets_last_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ets_last_1))
ASYM(nbif_ets_last_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(ets_last_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ets_last_1))
	TYPE_FUNCTION(ASYM(nbif_ets_last_1))
#endif

#ifndef HAVE_nbif_ets_match_1
#define HAVE_nbif_ets_match_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ets_match_1))
ASYM(nbif_ets_match_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(ets_match_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ets_match_1))
	TYPE_FUNCTION(ASYM(nbif_ets_match_1))
#endif

#ifndef HAVE_nbif_ets_match_2
#define HAVE_nbif_ets_match_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ets_match_2))
ASYM(nbif_ets_match_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(ets_match_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ets_match_2))
	TYPE_FUNCTION(ASYM(nbif_ets_match_2))
#endif

#ifndef HAVE_nbif_ets_match_3
#define HAVE_nbif_ets_match_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ets_match_3))
ASYM(nbif_ets_match_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(ets_match_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ets_match_3))
	TYPE_FUNCTION(ASYM(nbif_ets_match_3))
#endif

#ifndef HAVE_nbif_ets_match_object_1
#define HAVE_nbif_ets_match_object_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ets_match_object_1))
ASYM(nbif_ets_match_object_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(ets_match_object_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ets_match_object_1))
	TYPE_FUNCTION(ASYM(nbif_ets_match_object_1))
#endif

#ifndef HAVE_nbif_ets_match_object_2
#define HAVE_nbif_ets_match_object_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ets_match_object_2))
ASYM(nbif_ets_match_object_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(ets_match_object_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ets_match_object_2))
	TYPE_FUNCTION(ASYM(nbif_ets_match_object_2))
#endif

#ifndef HAVE_nbif_ets_match_object_3
#define HAVE_nbif_ets_match_object_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ets_match_object_3))
ASYM(nbif_ets_match_object_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(ets_match_object_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ets_match_object_3))
	TYPE_FUNCTION(ASYM(nbif_ets_match_object_3))
#endif

#ifndef HAVE_nbif_ets_member_2
#define HAVE_nbif_ets_member_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ets_member_2))
ASYM(nbif_ets_member_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(ets_member_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ets_member_2))
	TYPE_FUNCTION(ASYM(nbif_ets_member_2))
#endif

#ifndef HAVE_nbif_ets_next_2
#define HAVE_nbif_ets_next_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ets_next_2))
ASYM(nbif_ets_next_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(ets_next_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ets_next_2))
	TYPE_FUNCTION(ASYM(nbif_ets_next_2))
#endif

#ifndef HAVE_nbif_ets_prev_2
#define HAVE_nbif_ets_prev_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ets_prev_2))
ASYM(nbif_ets_prev_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(ets_prev_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ets_prev_2))
	TYPE_FUNCTION(ASYM(nbif_ets_prev_2))
#endif

#ifndef HAVE_nbif_ets_insert_2
#define HAVE_nbif_ets_insert_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ets_insert_2))
ASYM(nbif_ets_insert_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(ets_insert_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ets_insert_2))
	TYPE_FUNCTION(ASYM(nbif_ets_insert_2))
#endif

#ifndef HAVE_nbif_ets_insert_new_2
#define HAVE_nbif_ets_insert_new_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ets_insert_new_2))
ASYM(nbif_ets_insert_new_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(ets_insert_new_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ets_insert_new_2))
	TYPE_FUNCTION(ASYM(nbif_ets_insert_new_2))
#endif

#ifndef HAVE_nbif_ets_rename_2
#define HAVE_nbif_ets_rename_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ets_rename_2))
ASYM(nbif_ets_rename_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(ets_rename_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ets_rename_2))
	TYPE_FUNCTION(ASYM(nbif_ets_rename_2))
#endif

#ifndef HAVE_nbif_ets_safe_fixtable_2
#define HAVE_nbif_ets_safe_fixtable_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ets_safe_fixtable_2))
ASYM(nbif_ets_safe_fixtable_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(ets_safe_fixtable_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ets_safe_fixtable_2))
	TYPE_FUNCTION(ASYM(nbif_ets_safe_fixtable_2))
#endif

#ifndef HAVE_nbif_ets_slot_2
#define HAVE_nbif_ets_slot_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ets_slot_2))
ASYM(nbif_ets_slot_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(ets_slot_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ets_slot_2))
	TYPE_FUNCTION(ASYM(nbif_ets_slot_2))
#endif

#ifndef HAVE_nbif_ets_update_counter_3
#define HAVE_nbif_ets_update_counter_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ets_update_counter_3))
ASYM(nbif_ets_update_counter_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(ets_update_counter_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ets_update_counter_3))
	TYPE_FUNCTION(ASYM(nbif_ets_update_counter_3))
#endif

#ifndef HAVE_nbif_ets_select_1
#define HAVE_nbif_ets_select_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ets_select_1))
ASYM(nbif_ets_select_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(ets_select_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ets_select_1))
	TYPE_FUNCTION(ASYM(nbif_ets_select_1))
#endif

#ifndef HAVE_nbif_ets_select_2
#define HAVE_nbif_ets_select_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ets_select_2))
ASYM(nbif_ets_select_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(ets_select_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ets_select_2))
	TYPE_FUNCTION(ASYM(nbif_ets_select_2))
#endif

#ifndef HAVE_nbif_ets_select_3
#define HAVE_nbif_ets_select_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ets_select_3))
ASYM(nbif_ets_select_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(ets_select_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ets_select_3))
	TYPE_FUNCTION(ASYM(nbif_ets_select_3))
#endif

#ifndef HAVE_nbif_ets_select_count_2
#define HAVE_nbif_ets_select_count_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ets_select_count_2))
ASYM(nbif_ets_select_count_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(ets_select_count_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ets_select_count_2))
	TYPE_FUNCTION(ASYM(nbif_ets_select_count_2))
#endif

#ifndef HAVE_nbif_ets_select_reverse_1
#define HAVE_nbif_ets_select_reverse_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ets_select_reverse_1))
ASYM(nbif_ets_select_reverse_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(ets_select_reverse_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ets_select_reverse_1))
	TYPE_FUNCTION(ASYM(nbif_ets_select_reverse_1))
#endif

#ifndef HAVE_nbif_ets_select_reverse_2
#define HAVE_nbif_ets_select_reverse_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ets_select_reverse_2))
ASYM(nbif_ets_select_reverse_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(ets_select_reverse_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ets_select_reverse_2))
	TYPE_FUNCTION(ASYM(nbif_ets_select_reverse_2))
#endif

#ifndef HAVE_nbif_ets_select_reverse_3
#define HAVE_nbif_ets_select_reverse_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ets_select_reverse_3))
ASYM(nbif_ets_select_reverse_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(ets_select_reverse_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ets_select_reverse_3))
	TYPE_FUNCTION(ASYM(nbif_ets_select_reverse_3))
#endif

#ifndef HAVE_nbif_ets_select_replace_2
#define HAVE_nbif_ets_select_replace_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ets_select_replace_2))
ASYM(nbif_ets_select_replace_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(ets_select_replace_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ets_select_replace_2))
	TYPE_FUNCTION(ASYM(nbif_ets_select_replace_2))
#endif

#ifndef HAVE_nbif_ets_match_spec_compile_1
#define HAVE_nbif_ets_match_spec_compile_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ets_match_spec_compile_1))
ASYM(nbif_ets_match_spec_compile_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(ets_match_spec_compile_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ets_match_spec_compile_1))
	TYPE_FUNCTION(ASYM(nbif_ets_match_spec_compile_1))
#endif

#ifndef HAVE_nbif_ets_match_spec_run_r_3
#define HAVE_nbif_ets_match_spec_run_r_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ets_match_spec_run_r_3))
ASYM(nbif_ets_match_spec_run_r_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(ets_match_spec_run_r_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ets_match_spec_run_r_3))
	TYPE_FUNCTION(ASYM(nbif_ets_match_spec_run_r_3))
#endif

#ifndef HAVE_nbif_os_get_env_var_1
#define HAVE_nbif_os_get_env_var_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_os_get_env_var_1))
ASYM(nbif_os_get_env_var_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(os_get_env_var_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_os_get_env_var_1))
	TYPE_FUNCTION(ASYM(nbif_os_get_env_var_1))
#endif

#ifndef HAVE_nbif_os_set_env_var_2
#define HAVE_nbif_os_set_env_var_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_os_set_env_var_2))
ASYM(nbif_os_set_env_var_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(os_set_env_var_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_os_set_env_var_2))
	TYPE_FUNCTION(ASYM(nbif_os_set_env_var_2))
#endif

#ifndef HAVE_nbif_os_unset_env_var_1
#define HAVE_nbif_os_unset_env_var_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_os_unset_env_var_1))
ASYM(nbif_os_unset_env_var_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(os_unset_env_var_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_os_unset_env_var_1))
	TYPE_FUNCTION(ASYM(nbif_os_unset_env_var_1))
#endif

#ifndef HAVE_nbif_os_list_env_vars_0
#define HAVE_nbif_os_list_env_vars_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_os_list_env_vars_0))
ASYM(nbif_os_list_env_vars_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(os_list_env_vars_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_os_list_env_vars_0))
	TYPE_FUNCTION(ASYM(nbif_os_list_env_vars_0))
#endif

#ifndef HAVE_nbif_os_getpid_0
#define HAVE_nbif_os_getpid_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_os_getpid_0))
ASYM(nbif_os_getpid_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(os_getpid_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_os_getpid_0))
	TYPE_FUNCTION(ASYM(nbif_os_getpid_0))
#endif

#ifndef HAVE_nbif_os_timestamp_0
#define HAVE_nbif_os_timestamp_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_os_timestamp_0))
ASYM(nbif_os_timestamp_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(os_timestamp_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_os_timestamp_0))
	TYPE_FUNCTION(ASYM(nbif_os_timestamp_0))
#endif

#ifndef HAVE_nbif_os_system_time_0
#define HAVE_nbif_os_system_time_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_os_system_time_0))
ASYM(nbif_os_system_time_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(os_system_time_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_os_system_time_0))
	TYPE_FUNCTION(ASYM(nbif_os_system_time_0))
#endif

#ifndef HAVE_nbif_os_system_time_1
#define HAVE_nbif_os_system_time_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_os_system_time_1))
ASYM(nbif_os_system_time_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(os_system_time_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_os_system_time_1))
	TYPE_FUNCTION(ASYM(nbif_os_system_time_1))
#endif

#ifndef HAVE_nbif_os_perf_counter_0
#define HAVE_nbif_os_perf_counter_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_os_perf_counter_0))
ASYM(nbif_os_perf_counter_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(os_perf_counter_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_os_perf_counter_0))
	TYPE_FUNCTION(ASYM(nbif_os_perf_counter_0))
#endif

#ifndef HAVE_nbif_erl_ddll_try_load_3
#define HAVE_nbif_erl_ddll_try_load_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erl_ddll_try_load_3))
ASYM(nbif_erl_ddll_try_load_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(erl_ddll_try_load_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erl_ddll_try_load_3))
	TYPE_FUNCTION(ASYM(nbif_erl_ddll_try_load_3))
#endif

#ifndef HAVE_nbif_erl_ddll_try_unload_2
#define HAVE_nbif_erl_ddll_try_unload_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erl_ddll_try_unload_2))
ASYM(nbif_erl_ddll_try_unload_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(erl_ddll_try_unload_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erl_ddll_try_unload_2))
	TYPE_FUNCTION(ASYM(nbif_erl_ddll_try_unload_2))
#endif

#ifndef HAVE_nbif_erl_ddll_loaded_drivers_0
#define HAVE_nbif_erl_ddll_loaded_drivers_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erl_ddll_loaded_drivers_0))
ASYM(nbif_erl_ddll_loaded_drivers_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(erl_ddll_loaded_drivers_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erl_ddll_loaded_drivers_0))
	TYPE_FUNCTION(ASYM(nbif_erl_ddll_loaded_drivers_0))
#endif

#ifndef HAVE_nbif_erl_ddll_info_2
#define HAVE_nbif_erl_ddll_info_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erl_ddll_info_2))
ASYM(nbif_erl_ddll_info_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(erl_ddll_info_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erl_ddll_info_2))
	TYPE_FUNCTION(ASYM(nbif_erl_ddll_info_2))
#endif

#ifndef HAVE_nbif_erl_ddll_format_error_int_1
#define HAVE_nbif_erl_ddll_format_error_int_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erl_ddll_format_error_int_1))
ASYM(nbif_erl_ddll_format_error_int_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(erl_ddll_format_error_int_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erl_ddll_format_error_int_1))
	TYPE_FUNCTION(ASYM(nbif_erl_ddll_format_error_int_1))
#endif

#ifndef HAVE_nbif_erl_ddll_monitor_2
#define HAVE_nbif_erl_ddll_monitor_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erl_ddll_monitor_2))
ASYM(nbif_erl_ddll_monitor_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(erl_ddll_monitor_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erl_ddll_monitor_2))
	TYPE_FUNCTION(ASYM(nbif_erl_ddll_monitor_2))
#endif

#ifndef HAVE_nbif_erl_ddll_demonitor_1
#define HAVE_nbif_erl_ddll_demonitor_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erl_ddll_demonitor_1))
ASYM(nbif_erl_ddll_demonitor_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(erl_ddll_demonitor_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erl_ddll_demonitor_1))
	TYPE_FUNCTION(ASYM(nbif_erl_ddll_demonitor_1))
#endif

#ifndef HAVE_nbif_re_version_0
#define HAVE_nbif_re_version_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_re_version_0))
ASYM(nbif_re_version_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(re_version_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_re_version_0))
	TYPE_FUNCTION(ASYM(nbif_re_version_0))
#endif

#ifndef HAVE_nbif_re_compile_1
#define HAVE_nbif_re_compile_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_re_compile_1))
ASYM(nbif_re_compile_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(re_compile_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_re_compile_1))
	TYPE_FUNCTION(ASYM(nbif_re_compile_1))
#endif

#ifndef HAVE_nbif_re_compile_2
#define HAVE_nbif_re_compile_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_re_compile_2))
ASYM(nbif_re_compile_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(re_compile_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_re_compile_2))
	TYPE_FUNCTION(ASYM(nbif_re_compile_2))
#endif

#ifndef HAVE_nbif_re_run_2
#define HAVE_nbif_re_run_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_re_run_2))
ASYM(nbif_re_run_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(re_run_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_re_run_2))
	TYPE_FUNCTION(ASYM(nbif_re_run_2))
#endif

#ifndef HAVE_nbif_re_run_3
#define HAVE_nbif_re_run_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_re_run_3))
ASYM(nbif_re_run_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(re_run_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_re_run_3))
	TYPE_FUNCTION(ASYM(nbif_re_run_3))
#endif

#ifndef HAVE_nbif_re_internal_run_4
#define HAVE_nbif_re_internal_run_4
	TEXT
	.align  4
	GLOBAL(ASYM(nbif_re_internal_run_4))
ASYM(nbif_re_internal_run_4):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx
	# movq	%r8, %r8

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%r8
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(re_internal_run_4)
	add	$(4*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_4_simple_exception
	NSP_RET0
	
3:	call nbif_4_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_re_internal_run_4))
	TYPE_FUNCTION(ASYM(nbif_re_internal_run_4))
#endif

#ifndef HAVE_nbif_lists_member_2
#define HAVE_nbif_lists_member_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_lists_member_2))
ASYM(nbif_lists_member_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(lists_member_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_lists_member_2))
	TYPE_FUNCTION(ASYM(nbif_lists_member_2))
#endif

#ifndef HAVE_nbif_lists_reverse_2
#define HAVE_nbif_lists_reverse_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_lists_reverse_2))
ASYM(nbif_lists_reverse_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(lists_reverse_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_lists_reverse_2))
	TYPE_FUNCTION(ASYM(nbif_lists_reverse_2))
#endif

#ifndef HAVE_nbif_lists_keymember_3
#define HAVE_nbif_lists_keymember_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_lists_keymember_3))
ASYM(nbif_lists_keymember_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(lists_keymember_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_lists_keymember_3))
	TYPE_FUNCTION(ASYM(nbif_lists_keymember_3))
#endif

#ifndef HAVE_nbif_lists_keysearch_3
#define HAVE_nbif_lists_keysearch_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_lists_keysearch_3))
ASYM(nbif_lists_keysearch_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(lists_keysearch_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_lists_keysearch_3))
	TYPE_FUNCTION(ASYM(nbif_lists_keysearch_3))
#endif

#ifndef HAVE_nbif_lists_keyfind_3
#define HAVE_nbif_lists_keyfind_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_lists_keyfind_3))
ASYM(nbif_lists_keyfind_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(lists_keyfind_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_lists_keyfind_3))
	TYPE_FUNCTION(ASYM(nbif_lists_keyfind_3))
#endif

#ifndef HAVE_nbif_erts_debug_disassemble_1
#define HAVE_nbif_erts_debug_disassemble_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_debug_disassemble_1))
ASYM(nbif_erts_debug_disassemble_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(erts_debug_disassemble_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_debug_disassemble_1))
	TYPE_FUNCTION(ASYM(nbif_erts_debug_disassemble_1))
#endif

#ifndef HAVE_nbif_erts_debug_breakpoint_2
#define HAVE_nbif_erts_debug_breakpoint_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_debug_breakpoint_2))
ASYM(nbif_erts_debug_breakpoint_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(erts_debug_breakpoint_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_debug_breakpoint_2))
	TYPE_FUNCTION(ASYM(nbif_erts_debug_breakpoint_2))
#endif

#ifndef HAVE_nbif_erts_debug_same_2
#define HAVE_nbif_erts_debug_same_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_debug_same_2))
ASYM(nbif_erts_debug_same_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(erts_debug_same_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_debug_same_2))
	TYPE_FUNCTION(ASYM(nbif_erts_debug_same_2))
#endif

#ifndef HAVE_nbif_erts_debug_flat_size_1
#define HAVE_nbif_erts_debug_flat_size_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_debug_flat_size_1))
ASYM(nbif_erts_debug_flat_size_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(erts_debug_flat_size_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_debug_flat_size_1))
	TYPE_FUNCTION(ASYM(nbif_erts_debug_flat_size_1))
#endif

#ifndef HAVE_nbif_erts_debug_get_internal_state_1
#define HAVE_nbif_erts_debug_get_internal_state_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_debug_get_internal_state_1))
ASYM(nbif_erts_debug_get_internal_state_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(erts_debug_get_internal_state_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_debug_get_internal_state_1))
	TYPE_FUNCTION(ASYM(nbif_erts_debug_get_internal_state_1))
#endif

#ifndef HAVE_nbif_erts_debug_set_internal_state_2
#define HAVE_nbif_erts_debug_set_internal_state_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_debug_set_internal_state_2))
ASYM(nbif_erts_debug_set_internal_state_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(erts_debug_set_internal_state_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_debug_set_internal_state_2))
	TYPE_FUNCTION(ASYM(nbif_erts_debug_set_internal_state_2))
#endif

#ifndef HAVE_nbif_erts_debug_display_1
#define HAVE_nbif_erts_debug_display_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_debug_display_1))
ASYM(nbif_erts_debug_display_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(erts_debug_display_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_debug_display_1))
	TYPE_FUNCTION(ASYM(nbif_erts_debug_display_1))
#endif

#ifndef HAVE_nbif_erts_debug_dist_ext_to_term_2
#define HAVE_nbif_erts_debug_dist_ext_to_term_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_debug_dist_ext_to_term_2))
ASYM(nbif_erts_debug_dist_ext_to_term_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(erts_debug_dist_ext_to_term_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_debug_dist_ext_to_term_2))
	TYPE_FUNCTION(ASYM(nbif_erts_debug_dist_ext_to_term_2))
#endif

#ifndef HAVE_nbif_erts_debug_instructions_0
#define HAVE_nbif_erts_debug_instructions_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_debug_instructions_0))
ASYM(nbif_erts_debug_instructions_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(erts_debug_instructions_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_debug_instructions_0))
	TYPE_FUNCTION(ASYM(nbif_erts_debug_instructions_0))
#endif

#ifndef HAVE_nbif_erts_debug_interpreter_size_0
#define HAVE_nbif_erts_debug_interpreter_size_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_debug_interpreter_size_0))
ASYM(nbif_erts_debug_interpreter_size_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(erts_debug_interpreter_size_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_debug_interpreter_size_0))
	TYPE_FUNCTION(ASYM(nbif_erts_debug_interpreter_size_0))
#endif

#ifndef HAVE_nbif_erts_debug_dirty_cpu_2
#define HAVE_nbif_erts_debug_dirty_cpu_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_debug_dirty_cpu_2))
ASYM(nbif_erts_debug_dirty_cpu_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(erts_debug_dirty_cpu_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_debug_dirty_cpu_2))
	TYPE_FUNCTION(ASYM(nbif_erts_debug_dirty_cpu_2))
#endif

#ifndef HAVE_nbif_erts_debug_dirty_io_2
#define HAVE_nbif_erts_debug_dirty_io_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_debug_dirty_io_2))
ASYM(nbif_erts_debug_dirty_io_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(erts_debug_dirty_io_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_debug_dirty_io_2))
	TYPE_FUNCTION(ASYM(nbif_erts_debug_dirty_io_2))
#endif

#ifndef HAVE_nbif_erts_debug_dirty_3
#define HAVE_nbif_erts_debug_dirty_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_debug_dirty_3))
ASYM(nbif_erts_debug_dirty_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(erts_debug_dirty_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_debug_dirty_3))
	TYPE_FUNCTION(ASYM(nbif_erts_debug_dirty_3))
#endif

#ifndef HAVE_nbif_erts_debug_lcnt_control_2
#define HAVE_nbif_erts_debug_lcnt_control_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_debug_lcnt_control_2))
ASYM(nbif_erts_debug_lcnt_control_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(erts_debug_lcnt_control_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_debug_lcnt_control_2))
	TYPE_FUNCTION(ASYM(nbif_erts_debug_lcnt_control_2))
#endif

#ifndef HAVE_nbif_erts_debug_lcnt_control_1
#define HAVE_nbif_erts_debug_lcnt_control_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_debug_lcnt_control_1))
ASYM(nbif_erts_debug_lcnt_control_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(erts_debug_lcnt_control_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_debug_lcnt_control_1))
	TYPE_FUNCTION(ASYM(nbif_erts_debug_lcnt_control_1))
#endif

#ifndef HAVE_nbif_erts_debug_lcnt_collect_0
#define HAVE_nbif_erts_debug_lcnt_collect_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_debug_lcnt_collect_0))
ASYM(nbif_erts_debug_lcnt_collect_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(erts_debug_lcnt_collect_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_debug_lcnt_collect_0))
	TYPE_FUNCTION(ASYM(nbif_erts_debug_lcnt_collect_0))
#endif

#ifndef HAVE_nbif_erts_debug_lcnt_clear_0
#define HAVE_nbif_erts_debug_lcnt_clear_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_debug_lcnt_clear_0))
ASYM(nbif_erts_debug_lcnt_clear_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(erts_debug_lcnt_clear_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_debug_lcnt_clear_0))
	TYPE_FUNCTION(ASYM(nbif_erts_debug_lcnt_clear_0))
#endif

#ifndef HAVE_nbif_code_get_chunk_2
#define HAVE_nbif_code_get_chunk_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_code_get_chunk_2))
ASYM(nbif_code_get_chunk_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(code_get_chunk_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_code_get_chunk_2))
	TYPE_FUNCTION(ASYM(nbif_code_get_chunk_2))
#endif

#ifndef HAVE_nbif_code_module_md5_1
#define HAVE_nbif_code_module_md5_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_code_module_md5_1))
ASYM(nbif_code_module_md5_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(code_module_md5_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_code_module_md5_1))
	TYPE_FUNCTION(ASYM(nbif_code_module_md5_1))
#endif

#ifndef HAVE_nbif_code_make_stub_module_3
#define HAVE_nbif_code_make_stub_module_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_code_make_stub_module_3))
ASYM(nbif_code_make_stub_module_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(code_make_stub_module_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_code_make_stub_module_3))
	TYPE_FUNCTION(ASYM(nbif_code_make_stub_module_3))
#endif

#ifndef HAVE_nbif_code_is_module_native_1
#define HAVE_nbif_code_is_module_native_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_code_is_module_native_1))
ASYM(nbif_code_is_module_native_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(code_is_module_native_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_code_is_module_native_1))
	TYPE_FUNCTION(ASYM(nbif_code_is_module_native_1))
#endif

#ifndef HAVE_nbif_hibernate_3
#define HAVE_nbif_hibernate_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hibernate_3))
ASYM(nbif_hibernate_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(hibernate_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hibernate_3))
	TYPE_FUNCTION(ASYM(nbif_hibernate_3))
#endif

#ifndef HAVE_nbif_error_logger_warning_map_0
#define HAVE_nbif_error_logger_warning_map_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_error_logger_warning_map_0))
ASYM(nbif_error_logger_warning_map_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(error_logger_warning_map_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_error_logger_warning_map_0))
	TYPE_FUNCTION(ASYM(nbif_error_logger_warning_map_0))
#endif

#ifndef HAVE_nbif_get_module_info_1
#define HAVE_nbif_get_module_info_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_get_module_info_1))
ASYM(nbif_get_module_info_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(get_module_info_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_get_module_info_1))
	TYPE_FUNCTION(ASYM(nbif_get_module_info_1))
#endif

#ifndef HAVE_nbif_get_module_info_2
#define HAVE_nbif_get_module_info_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_get_module_info_2))
ASYM(nbif_get_module_info_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(get_module_info_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_get_module_info_2))
	TYPE_FUNCTION(ASYM(nbif_get_module_info_2))
#endif

#ifndef HAVE_nbif_is_boolean_1
#define HAVE_nbif_is_boolean_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_is_boolean_1))
ASYM(nbif_is_boolean_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(is_boolean_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_is_boolean_1))
	TYPE_FUNCTION(ASYM(nbif_is_boolean_1))
#endif

#ifndef HAVE_nbif_string_list_to_integer_1
#define HAVE_nbif_string_list_to_integer_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_string_list_to_integer_1))
ASYM(nbif_string_list_to_integer_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(string_list_to_integer_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_string_list_to_integer_1))
	TYPE_FUNCTION(ASYM(nbif_string_list_to_integer_1))
#endif

#ifndef HAVE_nbif_string_list_to_float_1
#define HAVE_nbif_string_list_to_float_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_string_list_to_float_1))
ASYM(nbif_string_list_to_float_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(string_list_to_float_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_string_list_to_float_1))
	TYPE_FUNCTION(ASYM(nbif_string_list_to_float_1))
#endif

#ifndef HAVE_nbif_make_fun_3
#define HAVE_nbif_make_fun_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_make_fun_3))
ASYM(nbif_make_fun_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(make_fun_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_make_fun_3))
	TYPE_FUNCTION(ASYM(nbif_make_fun_3))
#endif

#ifndef HAVE_nbif_iolist_size_1
#define HAVE_nbif_iolist_size_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_iolist_size_1))
ASYM(nbif_iolist_size_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(iolist_size_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_iolist_size_1))
	TYPE_FUNCTION(ASYM(nbif_iolist_size_1))
#endif

#ifndef HAVE_nbif_iolist_to_binary_1
#define HAVE_nbif_iolist_to_binary_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_iolist_to_binary_1))
ASYM(nbif_iolist_to_binary_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(iolist_to_binary_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_iolist_to_binary_1))
	TYPE_FUNCTION(ASYM(nbif_iolist_to_binary_1))
#endif

#ifndef HAVE_nbif_list_to_existing_atom_1
#define HAVE_nbif_list_to_existing_atom_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_list_to_existing_atom_1))
ASYM(nbif_list_to_existing_atom_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(list_to_existing_atom_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_list_to_existing_atom_1))
	TYPE_FUNCTION(ASYM(nbif_list_to_existing_atom_1))
#endif

#ifndef HAVE_nbif_is_bitstring_1
#define HAVE_nbif_is_bitstring_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_is_bitstring_1))
ASYM(nbif_is_bitstring_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(is_bitstring_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_is_bitstring_1))
	TYPE_FUNCTION(ASYM(nbif_is_bitstring_1))
#endif

#ifndef HAVE_nbif_tuple_size_1
#define HAVE_nbif_tuple_size_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_tuple_size_1))
ASYM(nbif_tuple_size_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(tuple_size_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_tuple_size_1))
	TYPE_FUNCTION(ASYM(nbif_tuple_size_1))
#endif

#ifndef HAVE_nbif_byte_size_1
#define HAVE_nbif_byte_size_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_byte_size_1))
ASYM(nbif_byte_size_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(byte_size_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_byte_size_1))
	TYPE_FUNCTION(ASYM(nbif_byte_size_1))
#endif

#ifndef HAVE_nbif_bit_size_1
#define HAVE_nbif_bit_size_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_bit_size_1))
ASYM(nbif_bit_size_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(bit_size_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_bit_size_1))
	TYPE_FUNCTION(ASYM(nbif_bit_size_1))
#endif

#ifndef HAVE_nbif_list_to_bitstring_1
#define HAVE_nbif_list_to_bitstring_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_list_to_bitstring_1))
ASYM(nbif_list_to_bitstring_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(list_to_bitstring_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_list_to_bitstring_1))
	TYPE_FUNCTION(ASYM(nbif_list_to_bitstring_1))
#endif

#ifndef HAVE_nbif_bitstring_to_list_1
#define HAVE_nbif_bitstring_to_list_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_bitstring_to_list_1))
ASYM(nbif_bitstring_to_list_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(bitstring_to_list_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_bitstring_to_list_1))
	TYPE_FUNCTION(ASYM(nbif_bitstring_to_list_1))
#endif

#ifndef HAVE_nbif_ets_update_element_3
#define HAVE_nbif_ets_update_element_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ets_update_element_3))
ASYM(nbif_ets_update_element_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(ets_update_element_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ets_update_element_3))
	TYPE_FUNCTION(ASYM(nbif_ets_update_element_3))
#endif

#ifndef HAVE_nbif_decode_packet_3
#define HAVE_nbif_decode_packet_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_decode_packet_3))
ASYM(nbif_decode_packet_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(decode_packet_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_decode_packet_3))
	TYPE_FUNCTION(ASYM(nbif_decode_packet_3))
#endif

#ifndef HAVE_nbif_unicode_characters_to_binary_2
#define HAVE_nbif_unicode_characters_to_binary_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_unicode_characters_to_binary_2))
ASYM(nbif_unicode_characters_to_binary_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(unicode_characters_to_binary_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_unicode_characters_to_binary_2))
	TYPE_FUNCTION(ASYM(nbif_unicode_characters_to_binary_2))
#endif

#ifndef HAVE_nbif_unicode_characters_to_list_2
#define HAVE_nbif_unicode_characters_to_list_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_unicode_characters_to_list_2))
ASYM(nbif_unicode_characters_to_list_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(unicode_characters_to_list_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_unicode_characters_to_list_2))
	TYPE_FUNCTION(ASYM(nbif_unicode_characters_to_list_2))
#endif

#ifndef HAVE_nbif_unicode_bin_is_7bit_1
#define HAVE_nbif_unicode_bin_is_7bit_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_unicode_bin_is_7bit_1))
ASYM(nbif_unicode_bin_is_7bit_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(unicode_bin_is_7bit_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_unicode_bin_is_7bit_1))
	TYPE_FUNCTION(ASYM(nbif_unicode_bin_is_7bit_1))
#endif

#ifndef HAVE_nbif_atom_to_binary_2
#define HAVE_nbif_atom_to_binary_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_atom_to_binary_2))
ASYM(nbif_atom_to_binary_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(atom_to_binary_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_atom_to_binary_2))
	TYPE_FUNCTION(ASYM(nbif_atom_to_binary_2))
#endif

#ifndef HAVE_nbif_binary_to_atom_2
#define HAVE_nbif_binary_to_atom_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_binary_to_atom_2))
ASYM(nbif_binary_to_atom_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(binary_to_atom_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_binary_to_atom_2))
	TYPE_FUNCTION(ASYM(nbif_binary_to_atom_2))
#endif

#ifndef HAVE_nbif_binary_to_existing_atom_2
#define HAVE_nbif_binary_to_existing_atom_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_binary_to_existing_atom_2))
ASYM(nbif_binary_to_existing_atom_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(binary_to_existing_atom_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_binary_to_existing_atom_2))
	TYPE_FUNCTION(ASYM(nbif_binary_to_existing_atom_2))
#endif

#ifndef HAVE_nbif_net_kernel_dflag_unicode_io_1
#define HAVE_nbif_net_kernel_dflag_unicode_io_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_net_kernel_dflag_unicode_io_1))
ASYM(nbif_net_kernel_dflag_unicode_io_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(net_kernel_dflag_unicode_io_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_net_kernel_dflag_unicode_io_1))
	TYPE_FUNCTION(ASYM(nbif_net_kernel_dflag_unicode_io_1))
#endif

#ifndef HAVE_nbif_ets_give_away_3
#define HAVE_nbif_ets_give_away_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ets_give_away_3))
ASYM(nbif_ets_give_away_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(ets_give_away_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ets_give_away_3))
	TYPE_FUNCTION(ASYM(nbif_ets_give_away_3))
#endif

#ifndef HAVE_nbif_ets_setopts_2
#define HAVE_nbif_ets_setopts_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ets_setopts_2))
ASYM(nbif_ets_setopts_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(ets_setopts_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ets_setopts_2))
	TYPE_FUNCTION(ASYM(nbif_ets_setopts_2))
#endif

#ifndef HAVE_nbif_load_nif_2
#define HAVE_nbif_load_nif_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_load_nif_2))
ASYM(nbif_load_nif_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(load_nif_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_load_nif_2))
	TYPE_FUNCTION(ASYM(nbif_load_nif_2))
#endif

#ifndef HAVE_nbif_call_on_load_function_1
#define HAVE_nbif_call_on_load_function_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_call_on_load_function_1))
ASYM(nbif_call_on_load_function_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(call_on_load_function_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_call_on_load_function_1))
	TYPE_FUNCTION(ASYM(nbif_call_on_load_function_1))
#endif

#ifndef HAVE_nbif_finish_after_on_load_2
#define HAVE_nbif_finish_after_on_load_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_finish_after_on_load_2))
ASYM(nbif_finish_after_on_load_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(finish_after_on_load_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_finish_after_on_load_2))
	TYPE_FUNCTION(ASYM(nbif_finish_after_on_load_2))
#endif

#ifndef HAVE_nbif_binary_to_term_2
#define HAVE_nbif_binary_to_term_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_binary_to_term_2))
ASYM(nbif_binary_to_term_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(binary_to_term_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_binary_to_term_2))
	TYPE_FUNCTION(ASYM(nbif_binary_to_term_2))
#endif

#ifndef HAVE_nbif_binary_part_2
#define HAVE_nbif_binary_part_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_binary_part_2))
ASYM(nbif_binary_part_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(binary_part_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_binary_part_2))
	TYPE_FUNCTION(ASYM(nbif_binary_part_2))
#endif

#ifndef HAVE_nbif_binary_part_3
#define HAVE_nbif_binary_part_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_binary_part_3))
ASYM(nbif_binary_part_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(binary_part_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_binary_part_3))
	TYPE_FUNCTION(ASYM(nbif_binary_part_3))
#endif

#ifndef HAVE_nbif_binary_compile_pattern_1
#define HAVE_nbif_binary_compile_pattern_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_binary_compile_pattern_1))
ASYM(nbif_binary_compile_pattern_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(binary_compile_pattern_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_binary_compile_pattern_1))
	TYPE_FUNCTION(ASYM(nbif_binary_compile_pattern_1))
#endif

#ifndef HAVE_nbif_binary_match_2
#define HAVE_nbif_binary_match_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_binary_match_2))
ASYM(nbif_binary_match_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(binary_match_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_binary_match_2))
	TYPE_FUNCTION(ASYM(nbif_binary_match_2))
#endif

#ifndef HAVE_nbif_binary_match_3
#define HAVE_nbif_binary_match_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_binary_match_3))
ASYM(nbif_binary_match_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(binary_match_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_binary_match_3))
	TYPE_FUNCTION(ASYM(nbif_binary_match_3))
#endif

#ifndef HAVE_nbif_binary_matches_2
#define HAVE_nbif_binary_matches_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_binary_matches_2))
ASYM(nbif_binary_matches_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(binary_matches_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_binary_matches_2))
	TYPE_FUNCTION(ASYM(nbif_binary_matches_2))
#endif

#ifndef HAVE_nbif_binary_matches_3
#define HAVE_nbif_binary_matches_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_binary_matches_3))
ASYM(nbif_binary_matches_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(binary_matches_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_binary_matches_3))
	TYPE_FUNCTION(ASYM(nbif_binary_matches_3))
#endif

#ifndef HAVE_nbif_binary_longest_common_prefix_1
#define HAVE_nbif_binary_longest_common_prefix_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_binary_longest_common_prefix_1))
ASYM(nbif_binary_longest_common_prefix_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(binary_longest_common_prefix_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_binary_longest_common_prefix_1))
	TYPE_FUNCTION(ASYM(nbif_binary_longest_common_prefix_1))
#endif

#ifndef HAVE_nbif_binary_longest_common_suffix_1
#define HAVE_nbif_binary_longest_common_suffix_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_binary_longest_common_suffix_1))
ASYM(nbif_binary_longest_common_suffix_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(binary_longest_common_suffix_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_binary_longest_common_suffix_1))
	TYPE_FUNCTION(ASYM(nbif_binary_longest_common_suffix_1))
#endif

#ifndef HAVE_nbif_binary_first_1
#define HAVE_nbif_binary_first_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_binary_first_1))
ASYM(nbif_binary_first_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(binary_first_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_binary_first_1))
	TYPE_FUNCTION(ASYM(nbif_binary_first_1))
#endif

#ifndef HAVE_nbif_binary_last_1
#define HAVE_nbif_binary_last_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_binary_last_1))
ASYM(nbif_binary_last_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(binary_last_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_binary_last_1))
	TYPE_FUNCTION(ASYM(nbif_binary_last_1))
#endif

#ifndef HAVE_nbif_binary_at_2
#define HAVE_nbif_binary_at_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_binary_at_2))
ASYM(nbif_binary_at_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(binary_at_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_binary_at_2))
	TYPE_FUNCTION(ASYM(nbif_binary_at_2))
#endif

#ifndef HAVE_nbif_binary_binary_part_2
#define HAVE_nbif_binary_binary_part_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_binary_binary_part_2))
ASYM(nbif_binary_binary_part_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(binary_binary_part_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_binary_binary_part_2))
	TYPE_FUNCTION(ASYM(nbif_binary_binary_part_2))
#endif

#ifndef HAVE_nbif_binary_binary_part_3
#define HAVE_nbif_binary_binary_part_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_binary_binary_part_3))
ASYM(nbif_binary_binary_part_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(binary_binary_part_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_binary_binary_part_3))
	TYPE_FUNCTION(ASYM(nbif_binary_binary_part_3))
#endif

#ifndef HAVE_nbif_binary_list_to_bin_1
#define HAVE_nbif_binary_list_to_bin_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_binary_list_to_bin_1))
ASYM(nbif_binary_list_to_bin_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(binary_list_to_bin_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_binary_list_to_bin_1))
	TYPE_FUNCTION(ASYM(nbif_binary_list_to_bin_1))
#endif

#ifndef HAVE_nbif_binary_copy_1
#define HAVE_nbif_binary_copy_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_binary_copy_1))
ASYM(nbif_binary_copy_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(binary_copy_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_binary_copy_1))
	TYPE_FUNCTION(ASYM(nbif_binary_copy_1))
#endif

#ifndef HAVE_nbif_binary_copy_2
#define HAVE_nbif_binary_copy_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_binary_copy_2))
ASYM(nbif_binary_copy_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(binary_copy_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_binary_copy_2))
	TYPE_FUNCTION(ASYM(nbif_binary_copy_2))
#endif

#ifndef HAVE_nbif_binary_referenced_byte_size_1
#define HAVE_nbif_binary_referenced_byte_size_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_binary_referenced_byte_size_1))
ASYM(nbif_binary_referenced_byte_size_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(binary_referenced_byte_size_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_binary_referenced_byte_size_1))
	TYPE_FUNCTION(ASYM(nbif_binary_referenced_byte_size_1))
#endif

#ifndef HAVE_nbif_binary_encode_unsigned_1
#define HAVE_nbif_binary_encode_unsigned_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_binary_encode_unsigned_1))
ASYM(nbif_binary_encode_unsigned_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(binary_encode_unsigned_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_binary_encode_unsigned_1))
	TYPE_FUNCTION(ASYM(nbif_binary_encode_unsigned_1))
#endif

#ifndef HAVE_nbif_binary_encode_unsigned_2
#define HAVE_nbif_binary_encode_unsigned_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_binary_encode_unsigned_2))
ASYM(nbif_binary_encode_unsigned_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(binary_encode_unsigned_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_binary_encode_unsigned_2))
	TYPE_FUNCTION(ASYM(nbif_binary_encode_unsigned_2))
#endif

#ifndef HAVE_nbif_binary_decode_unsigned_1
#define HAVE_nbif_binary_decode_unsigned_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_binary_decode_unsigned_1))
ASYM(nbif_binary_decode_unsigned_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(binary_decode_unsigned_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_binary_decode_unsigned_1))
	TYPE_FUNCTION(ASYM(nbif_binary_decode_unsigned_1))
#endif

#ifndef HAVE_nbif_binary_decode_unsigned_2
#define HAVE_nbif_binary_decode_unsigned_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_binary_decode_unsigned_2))
ASYM(nbif_binary_decode_unsigned_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(binary_decode_unsigned_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_binary_decode_unsigned_2))
	TYPE_FUNCTION(ASYM(nbif_binary_decode_unsigned_2))
#endif

#ifndef HAVE_nbif_nif_error_1
#define HAVE_nbif_nif_error_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_nif_error_1))
ASYM(nbif_nif_error_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(nif_error_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_nif_error_1))
	TYPE_FUNCTION(ASYM(nbif_nif_error_1))
#endif

#ifndef HAVE_nbif_nif_error_2
#define HAVE_nbif_nif_error_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_nif_error_2))
ASYM(nbif_nif_error_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(nif_error_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_nif_error_2))
	TYPE_FUNCTION(ASYM(nbif_nif_error_2))
#endif

#ifndef HAVE_nbif_prim_file_internal_name2native_1
#define HAVE_nbif_prim_file_internal_name2native_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_prim_file_internal_name2native_1))
ASYM(nbif_prim_file_internal_name2native_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(prim_file_internal_name2native_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_prim_file_internal_name2native_1))
	TYPE_FUNCTION(ASYM(nbif_prim_file_internal_name2native_1))
#endif

#ifndef HAVE_nbif_prim_file_internal_native2name_1
#define HAVE_nbif_prim_file_internal_native2name_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_prim_file_internal_native2name_1))
ASYM(nbif_prim_file_internal_native2name_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(prim_file_internal_native2name_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_prim_file_internal_native2name_1))
	TYPE_FUNCTION(ASYM(nbif_prim_file_internal_native2name_1))
#endif

#ifndef HAVE_nbif_prim_file_internal_normalize_utf8_1
#define HAVE_nbif_prim_file_internal_normalize_utf8_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_prim_file_internal_normalize_utf8_1))
ASYM(nbif_prim_file_internal_normalize_utf8_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(prim_file_internal_normalize_utf8_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_prim_file_internal_normalize_utf8_1))
	TYPE_FUNCTION(ASYM(nbif_prim_file_internal_normalize_utf8_1))
#endif

#ifndef HAVE_nbif_prim_file_is_translatable_1
#define HAVE_nbif_prim_file_is_translatable_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_prim_file_is_translatable_1))
ASYM(nbif_prim_file_is_translatable_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(prim_file_is_translatable_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_prim_file_is_translatable_1))
	TYPE_FUNCTION(ASYM(nbif_prim_file_is_translatable_1))
#endif

#ifndef HAVE_nbif_file_native_name_encoding_0
#define HAVE_nbif_file_native_name_encoding_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_file_native_name_encoding_0))
ASYM(nbif_file_native_name_encoding_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(file_native_name_encoding_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_file_native_name_encoding_0))
	TYPE_FUNCTION(ASYM(nbif_file_native_name_encoding_0))
#endif

#ifndef HAVE_nbif_check_old_code_1
#define HAVE_nbif_check_old_code_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_check_old_code_1))
ASYM(nbif_check_old_code_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(check_old_code_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_check_old_code_1))
	TYPE_FUNCTION(ASYM(nbif_check_old_code_1))
#endif

#ifndef HAVE_nbif_universaltime_to_posixtime_1
#define HAVE_nbif_universaltime_to_posixtime_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_universaltime_to_posixtime_1))
ASYM(nbif_universaltime_to_posixtime_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(universaltime_to_posixtime_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_universaltime_to_posixtime_1))
	TYPE_FUNCTION(ASYM(nbif_universaltime_to_posixtime_1))
#endif

#ifndef HAVE_nbif_posixtime_to_universaltime_1
#define HAVE_nbif_posixtime_to_universaltime_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_posixtime_to_universaltime_1))
ASYM(nbif_posixtime_to_universaltime_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(posixtime_to_universaltime_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_posixtime_to_universaltime_1))
	TYPE_FUNCTION(ASYM(nbif_posixtime_to_universaltime_1))
#endif

#ifndef HAVE_nbif_dt_put_tag_1
#define HAVE_nbif_dt_put_tag_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_dt_put_tag_1))
ASYM(nbif_dt_put_tag_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(dt_put_tag_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_dt_put_tag_1))
	TYPE_FUNCTION(ASYM(nbif_dt_put_tag_1))
#endif

#ifndef HAVE_nbif_dt_get_tag_0
#define HAVE_nbif_dt_get_tag_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_dt_get_tag_0))
ASYM(nbif_dt_get_tag_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(dt_get_tag_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_dt_get_tag_0))
	TYPE_FUNCTION(ASYM(nbif_dt_get_tag_0))
#endif

#ifndef HAVE_nbif_dt_get_tag_data_0
#define HAVE_nbif_dt_get_tag_data_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_dt_get_tag_data_0))
ASYM(nbif_dt_get_tag_data_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(dt_get_tag_data_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_dt_get_tag_data_0))
	TYPE_FUNCTION(ASYM(nbif_dt_get_tag_data_0))
#endif

#ifndef HAVE_nbif_dt_spread_tag_1
#define HAVE_nbif_dt_spread_tag_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_dt_spread_tag_1))
ASYM(nbif_dt_spread_tag_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(dt_spread_tag_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_dt_spread_tag_1))
	TYPE_FUNCTION(ASYM(nbif_dt_spread_tag_1))
#endif

#ifndef HAVE_nbif_dt_restore_tag_1
#define HAVE_nbif_dt_restore_tag_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_dt_restore_tag_1))
ASYM(nbif_dt_restore_tag_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(dt_restore_tag_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_dt_restore_tag_1))
	TYPE_FUNCTION(ASYM(nbif_dt_restore_tag_1))
#endif

#ifndef HAVE_nbif_dt_prepend_vm_tag_data_1
#define HAVE_nbif_dt_prepend_vm_tag_data_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_dt_prepend_vm_tag_data_1))
ASYM(nbif_dt_prepend_vm_tag_data_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(dt_prepend_vm_tag_data_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_dt_prepend_vm_tag_data_1))
	TYPE_FUNCTION(ASYM(nbif_dt_prepend_vm_tag_data_1))
#endif

#ifndef HAVE_nbif_dt_append_vm_tag_data_1
#define HAVE_nbif_dt_append_vm_tag_data_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_dt_append_vm_tag_data_1))
ASYM(nbif_dt_append_vm_tag_data_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(dt_append_vm_tag_data_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_dt_append_vm_tag_data_1))
	TYPE_FUNCTION(ASYM(nbif_dt_append_vm_tag_data_1))
#endif

#ifndef HAVE_nbif_prepare_loading_2
#define HAVE_nbif_prepare_loading_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_prepare_loading_2))
ASYM(nbif_prepare_loading_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(prepare_loading_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_prepare_loading_2))
	TYPE_FUNCTION(ASYM(nbif_prepare_loading_2))
#endif

#ifndef HAVE_nbif_finish_loading_1
#define HAVE_nbif_finish_loading_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_finish_loading_1))
ASYM(nbif_finish_loading_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(finish_loading_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_finish_loading_1))
	TYPE_FUNCTION(ASYM(nbif_finish_loading_1))
#endif

#ifndef HAVE_nbif_insert_element_3
#define HAVE_nbif_insert_element_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_insert_element_3))
ASYM(nbif_insert_element_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(insert_element_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_insert_element_3))
	TYPE_FUNCTION(ASYM(nbif_insert_element_3))
#endif

#ifndef HAVE_nbif_delete_element_2
#define HAVE_nbif_delete_element_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_delete_element_2))
ASYM(nbif_delete_element_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(delete_element_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_delete_element_2))
	TYPE_FUNCTION(ASYM(nbif_delete_element_2))
#endif

#ifndef HAVE_nbif_binary_to_integer_1
#define HAVE_nbif_binary_to_integer_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_binary_to_integer_1))
ASYM(nbif_binary_to_integer_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(binary_to_integer_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_binary_to_integer_1))
	TYPE_FUNCTION(ASYM(nbif_binary_to_integer_1))
#endif

#ifndef HAVE_nbif_binary_to_integer_2
#define HAVE_nbif_binary_to_integer_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_binary_to_integer_2))
ASYM(nbif_binary_to_integer_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(binary_to_integer_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_binary_to_integer_2))
	TYPE_FUNCTION(ASYM(nbif_binary_to_integer_2))
#endif

#ifndef HAVE_nbif_integer_to_binary_1
#define HAVE_nbif_integer_to_binary_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_integer_to_binary_1))
ASYM(nbif_integer_to_binary_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(integer_to_binary_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_integer_to_binary_1))
	TYPE_FUNCTION(ASYM(nbif_integer_to_binary_1))
#endif

#ifndef HAVE_nbif_list_to_integer_2
#define HAVE_nbif_list_to_integer_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_list_to_integer_2))
ASYM(nbif_list_to_integer_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(list_to_integer_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_list_to_integer_2))
	TYPE_FUNCTION(ASYM(nbif_list_to_integer_2))
#endif

#ifndef HAVE_nbif_float_to_binary_1
#define HAVE_nbif_float_to_binary_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_float_to_binary_1))
ASYM(nbif_float_to_binary_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(float_to_binary_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_float_to_binary_1))
	TYPE_FUNCTION(ASYM(nbif_float_to_binary_1))
#endif

#ifndef HAVE_nbif_float_to_binary_2
#define HAVE_nbif_float_to_binary_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_float_to_binary_2))
ASYM(nbif_float_to_binary_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(float_to_binary_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_float_to_binary_2))
	TYPE_FUNCTION(ASYM(nbif_float_to_binary_2))
#endif

#ifndef HAVE_nbif_binary_to_float_1
#define HAVE_nbif_binary_to_float_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_binary_to_float_1))
ASYM(nbif_binary_to_float_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(binary_to_float_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_binary_to_float_1))
	TYPE_FUNCTION(ASYM(nbif_binary_to_float_1))
#endif

#ifndef HAVE_nbif_io_printable_range_0
#define HAVE_nbif_io_printable_range_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_io_printable_range_0))
ASYM(nbif_io_printable_range_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(io_printable_range_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_io_printable_range_0))
	TYPE_FUNCTION(ASYM(nbif_io_printable_range_0))
#endif

#ifndef HAVE_nbif_re_inspect_2
#define HAVE_nbif_re_inspect_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_re_inspect_2))
ASYM(nbif_re_inspect_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(re_inspect_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_re_inspect_2))
	TYPE_FUNCTION(ASYM(nbif_re_inspect_2))
#endif

#ifndef HAVE_nbif_is_map_1
#define HAVE_nbif_is_map_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_is_map_1))
ASYM(nbif_is_map_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(is_map_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_is_map_1))
	TYPE_FUNCTION(ASYM(nbif_is_map_1))
#endif

#ifndef HAVE_nbif_map_size_1
#define HAVE_nbif_map_size_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_map_size_1))
ASYM(nbif_map_size_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(map_size_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_map_size_1))
	TYPE_FUNCTION(ASYM(nbif_map_size_1))
#endif

#ifndef HAVE_nbif_maps_find_2
#define HAVE_nbif_maps_find_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_maps_find_2))
ASYM(nbif_maps_find_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(maps_find_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_maps_find_2))
	TYPE_FUNCTION(ASYM(nbif_maps_find_2))
#endif

#ifndef HAVE_nbif_maps_get_2
#define HAVE_nbif_maps_get_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_maps_get_2))
ASYM(nbif_maps_get_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(maps_get_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_maps_get_2))
	TYPE_FUNCTION(ASYM(nbif_maps_get_2))
#endif

#ifndef HAVE_nbif_maps_from_list_1
#define HAVE_nbif_maps_from_list_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_maps_from_list_1))
ASYM(nbif_maps_from_list_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(maps_from_list_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_maps_from_list_1))
	TYPE_FUNCTION(ASYM(nbif_maps_from_list_1))
#endif

#ifndef HAVE_nbif_maps_is_key_2
#define HAVE_nbif_maps_is_key_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_maps_is_key_2))
ASYM(nbif_maps_is_key_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(maps_is_key_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_maps_is_key_2))
	TYPE_FUNCTION(ASYM(nbif_maps_is_key_2))
#endif

#ifndef HAVE_nbif_maps_keys_1
#define HAVE_nbif_maps_keys_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_maps_keys_1))
ASYM(nbif_maps_keys_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(maps_keys_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_maps_keys_1))
	TYPE_FUNCTION(ASYM(nbif_maps_keys_1))
#endif

#ifndef HAVE_nbif_maps_merge_2
#define HAVE_nbif_maps_merge_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_maps_merge_2))
ASYM(nbif_maps_merge_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(maps_merge_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_maps_merge_2))
	TYPE_FUNCTION(ASYM(nbif_maps_merge_2))
#endif

#ifndef HAVE_nbif_maps_put_3
#define HAVE_nbif_maps_put_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_maps_put_3))
ASYM(nbif_maps_put_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(maps_put_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_maps_put_3))
	TYPE_FUNCTION(ASYM(nbif_maps_put_3))
#endif

#ifndef HAVE_nbif_maps_remove_2
#define HAVE_nbif_maps_remove_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_maps_remove_2))
ASYM(nbif_maps_remove_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(maps_remove_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_maps_remove_2))
	TYPE_FUNCTION(ASYM(nbif_maps_remove_2))
#endif

#ifndef HAVE_nbif_maps_update_3
#define HAVE_nbif_maps_update_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_maps_update_3))
ASYM(nbif_maps_update_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(maps_update_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_maps_update_3))
	TYPE_FUNCTION(ASYM(nbif_maps_update_3))
#endif

#ifndef HAVE_nbif_maps_values_1
#define HAVE_nbif_maps_values_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_maps_values_1))
ASYM(nbif_maps_values_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(maps_values_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_maps_values_1))
	TYPE_FUNCTION(ASYM(nbif_maps_values_1))
#endif

#ifndef HAVE_nbif_erts_internal_cmp_term_2
#define HAVE_nbif_erts_internal_cmp_term_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_cmp_term_2))
ASYM(nbif_erts_internal_cmp_term_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(erts_internal_cmp_term_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_cmp_term_2))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_cmp_term_2))
#endif

#ifndef HAVE_nbif_ets_take_2
#define HAVE_nbif_ets_take_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ets_take_2))
ASYM(nbif_ets_take_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(ets_take_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ets_take_2))
	TYPE_FUNCTION(ASYM(nbif_ets_take_2))
#endif

#ifndef HAVE_nbif_fun_info_mfa_1
#define HAVE_nbif_fun_info_mfa_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_fun_info_mfa_1))
ASYM(nbif_fun_info_mfa_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(fun_info_mfa_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_fun_info_mfa_1))
	TYPE_FUNCTION(ASYM(nbif_fun_info_mfa_1))
#endif

#ifndef HAVE_nbif_get_keys_0
#define HAVE_nbif_get_keys_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_get_keys_0))
ASYM(nbif_get_keys_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(get_keys_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_get_keys_0))
	TYPE_FUNCTION(ASYM(nbif_get_keys_0))
#endif

#ifndef HAVE_nbif_ets_update_counter_4
#define HAVE_nbif_ets_update_counter_4
	TEXT
	.align  4
	GLOBAL(ASYM(nbif_ets_update_counter_4))
ASYM(nbif_ets_update_counter_4):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx
	# movq	%r8, %r8

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%r8
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(ets_update_counter_4)
	add	$(4*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_4_simple_exception
	NSP_RET0
	
3:	call nbif_4_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ets_update_counter_4))
	TYPE_FUNCTION(ASYM(nbif_ets_update_counter_4))
#endif

#ifndef HAVE_nbif_erts_debug_map_info_1
#define HAVE_nbif_erts_debug_map_info_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_debug_map_info_1))
ASYM(nbif_erts_debug_map_info_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(erts_debug_map_info_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_debug_map_info_1))
	TYPE_FUNCTION(ASYM(nbif_erts_debug_map_info_1))
#endif

#ifndef HAVE_nbif_erts_internal_is_process_executing_dirty_1
#define HAVE_nbif_erts_internal_is_process_executing_dirty_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_is_process_executing_dirty_1))
ASYM(nbif_erts_internal_is_process_executing_dirty_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(erts_internal_is_process_executing_dirty_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_is_process_executing_dirty_1))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_is_process_executing_dirty_1))
#endif

#ifndef HAVE_nbif_erts_internal_check_dirty_process_code_2
#define HAVE_nbif_erts_internal_check_dirty_process_code_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_check_dirty_process_code_2))
ASYM(nbif_erts_internal_check_dirty_process_code_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(erts_internal_check_dirty_process_code_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_check_dirty_process_code_2))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_check_dirty_process_code_2))
#endif

#ifndef HAVE_nbif_erts_internal_purge_module_2
#define HAVE_nbif_erts_internal_purge_module_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_purge_module_2))
ASYM(nbif_erts_internal_purge_module_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(erts_internal_purge_module_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_purge_module_2))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_purge_module_2))
#endif

#ifndef HAVE_nbif_binary_split_2
#define HAVE_nbif_binary_split_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_binary_split_2))
ASYM(nbif_binary_split_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(binary_split_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_binary_split_2))
	TYPE_FUNCTION(ASYM(nbif_binary_split_2))
#endif

#ifndef HAVE_nbif_binary_split_3
#define HAVE_nbif_binary_split_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_binary_split_3))
ASYM(nbif_binary_split_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(binary_split_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_binary_split_3))
	TYPE_FUNCTION(ASYM(nbif_binary_split_3))
#endif

#ifndef HAVE_nbif_erts_debug_size_shared_1
#define HAVE_nbif_erts_debug_size_shared_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_debug_size_shared_1))
ASYM(nbif_erts_debug_size_shared_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(erts_debug_size_shared_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_debug_size_shared_1))
	TYPE_FUNCTION(ASYM(nbif_erts_debug_size_shared_1))
#endif

#ifndef HAVE_nbif_erts_debug_copy_shared_1
#define HAVE_nbif_erts_debug_copy_shared_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_debug_copy_shared_1))
ASYM(nbif_erts_debug_copy_shared_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(erts_debug_copy_shared_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_debug_copy_shared_1))
	TYPE_FUNCTION(ASYM(nbif_erts_debug_copy_shared_1))
#endif

#ifndef HAVE_nbif_has_prepared_code_on_load_1
#define HAVE_nbif_has_prepared_code_on_load_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_has_prepared_code_on_load_1))
ASYM(nbif_has_prepared_code_on_load_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(has_prepared_code_on_load_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_has_prepared_code_on_load_1))
	TYPE_FUNCTION(ASYM(nbif_has_prepared_code_on_load_1))
#endif

#ifndef HAVE_nbif_maps_take_2
#define HAVE_nbif_maps_take_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_maps_take_2))
ASYM(nbif_maps_take_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(maps_take_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_maps_take_2))
	TYPE_FUNCTION(ASYM(nbif_maps_take_2))
#endif

#ifndef HAVE_nbif_floor_1
#define HAVE_nbif_floor_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_floor_1))
ASYM(nbif_floor_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(floor_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_floor_1))
	TYPE_FUNCTION(ASYM(nbif_floor_1))
#endif

#ifndef HAVE_nbif_ceil_1
#define HAVE_nbif_ceil_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ceil_1))
ASYM(nbif_ceil_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(ceil_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ceil_1))
	TYPE_FUNCTION(ASYM(nbif_ceil_1))
#endif

#ifndef HAVE_nbif_math_floor_1
#define HAVE_nbif_math_floor_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_math_floor_1))
ASYM(nbif_math_floor_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(math_floor_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_math_floor_1))
	TYPE_FUNCTION(ASYM(nbif_math_floor_1))
#endif

#ifndef HAVE_nbif_math_ceil_1
#define HAVE_nbif_math_ceil_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_math_ceil_1))
ASYM(nbif_math_ceil_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(math_ceil_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_math_ceil_1))
	TYPE_FUNCTION(ASYM(nbif_math_ceil_1))
#endif

#ifndef HAVE_nbif_math_fmod_2
#define HAVE_nbif_math_fmod_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_math_fmod_2))
ASYM(nbif_math_fmod_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(math_fmod_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_math_fmod_2))
	TYPE_FUNCTION(ASYM(nbif_math_fmod_2))
#endif

#ifndef HAVE_nbif_os_set_signal_2
#define HAVE_nbif_os_set_signal_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_os_set_signal_2))
ASYM(nbif_os_set_signal_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(os_set_signal_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_os_set_signal_2))
	TYPE_FUNCTION(ASYM(nbif_os_set_signal_2))
#endif

#ifndef HAVE_nbif_iolist_to_iovec_1
#define HAVE_nbif_iolist_to_iovec_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_iolist_to_iovec_1))
ASYM(nbif_iolist_to_iovec_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(iolist_to_iovec_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_iolist_to_iovec_1))
	TYPE_FUNCTION(ASYM(nbif_iolist_to_iovec_1))
#endif

#ifndef HAVE_nbif_erts_internal_get_dflags_0
#define HAVE_nbif_erts_internal_get_dflags_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_get_dflags_0))
ASYM(nbif_erts_internal_get_dflags_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(erts_internal_get_dflags_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_get_dflags_0))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_get_dflags_0))
#endif

#ifndef HAVE_nbif_erts_internal_new_connection_1
#define HAVE_nbif_erts_internal_new_connection_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_new_connection_1))
ASYM(nbif_erts_internal_new_connection_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(erts_internal_new_connection_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_new_connection_1))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_new_connection_1))
#endif

#ifndef HAVE_nbif_erts_internal_map_next_3
#define HAVE_nbif_erts_internal_map_next_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_map_next_3))
ASYM(nbif_erts_internal_map_next_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(erts_internal_map_next_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_map_next_3))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_map_next_3))
#endif

#ifndef HAVE_nbif_ets_whereis_1
#define HAVE_nbif_ets_whereis_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ets_whereis_1))
ASYM(nbif_ets_whereis_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(ets_whereis_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ets_whereis_1))
	TYPE_FUNCTION(ASYM(nbif_ets_whereis_1))
#endif

#ifndef HAVE_nbif_erts_internal_gather_alloc_histograms_1
#define HAVE_nbif_erts_internal_gather_alloc_histograms_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_gather_alloc_histograms_1))
ASYM(nbif_erts_internal_gather_alloc_histograms_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(erts_internal_gather_alloc_histograms_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_gather_alloc_histograms_1))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_gather_alloc_histograms_1))
#endif

#ifndef HAVE_nbif_erts_internal_gather_carrier_info_1
#define HAVE_nbif_erts_internal_gather_carrier_info_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_gather_carrier_info_1))
ASYM(nbif_erts_internal_gather_carrier_info_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(erts_internal_gather_carrier_info_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_gather_carrier_info_1))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_gather_carrier_info_1))
#endif

#ifndef HAVE_nbif_map_get_2
#define HAVE_nbif_map_get_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_map_get_2))
ASYM(nbif_map_get_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(map_get_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_map_get_2))
	TYPE_FUNCTION(ASYM(nbif_map_get_2))
#endif

#ifndef HAVE_nbif_is_map_key_2
#define HAVE_nbif_is_map_key_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_is_map_key_2))
ASYM(nbif_is_map_key_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(is_map_key_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_is_map_key_2))
	TYPE_FUNCTION(ASYM(nbif_is_map_key_2))
#endif

#ifndef HAVE_nbif_ets_internal_delete_all_2
#define HAVE_nbif_ets_internal_delete_all_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ets_internal_delete_all_2))
ASYM(nbif_ets_internal_delete_all_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(ets_internal_delete_all_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ets_internal_delete_all_2))
	TYPE_FUNCTION(ASYM(nbif_ets_internal_delete_all_2))
#endif

#ifndef HAVE_nbif_ets_internal_select_delete_2
#define HAVE_nbif_ets_internal_select_delete_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_ets_internal_select_delete_2))
ASYM(nbif_ets_internal_select_delete_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(ets_internal_select_delete_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_ets_internal_select_delete_2))
	TYPE_FUNCTION(ASYM(nbif_ets_internal_select_delete_2))
#endif

#ifndef HAVE_nbif_persistent_term_put_2
#define HAVE_nbif_persistent_term_put_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_persistent_term_put_2))
ASYM(nbif_persistent_term_put_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(persistent_term_put_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_persistent_term_put_2))
	TYPE_FUNCTION(ASYM(nbif_persistent_term_put_2))
#endif

#ifndef HAVE_nbif_persistent_term_get_1
#define HAVE_nbif_persistent_term_get_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_persistent_term_get_1))
ASYM(nbif_persistent_term_get_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(persistent_term_get_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_persistent_term_get_1))
	TYPE_FUNCTION(ASYM(nbif_persistent_term_get_1))
#endif

#ifndef HAVE_nbif_persistent_term_get_0
#define HAVE_nbif_persistent_term_get_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_persistent_term_get_0))
ASYM(nbif_persistent_term_get_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(persistent_term_get_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_persistent_term_get_0))
	TYPE_FUNCTION(ASYM(nbif_persistent_term_get_0))
#endif

#ifndef HAVE_nbif_persistent_term_erase_1
#define HAVE_nbif_persistent_term_erase_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_persistent_term_erase_1))
ASYM(nbif_persistent_term_erase_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(persistent_term_erase_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_persistent_term_erase_1))
	TYPE_FUNCTION(ASYM(nbif_persistent_term_erase_1))
#endif

#ifndef HAVE_nbif_persistent_term_info_0
#define HAVE_nbif_persistent_term_info_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_persistent_term_info_0))
ASYM(nbif_persistent_term_info_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(persistent_term_info_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_persistent_term_info_0))
	TYPE_FUNCTION(ASYM(nbif_persistent_term_info_0))
#endif

#ifndef HAVE_nbif_erts_internal_erase_persistent_terms_0
#define HAVE_nbif_erts_internal_erase_persistent_terms_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_erase_persistent_terms_0))
ASYM(nbif_erts_internal_erase_persistent_terms_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(erts_internal_erase_persistent_terms_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_erase_persistent_terms_0))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_erase_persistent_terms_0))
#endif

#ifndef HAVE_nbif_erts_internal_atomics_new_2
#define HAVE_nbif_erts_internal_atomics_new_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_atomics_new_2))
ASYM(nbif_erts_internal_atomics_new_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(erts_internal_atomics_new_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_atomics_new_2))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_atomics_new_2))
#endif

#ifndef HAVE_nbif_atomics_get_2
#define HAVE_nbif_atomics_get_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_atomics_get_2))
ASYM(nbif_atomics_get_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(atomics_get_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_atomics_get_2))
	TYPE_FUNCTION(ASYM(nbif_atomics_get_2))
#endif

#ifndef HAVE_nbif_atomics_put_3
#define HAVE_nbif_atomics_put_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_atomics_put_3))
ASYM(nbif_atomics_put_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(atomics_put_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_atomics_put_3))
	TYPE_FUNCTION(ASYM(nbif_atomics_put_3))
#endif

#ifndef HAVE_nbif_atomics_add_3
#define HAVE_nbif_atomics_add_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_atomics_add_3))
ASYM(nbif_atomics_add_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(atomics_add_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_atomics_add_3))
	TYPE_FUNCTION(ASYM(nbif_atomics_add_3))
#endif

#ifndef HAVE_nbif_atomics_add_get_3
#define HAVE_nbif_atomics_add_get_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_atomics_add_get_3))
ASYM(nbif_atomics_add_get_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(atomics_add_get_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_atomics_add_get_3))
	TYPE_FUNCTION(ASYM(nbif_atomics_add_get_3))
#endif

#ifndef HAVE_nbif_atomics_exchange_3
#define HAVE_nbif_atomics_exchange_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_atomics_exchange_3))
ASYM(nbif_atomics_exchange_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(atomics_exchange_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_atomics_exchange_3))
	TYPE_FUNCTION(ASYM(nbif_atomics_exchange_3))
#endif

#ifndef HAVE_nbif_atomics_compare_exchange_4
#define HAVE_nbif_atomics_compare_exchange_4
	TEXT
	.align  4
	GLOBAL(ASYM(nbif_atomics_compare_exchange_4))
ASYM(nbif_atomics_compare_exchange_4):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx
	# movq	%r8, %r8

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%r8
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(atomics_compare_exchange_4)
	add	$(4*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_4_simple_exception
	NSP_RET0
	
3:	call nbif_4_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_atomics_compare_exchange_4))
	TYPE_FUNCTION(ASYM(nbif_atomics_compare_exchange_4))
#endif

#ifndef HAVE_nbif_atomics_info_1
#define HAVE_nbif_atomics_info_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_atomics_info_1))
ASYM(nbif_atomics_info_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(atomics_info_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_atomics_info_1))
	TYPE_FUNCTION(ASYM(nbif_atomics_info_1))
#endif

#ifndef HAVE_nbif_erts_internal_counters_new_1
#define HAVE_nbif_erts_internal_counters_new_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_counters_new_1))
ASYM(nbif_erts_internal_counters_new_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(erts_internal_counters_new_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_counters_new_1))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_counters_new_1))
#endif

#ifndef HAVE_nbif_erts_internal_counters_get_2
#define HAVE_nbif_erts_internal_counters_get_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_counters_get_2))
ASYM(nbif_erts_internal_counters_get_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(erts_internal_counters_get_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_counters_get_2))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_counters_get_2))
#endif

#ifndef HAVE_nbif_erts_internal_counters_add_3
#define HAVE_nbif_erts_internal_counters_add_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_counters_add_3))
ASYM(nbif_erts_internal_counters_add_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(erts_internal_counters_add_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_counters_add_3))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_counters_add_3))
#endif

#ifndef HAVE_nbif_erts_internal_counters_put_3
#define HAVE_nbif_erts_internal_counters_put_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_counters_put_3))
ASYM(nbif_erts_internal_counters_put_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(erts_internal_counters_put_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_counters_put_3))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_counters_put_3))
#endif

#ifndef HAVE_nbif_erts_internal_counters_info_1
#define HAVE_nbif_erts_internal_counters_info_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_counters_info_1))
ASYM(nbif_erts_internal_counters_info_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(erts_internal_counters_info_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_counters_info_1))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_counters_info_1))
#endif

#ifndef HAVE_nbif_erts_internal_spawn_system_process_3
#define HAVE_nbif_erts_internal_spawn_system_process_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_spawn_system_process_3))
ASYM(nbif_erts_internal_spawn_system_process_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(erts_internal_spawn_system_process_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_spawn_system_process_3))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_spawn_system_process_3))
#endif

#ifndef HAVE_nbif_integer_to_list_2
#define HAVE_nbif_integer_to_list_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_integer_to_list_2))
ASYM(nbif_integer_to_list_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(integer_to_list_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_integer_to_list_2))
	TYPE_FUNCTION(ASYM(nbif_integer_to_list_2))
#endif

#ifndef HAVE_nbif_integer_to_binary_2
#define HAVE_nbif_integer_to_binary_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_integer_to_binary_2))
ASYM(nbif_integer_to_binary_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(integer_to_binary_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_integer_to_binary_2))
	TYPE_FUNCTION(ASYM(nbif_integer_to_binary_2))
#endif

#ifndef HAVE_nbif_persistent_term_get_2
#define HAVE_nbif_persistent_term_get_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_persistent_term_get_2))
ASYM(nbif_persistent_term_get_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(persistent_term_get_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_persistent_term_get_2))
	TYPE_FUNCTION(ASYM(nbif_persistent_term_get_2))
#endif

#ifndef HAVE_nbif_erts_internal_ets_lookup_binary_info_2
#define HAVE_nbif_erts_internal_ets_lookup_binary_info_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_ets_lookup_binary_info_2))
ASYM(nbif_erts_internal_ets_lookup_binary_info_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(erts_internal_ets_lookup_binary_info_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_ets_lookup_binary_info_2))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_ets_lookup_binary_info_2))
#endif

#ifndef HAVE_nbif_erts_internal_ets_raw_first_1
#define HAVE_nbif_erts_internal_ets_raw_first_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_ets_raw_first_1))
ASYM(nbif_erts_internal_ets_raw_first_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(erts_internal_ets_raw_first_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_ets_raw_first_1))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_ets_raw_first_1))
#endif

#ifndef HAVE_nbif_erts_internal_ets_raw_next_2
#define HAVE_nbif_erts_internal_ets_raw_next_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_ets_raw_next_2))
ASYM(nbif_erts_internal_ets_raw_next_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(erts_internal_ets_raw_next_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_ets_raw_next_2))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_ets_raw_next_2))
#endif

#ifndef HAVE_nbif_erts_internal_abort_pending_connection_2
#define HAVE_nbif_erts_internal_abort_pending_connection_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_erts_internal_abort_pending_connection_2))
ASYM(nbif_erts_internal_abort_pending_connection_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(erts_internal_abort_pending_connection_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_erts_internal_abort_pending_connection_2))
	TYPE_FUNCTION(ASYM(nbif_erts_internal_abort_pending_connection_2))
#endif

#ifndef HAVE_nbif_hipe_bifs_write_u8_2
#define HAVE_nbif_hipe_bifs_write_u8_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_write_u8_2))
ASYM(nbif_hipe_bifs_write_u8_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(hipe_bifs_write_u8_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_write_u8_2))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_write_u8_2))
#endif

#ifndef HAVE_nbif_hipe_bifs_write_u32_2
#define HAVE_nbif_hipe_bifs_write_u32_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_write_u32_2))
ASYM(nbif_hipe_bifs_write_u32_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(hipe_bifs_write_u32_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_write_u32_2))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_write_u32_2))
#endif

#ifndef HAVE_nbif_hipe_bifs_bytearray_2
#define HAVE_nbif_hipe_bifs_bytearray_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_bytearray_2))
ASYM(nbif_hipe_bifs_bytearray_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(hipe_bifs_bytearray_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_bytearray_2))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_bytearray_2))
#endif

#ifndef HAVE_nbif_hipe_bifs_bytearray_sub_2
#define HAVE_nbif_hipe_bifs_bytearray_sub_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_bytearray_sub_2))
ASYM(nbif_hipe_bifs_bytearray_sub_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(hipe_bifs_bytearray_sub_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_bytearray_sub_2))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_bytearray_sub_2))
#endif

#ifndef HAVE_nbif_hipe_bifs_bytearray_update_3
#define HAVE_nbif_hipe_bifs_bytearray_update_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_bytearray_update_3))
ASYM(nbif_hipe_bifs_bytearray_update_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(hipe_bifs_bytearray_update_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_bytearray_update_3))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_bytearray_update_3))
#endif

#ifndef HAVE_nbif_hipe_bifs_bitarray_2
#define HAVE_nbif_hipe_bifs_bitarray_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_bitarray_2))
ASYM(nbif_hipe_bifs_bitarray_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(hipe_bifs_bitarray_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_bitarray_2))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_bitarray_2))
#endif

#ifndef HAVE_nbif_hipe_bifs_bitarray_sub_2
#define HAVE_nbif_hipe_bifs_bitarray_sub_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_bitarray_sub_2))
ASYM(nbif_hipe_bifs_bitarray_sub_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(hipe_bifs_bitarray_sub_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_bitarray_sub_2))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_bitarray_sub_2))
#endif

#ifndef HAVE_nbif_hipe_bifs_bitarray_update_3
#define HAVE_nbif_hipe_bifs_bitarray_update_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_bitarray_update_3))
ASYM(nbif_hipe_bifs_bitarray_update_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(hipe_bifs_bitarray_update_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_bitarray_update_3))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_bitarray_update_3))
#endif

#ifndef HAVE_nbif_hipe_bifs_array_2
#define HAVE_nbif_hipe_bifs_array_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_array_2))
ASYM(nbif_hipe_bifs_array_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(hipe_bifs_array_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_array_2))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_array_2))
#endif

#ifndef HAVE_nbif_hipe_bifs_array_length_1
#define HAVE_nbif_hipe_bifs_array_length_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_array_length_1))
ASYM(nbif_hipe_bifs_array_length_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(hipe_bifs_array_length_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_array_length_1))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_array_length_1))
#endif

#ifndef HAVE_nbif_hipe_bifs_array_sub_2
#define HAVE_nbif_hipe_bifs_array_sub_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_array_sub_2))
ASYM(nbif_hipe_bifs_array_sub_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(hipe_bifs_array_sub_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_array_sub_2))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_array_sub_2))
#endif

#ifndef HAVE_nbif_hipe_bifs_array_update_3
#define HAVE_nbif_hipe_bifs_array_update_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_array_update_3))
ASYM(nbif_hipe_bifs_array_update_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(hipe_bifs_array_update_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_array_update_3))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_array_update_3))
#endif

#ifndef HAVE_nbif_hipe_bifs_ref_1
#define HAVE_nbif_hipe_bifs_ref_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_ref_1))
ASYM(nbif_hipe_bifs_ref_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(hipe_bifs_ref_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_ref_1))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_ref_1))
#endif

#ifndef HAVE_nbif_hipe_bifs_ref_get_1
#define HAVE_nbif_hipe_bifs_ref_get_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_ref_get_1))
ASYM(nbif_hipe_bifs_ref_get_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(hipe_bifs_ref_get_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_ref_get_1))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_ref_get_1))
#endif

#ifndef HAVE_nbif_hipe_bifs_ref_set_2
#define HAVE_nbif_hipe_bifs_ref_set_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_ref_set_2))
ASYM(nbif_hipe_bifs_ref_set_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(hipe_bifs_ref_set_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_ref_set_2))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_ref_set_2))
#endif

#ifndef HAVE_nbif_hipe_bifs_enter_code_3
#define HAVE_nbif_hipe_bifs_enter_code_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_enter_code_3))
ASYM(nbif_hipe_bifs_enter_code_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(hipe_bifs_enter_code_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_enter_code_3))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_enter_code_3))
#endif

#ifndef HAVE_nbif_hipe_bifs_alloc_data_3
#define HAVE_nbif_hipe_bifs_alloc_data_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_alloc_data_3))
ASYM(nbif_hipe_bifs_alloc_data_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(hipe_bifs_alloc_data_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_alloc_data_3))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_alloc_data_3))
#endif

#ifndef HAVE_nbif_hipe_bifs_constants_size_0
#define HAVE_nbif_hipe_bifs_constants_size_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_constants_size_0))
ASYM(nbif_hipe_bifs_constants_size_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(hipe_bifs_constants_size_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_constants_size_0))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_constants_size_0))
#endif

#ifndef HAVE_nbif_hipe_bifs_merge_term_1
#define HAVE_nbif_hipe_bifs_merge_term_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_merge_term_1))
ASYM(nbif_hipe_bifs_merge_term_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(hipe_bifs_merge_term_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_merge_term_1))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_merge_term_1))
#endif

#ifndef HAVE_nbif_hipe_bifs_fun_to_address_1
#define HAVE_nbif_hipe_bifs_fun_to_address_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_fun_to_address_1))
ASYM(nbif_hipe_bifs_fun_to_address_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(hipe_bifs_fun_to_address_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_fun_to_address_1))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_fun_to_address_1))
#endif

#ifndef HAVE_nbif_hipe_bifs_commit_patch_load_1
#define HAVE_nbif_hipe_bifs_commit_patch_load_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_commit_patch_load_1))
ASYM(nbif_hipe_bifs_commit_patch_load_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(hipe_bifs_commit_patch_load_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_commit_patch_load_1))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_commit_patch_load_1))
#endif

#ifndef HAVE_nbif_hipe_bifs_set_native_address_3
#define HAVE_nbif_hipe_bifs_set_native_address_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_set_native_address_3))
ASYM(nbif_hipe_bifs_set_native_address_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(hipe_bifs_set_native_address_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_set_native_address_3))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_set_native_address_3))
#endif

#ifndef HAVE_nbif_hipe_bifs_set_funinfo_native_address_3
#define HAVE_nbif_hipe_bifs_set_funinfo_native_address_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_set_funinfo_native_address_3))
ASYM(nbif_hipe_bifs_set_funinfo_native_address_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(hipe_bifs_set_funinfo_native_address_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_set_funinfo_native_address_3))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_set_funinfo_native_address_3))
#endif

#ifndef HAVE_nbif_hipe_bifs_enter_sdesc_2
#define HAVE_nbif_hipe_bifs_enter_sdesc_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_enter_sdesc_2))
ASYM(nbif_hipe_bifs_enter_sdesc_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(hipe_bifs_enter_sdesc_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_enter_sdesc_2))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_enter_sdesc_2))
#endif

#ifndef HAVE_nbif_hipe_bifs_bif_address_3
#define HAVE_nbif_hipe_bifs_bif_address_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_bif_address_3))
ASYM(nbif_hipe_bifs_bif_address_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(hipe_bifs_bif_address_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_bif_address_3))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_bif_address_3))
#endif

#ifndef HAVE_nbif_hipe_bifs_primop_address_1
#define HAVE_nbif_hipe_bifs_primop_address_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_primop_address_1))
ASYM(nbif_hipe_bifs_primop_address_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(hipe_bifs_primop_address_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_primop_address_1))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_primop_address_1))
#endif

#ifndef HAVE_nbif_hipe_bifs_atom_to_word_1
#define HAVE_nbif_hipe_bifs_atom_to_word_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_atom_to_word_1))
ASYM(nbif_hipe_bifs_atom_to_word_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(hipe_bifs_atom_to_word_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_atom_to_word_1))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_atom_to_word_1))
#endif

#ifndef HAVE_nbif_hipe_bifs_term_to_word_1
#define HAVE_nbif_hipe_bifs_term_to_word_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_term_to_word_1))
ASYM(nbif_hipe_bifs_term_to_word_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(hipe_bifs_term_to_word_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_term_to_word_1))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_term_to_word_1))
#endif

#ifndef HAVE_nbif_hipe_bifs_get_fe_2
#define HAVE_nbif_hipe_bifs_get_fe_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_get_fe_2))
ASYM(nbif_hipe_bifs_get_fe_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(hipe_bifs_get_fe_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_get_fe_2))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_get_fe_2))
#endif

#ifndef HAVE_nbif_hipe_bifs_set_native_address_in_fe_2
#define HAVE_nbif_hipe_bifs_set_native_address_in_fe_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_set_native_address_in_fe_2))
ASYM(nbif_hipe_bifs_set_native_address_in_fe_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(hipe_bifs_set_native_address_in_fe_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_set_native_address_in_fe_2))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_set_native_address_in_fe_2))
#endif

#ifndef HAVE_nbif_hipe_bifs_find_na_or_make_stub_1
#define HAVE_nbif_hipe_bifs_find_na_or_make_stub_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_find_na_or_make_stub_1))
ASYM(nbif_hipe_bifs_find_na_or_make_stub_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(hipe_bifs_find_na_or_make_stub_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_find_na_or_make_stub_1))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_find_na_or_make_stub_1))
#endif

#ifndef HAVE_nbif_hipe_bifs_check_crc_1
#define HAVE_nbif_hipe_bifs_check_crc_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_check_crc_1))
ASYM(nbif_hipe_bifs_check_crc_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(hipe_bifs_check_crc_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_check_crc_1))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_check_crc_1))
#endif

#ifndef HAVE_nbif_hipe_bifs_system_crc_0
#define HAVE_nbif_hipe_bifs_system_crc_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_system_crc_0))
ASYM(nbif_hipe_bifs_system_crc_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(hipe_bifs_system_crc_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_system_crc_0))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_system_crc_0))
#endif

#ifndef HAVE_nbif_hipe_bifs_get_rts_param_1
#define HAVE_nbif_hipe_bifs_get_rts_param_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_get_rts_param_1))
ASYM(nbif_hipe_bifs_get_rts_param_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(hipe_bifs_get_rts_param_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_get_rts_param_1))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_get_rts_param_1))
#endif

#ifndef HAVE_nbif_hipe_bifs_patch_insn_3
#define HAVE_nbif_hipe_bifs_patch_insn_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_patch_insn_3))
ASYM(nbif_hipe_bifs_patch_insn_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(hipe_bifs_patch_insn_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_patch_insn_3))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_patch_insn_3))
#endif

#ifndef HAVE_nbif_hipe_bifs_patch_call_3
#define HAVE_nbif_hipe_bifs_patch_call_3
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_patch_call_3))
ASYM(nbif_hipe_bifs_patch_call_3):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx
	# movq	%rcx, %rcx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq 	%rcx
	pushq	%rdx
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */  
	CALL_BIF(hipe_bifs_patch_call_3)
	add	$(3*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_3_simple_exception
	NSP_RET0
	
3:	call nbif_3_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_patch_call_3))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_patch_call_3))
#endif

#ifndef HAVE_nbif_hipe_bifs_add_ref_2
#define HAVE_nbif_hipe_bifs_add_ref_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_add_ref_2))
ASYM(nbif_hipe_bifs_add_ref_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(hipe_bifs_add_ref_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_add_ref_2))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_add_ref_2))
#endif

#ifndef HAVE_nbif_hipe_bifs_alloc_loader_state_1
#define HAVE_nbif_hipe_bifs_alloc_loader_state_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_alloc_loader_state_1))
ASYM(nbif_hipe_bifs_alloc_loader_state_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(hipe_bifs_alloc_loader_state_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_alloc_loader_state_1))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_alloc_loader_state_1))
#endif

#ifndef HAVE_nbif_hipe_bifs_call_count_on_1
#define HAVE_nbif_hipe_bifs_call_count_on_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_call_count_on_1))
ASYM(nbif_hipe_bifs_call_count_on_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(hipe_bifs_call_count_on_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_call_count_on_1))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_call_count_on_1))
#endif

#ifndef HAVE_nbif_hipe_bifs_call_count_off_1
#define HAVE_nbif_hipe_bifs_call_count_off_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_call_count_off_1))
ASYM(nbif_hipe_bifs_call_count_off_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(hipe_bifs_call_count_off_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_call_count_off_1))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_call_count_off_1))
#endif

#ifndef HAVE_nbif_hipe_bifs_call_count_get_1
#define HAVE_nbif_hipe_bifs_call_count_get_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_call_count_get_1))
ASYM(nbif_hipe_bifs_call_count_get_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(hipe_bifs_call_count_get_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_call_count_get_1))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_call_count_get_1))
#endif

#ifndef HAVE_nbif_hipe_bifs_call_count_clear_1
#define HAVE_nbif_hipe_bifs_call_count_clear_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_call_count_clear_1))
ASYM(nbif_hipe_bifs_call_count_clear_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(hipe_bifs_call_count_clear_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_call_count_clear_1))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_call_count_clear_1))
#endif

#ifndef HAVE_nbif_hipe_bifs_trap_count_get_0
#define HAVE_nbif_hipe_bifs_trap_count_get_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_trap_count_get_0))
ASYM(nbif_hipe_bifs_trap_count_get_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(hipe_bifs_trap_count_get_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_trap_count_get_0))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_trap_count_get_0))
#endif

#ifndef HAVE_nbif_hipe_bifs_trap_count_clear_0
#define HAVE_nbif_hipe_bifs_trap_count_clear_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_trap_count_clear_0))
ASYM(nbif_hipe_bifs_trap_count_clear_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(hipe_bifs_trap_count_clear_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_trap_count_clear_0))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_trap_count_clear_0))
#endif

#ifndef HAVE_nbif_hipe_bifs_show_estack_1
#define HAVE_nbif_hipe_bifs_show_estack_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_show_estack_1))
ASYM(nbif_hipe_bifs_show_estack_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(hipe_bifs_show_estack_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_show_estack_1))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_show_estack_1))
#endif

#ifndef HAVE_nbif_hipe_bifs_show_heap_1
#define HAVE_nbif_hipe_bifs_show_heap_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_show_heap_1))
ASYM(nbif_hipe_bifs_show_heap_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(hipe_bifs_show_heap_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_show_heap_1))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_show_heap_1))
#endif

#ifndef HAVE_nbif_hipe_bifs_show_nstack_1
#define HAVE_nbif_hipe_bifs_show_nstack_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_show_nstack_1))
ASYM(nbif_hipe_bifs_show_nstack_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(hipe_bifs_show_nstack_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_show_nstack_1))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_show_nstack_1))
#endif

#ifndef HAVE_nbif_hipe_bifs_nstack_used_size_0
#define HAVE_nbif_hipe_bifs_nstack_used_size_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_nstack_used_size_0))
ASYM(nbif_hipe_bifs_nstack_used_size_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(hipe_bifs_nstack_used_size_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_nstack_used_size_0))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_nstack_used_size_0))
#endif

#ifndef HAVE_nbif_hipe_bifs_show_pcb_1
#define HAVE_nbif_hipe_bifs_show_pcb_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_show_pcb_1))
ASYM(nbif_hipe_bifs_show_pcb_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(hipe_bifs_show_pcb_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_show_pcb_1))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_show_pcb_1))
#endif

#ifndef HAVE_nbif_hipe_bifs_show_term_1
#define HAVE_nbif_hipe_bifs_show_term_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_show_term_1))
ASYM(nbif_hipe_bifs_show_term_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(hipe_bifs_show_term_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_show_term_1))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_show_term_1))
#endif

#ifndef HAVE_nbif_hipe_bifs_in_native_0
#define HAVE_nbif_hipe_bifs_in_native_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_in_native_0))
ASYM(nbif_hipe_bifs_in_native_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(hipe_bifs_in_native_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_in_native_0))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_in_native_0))
#endif

#ifndef HAVE_nbif_hipe_bifs_modeswitch_debug_on_0
#define HAVE_nbif_hipe_bifs_modeswitch_debug_on_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_modeswitch_debug_on_0))
ASYM(nbif_hipe_bifs_modeswitch_debug_on_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(hipe_bifs_modeswitch_debug_on_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_modeswitch_debug_on_0))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_modeswitch_debug_on_0))
#endif

#ifndef HAVE_nbif_hipe_bifs_modeswitch_debug_off_0
#define HAVE_nbif_hipe_bifs_modeswitch_debug_off_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_modeswitch_debug_off_0))
ASYM(nbif_hipe_bifs_modeswitch_debug_off_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(hipe_bifs_modeswitch_debug_off_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_modeswitch_debug_off_0))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_modeswitch_debug_off_0))
#endif

#ifndef HAVE_nbif_hipe_bifs_debug_native_called_2
#define HAVE_nbif_hipe_bifs_debug_native_called_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_debug_native_called_2))
ASYM(nbif_hipe_bifs_debug_native_called_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(hipe_bifs_debug_native_called_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_debug_native_called_2))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_debug_native_called_2))
#endif

#ifndef HAVE_nbif_hipe_bifs_llvm_fix_pinned_regs_0
#define HAVE_nbif_hipe_bifs_llvm_fix_pinned_regs_0
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_llvm_fix_pinned_regs_0))
ASYM(nbif_hipe_bifs_llvm_fix_pinned_regs_0):
	/* set up the parameters */
	movq	P, %rdi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	CALL_BIF(hipe_bifs_llvm_fix_pinned_regs_0)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_0_simple_exception
	NSP_RET0
	
3:	call nbif_0_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_llvm_fix_pinned_regs_0))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_llvm_fix_pinned_regs_0))
#endif

#ifndef HAVE_nbif_hipe_bifs_build_stacktrace_1
#define HAVE_nbif_hipe_bifs_build_stacktrace_1
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_build_stacktrace_1))
ASYM(nbif_hipe_bifs_build_stacktrace_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	sub	$(8), %rsp	/* stack frame 16-byte alignment */
	CALL_BIF(hipe_bifs_build_stacktrace_1)
	add	$(1*8 + 8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_1_simple_exception
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_build_stacktrace_1))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_build_stacktrace_1))
#endif

#ifndef HAVE_nbif_hipe_bifs_write_u64_2
#define HAVE_nbif_hipe_bifs_write_u64_2
	TEXT
	.align	4
	GLOBAL(ASYM(nbif_hipe_bifs_write_u64_2))
ASYM(nbif_hipe_bifs_write_u64_2):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi
	# movq	%rdx, %rdx

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	pushq	%rdx
	pushq 	%rsi
	movq	%rsp, %rsi	/* Eterm* BIF__ARGS */
	CALL_BIF(hipe_bifs_write_u64_2)
	add	$(2*8), %rsp
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* throw exception if failure, otherwise return */
	TEST_GOT_EXN
	jz	nbif_2_simple_exception
	NSP_RET0
	
3:	call nbif_2_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(nbif_hipe_bifs_write_u64_2))
	TYPE_FUNCTION(ASYM(nbif_hipe_bifs_write_u64_2))
#endif


/*
 * Guard BIFs.
 * GBIF_LIST(FunctionAtom,Arity,CFun)
 */

/*
 * %CopyrightBegin%
 *
 * Copyright Ericsson AB 2001-2016. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * %CopyrightEnd%
 */
/*
 * GBIF_LIST(FunctionAtom,Arity,CFun)
 * manually maintained for now -- expand when necessary
 */

#ifndef HAVE_gbif_node_1
#define HAVE_gbif_node_1
	TEXT
	.align	4
	GLOBAL(ASYM(gbif_node_1))
ASYM(gbif_node_1):
	/* set up the parameters */
	movq	P, %rdi
	# movq	%rsi, %rsi

	/* make the call on the C stack */
	SWITCH_ERLANG_TO_C
	call	CSYM(node_1)
	movq P_MBUF(P), %rdx	/* `TEST_GOT_MBUF' */
	testq %rdx, %rdx
	jnz 3f	
2:
	SWITCH_C_TO_ERLANG

	/* return */
	NSP_RET0
	
3:	call nbif_1_gc_after_bif	/* `HANDLE_GOT_MBUF' */
	jmp 2b
	SET_SIZE(ASYM(gbif_node_1))
	TYPE_FUNCTION(ASYM(gbif_node_1))
#endif



#if defined(__linux__) && defined(__ELF__)
.section .note.GNU-stack,"",%progbits
#endif
