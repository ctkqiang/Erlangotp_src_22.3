/*
 * %CopyrightBegin%
 *
 * Copyright Ericsson AB 2002-2016. All Rights Reserved.
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


#ifndef HIPE_X86_ASM_H
#define HIPE_X86_ASM_H

/*
 * Tunables.
 */

#define X86_LEAF_WORDS	24
#define LEAF_WORDS	24

#define X86_NR_ARG_REGS	3
#define NR_ARG_REGS	3

#define X86_HP_IN_ESI	1
#define X86_SIMULATE_NSP	0


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
#define P	%ebp

#if X86_HP_IN_ESI
#define SAVE_HP		movl %esi, P_HP(P)
#define RESTORE_HP	movl P_HP(P), %esi
#else
#define SAVE_HP		/*empty*/
#define RESTORE_HP	/*empty*/
#endif

#define NSP		%esp
#define SAVE_CSP	movl %esp, P_CSP(P)
#define RESTORE_CSP	movl P_CSP(P), %esp


/*
 * Context switching macros.
 */
#define SWITCH_C_TO_ERLANG_QUICK	\
	SAVE_CSP; \
	movl P_NSP(P), NSP

#define SWITCH_ERLANG_TO_C_QUICK	\
	movl NSP, P_NSP(P); \
	RESTORE_CSP

#define SAVE_CACHED_STATE	\
	SAVE_HP

#define RESTORE_CACHED_STATE	\
	RESTORE_HP

#define SWITCH_C_TO_ERLANG	\
	RESTORE_CACHED_STATE;	\
	SWITCH_C_TO_ERLANG_QUICK

#define SWITCH_ERLANG_TO_C	\
	SAVE_CACHED_STATE;	\
	SWITCH_ERLANG_TO_C_QUICK


/*
 * Argument (parameter) registers.
 */
#define ARG0	%eax
#define ARG1	%edx
#define ARG2	%ecx

/*
 * TEMP_RV:
 *	Used in nbif_stack_trap_ra to preserve the return value.
 *	Must be a C callee-save register.
 *	Must be otherwise unused in the return path.
 */
#define TEMP_RV	%ebx

/*
 * TEMP_NSP:
 *	Used in BIF wrappers to permit copying stacked parameter from
 *	the native stack to the C stack.
 *	Set up by NBIF_COPY_NSP(arity) and used by NBIF_ARG(arity,argno).
 *	TEMP_NSP may alias the last BIF argument register.
 *	NBIF_COPY_NSP and NBIF_ARG currently fail if ARITY > NR_ARG_REGS!
 */
#define TEMP_NSP	%edi


#define LOAD_ARG_REGS	movl P_ARG0(P), ARG0 ; movl P_ARG1(P), ARG1 ; movl P_ARG2(P), ARG2 ; 

#define STORE_ARG_REGS	movl ARG0, P_ARG0(P) ; movl ARG1, P_ARG1(P) ; movl ARG2, P_ARG2(P) ; 

#define NSP_CALL(FUN)	call FUN
#define NSP_RETN(NPOP)	ret $NPOP
#define NSP_RET0	ret

/* #define NBIF_COPY_NSP_0	 */
/* #define NBIF_COPY_NSP_1	 */
/* #define NBIF_COPY_NSP_2	 */
/* #define NBIF_COPY_NSP_3	 */
/* #define NBIF_COPY_NSP_4	movl	%esp, TEMP_NSP */
/* #define NBIF_COPY_NSP_5	movl	%esp, TEMP_NSP */


/* #define NBIF_ARG_OPND_1_0	ARG0 */
/* #define NBIF_ARG_OPND_2_0	ARG0 */
/* #define NBIF_ARG_OPND_2_1	ARG1 */
/* #define NBIF_ARG_OPND_3_0	ARG0 */
/* #define NBIF_ARG_OPND_3_1	ARG1 */
/* #define NBIF_ARG_OPND_3_2	ARG2 */
/* #define NBIF_ARG_OPND_4_0	ARG0 */
/* #define NBIF_ARG_OPND_4_1	ARG1 */
/* #define NBIF_ARG_OPND_4_2	ARG2 */
/* #define NBIF_ARG_OPND_4_3	4(TEMP_NSP) */
/* #define NBIF_ARG_OPND_5_0	ARG0 */
/* #define NBIF_ARG_OPND_5_1	ARG1 */
/* #define NBIF_ARG_OPND_5_2	ARG2 */
/* #define NBIF_ARG_OPND_5_3	8(TEMP_NSP) */
/* #define NBIF_ARG_OPND_5_4	4(TEMP_NSP) */

/* #define NBIF_ARG_REG_0_P	movl P,(%esp) */


/* #define NBIF_RET_0	NSP_RET0 */
/* #define NBIF_RET_1	NSP_RET0 */
/* #define NBIF_RET_2	NSP_RET0 */
/* #define NBIF_RET_3	NSP_RET0 */
/* #define NBIF_RET_4	NSP_RETN(4) */
/* #define NBIF_RET_5	NSP_RETN(8) */

#define STORE_CALLER_SAVE	movl ARG0, P_ARG0(P) ; movl ARG1, P_ARG1(P) ; movl ARG2, P_ARG2(P) ; 
#define LOAD_CALLER_SAVE	movl P_ARG0(P), ARG0 ; movl P_ARG1(P), ARG1 ; movl P_ARG2(P), ARG2 ; 

#endif /* ASM */

#endif /* HIPE_X86_ASM_H */
