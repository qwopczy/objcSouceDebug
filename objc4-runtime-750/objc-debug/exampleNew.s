//
//  exampleNew.s
//  objc-debug
//
//  Created by chenyi on 2020/5/21.
//

#if __arm64__

#include <arm/arch.h>
//#include "isa.h"
#include "arm64-asm.h"
; example.s
    ; Program
    .section __TEXT,__text,regular,pure_instructions
    .global _getSectionName, _getSectionNameAddress
    .p2align 2

_getSectionName:
    adrp x8, _sectionName@PAGE
    add  x8, x8, _sectionName@PAGEOFF
    ldr  x0, [x8]
    ret

_getSectionVersion:
    adrp x8, _sectionVersion@PAGE
    add  x8, x8, _sectionVersion@PAGEOFF
    ldr  w0, [x8]
    ret

_getSectionNameAddress:
    adrp x8, _sectionName@PAGE
    add  x8, x8, _sectionName@PAGEOFF
    mov  x0, x8
    ret

    ; Global Data
    .section __DATA,__data
    .global _sectionVersion
    .p2align 2
_sectionVersion:
    .long 100

    .global _sectionName
    .p2align 3
_sectionName:
    .quad l_str

    ; String Literal
    .section __TEXT,__text,cstring_literals
l_str:
    .asciz "MySec"



.data
; exampleNew.s
.section __TEXT,__text,regular,pure_instructions
.ios_version_min 11, 2
.p2align 2
.global _double_num_times_asm
_double_num_times_asm:
    lsl x0, x0, x1
    ret
//#else
    
    

#endif
