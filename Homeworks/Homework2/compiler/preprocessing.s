	.file	"matrix_mul_OMP.c"
	.text
	.globl	CHUNK
	.section	.rodata
	.align 4
	.type	CHUNK, @object
	.size	CHUNK, 4
CHUNK:
	.long	10
.LC0:
	.string	"%d, %d\n"
.LC1:
	.string	"%f, "
	.text
	.globl	print_matrix
	.type	print_matrix, @function
print_matrix:
.LFB5:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	movl	%edx, -32(%rbp)
	movl	-32(%rbp), %edx
	movl	-28(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC0(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, -4(%rbp)
	jmp	.L2
.L5:
	movl	$0, -8(%rbp)
	jmp	.L3
.L4:
	movl	-4(%rbp), %eax
	imull	-32(%rbp), %eax
	movl	%eax, %edx
	movl	-8(%rbp), %eax
	addl	%edx, %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movss	(%rax), %xmm0
	cvtss2sd	%xmm0, %xmm0
	leaq	.LC1(%rip), %rdi
	movl	$1, %eax
	call	printf@PLT
	addl	$1, -8(%rbp)
.L3:
	movl	-8(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jl	.L4
	movl	$10, %edi
	call	putchar@PLT
	addl	$1, -4(%rbp)
.L2:
	movl	-4(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jl	.L5
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	print_matrix, .-print_matrix
	.section	.rodata
.LC3:
	.string	"{"
.LC4:
	.string	"\"Normal time\": %ld\n"
.LC5:
	.string	"\"OMP time\" : %lf\n"
.LC6:
	.string	"}"
	.text
	.globl	multiply_matrix
	.type	multiply_matrix, @function
multiply_matrix:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$80, %rsp
	movq	%rdi, -56(%rbp)
	movl	%esi, -60(%rbp)
	movl	%edx, -64(%rbp)
	movq	%rcx, -72(%rbp)
	movl	%r8d, -76(%rbp)
	movl	%r9d, -80(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L7
.L8:
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	16(%rbp), %rax
	addq	%rdx, %rax
	pxor	%xmm0, %xmm0
	movss	%xmm0, (%rax)
	addl	$1, -4(%rbp)
.L7:
	movl	-60(%rbp), %eax
	imull	-80(%rbp), %eax
	cmpl	%eax, -4(%rbp)
	jl	.L8
	movl	$0, %edi
	call	time@PLT
	movq	%rax, -24(%rbp)
	call	omp_get_wtime@PLT
	movq	%xmm0, %rax
	movq	%rax, -32(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L9
.L14:
	movl	$0, -8(%rbp)
	jmp	.L10
.L13:
	movl	$0, -12(%rbp)
	jmp	.L11
.L12:
	movl	-4(%rbp), %eax
	imull	-80(%rbp), %eax
	movl	%eax, %edx
	movl	-8(%rbp), %eax
	addl	%edx, %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	16(%rbp), %rax
	addq	%rdx, %rax
	movss	(%rax), %xmm1
	movl	-4(%rbp), %eax
	imull	-64(%rbp), %eax
	movl	%eax, %edx
	movl	-12(%rbp), %eax
	addl	%edx, %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-56(%rbp), %rax
	addq	%rdx, %rax
	movss	(%rax), %xmm2
	movl	-80(%rbp), %eax
	imull	-12(%rbp), %eax
	movl	%eax, %edx
	movl	-8(%rbp), %eax
	addl	%edx, %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-72(%rbp), %rax
	addq	%rdx, %rax
	movss	(%rax), %xmm0
	mulss	%xmm2, %xmm0
	movl	-4(%rbp), %eax
	imull	-80(%rbp), %eax
	movl	%eax, %edx
	movl	-8(%rbp), %eax
	addl	%edx, %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	16(%rbp), %rax
	addq	%rdx, %rax
	addss	%xmm1, %xmm0
	movss	%xmm0, (%rax)
	addl	$1, -12(%rbp)
.L11:
	movl	-12(%rbp), %eax
	cmpl	-64(%rbp), %eax
	jl	.L12
	addl	$1, -8(%rbp)
.L10:
	movl	-8(%rbp), %eax
	cmpl	-80(%rbp), %eax
	jl	.L13
	addl	$1, -4(%rbp)
.L9:
	movl	-4(%rbp), %eax
	cmpl	-60(%rbp), %eax
	jl	.L14
	movl	$0, %edi
	call	time@PLT
	movq	%rax, -40(%rbp)
	call	omp_get_wtime@PLT
	movq	%xmm0, %rax
	movq	%rax, -48(%rbp)
	leaq	.LC3(%rip), %rdi
	call	puts@PLT
	movq	-40(%rbp), %rax
	subq	-24(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC4(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movsd	-48(%rbp), %xmm0
	subsd	-32(%rbp), %xmm0
	leaq	.LC5(%rip), %rdi
	movl	$1, %eax
	call	printf@PLT
	leaq	.LC6(%rip), %rdi
	call	puts@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	multiply_matrix, .-multiply_matrix
	.section	.rodata
.LC7:
	.string	"%f,"
.LC8:
	.string	"%d, %d"
.LC9:
	.string	"invalid matrices"
	.text
	.globl	main
	.type	main, @function
main:
.LFB7:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	jmp	.L16
.L23:
	movl	-44(%rbp), %eax
	movslq	%eax, %rdx
	movl	-52(%rbp), %eax
	cltq
	imulq	%rdx, %rax
	salq	$2, %rax
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, -24(%rbp)
	movl	$0, -12(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, -8(%rbp)
	jmp	.L17
.L18:
	movq	-8(%rbp), %rax
	leaq	4(%rax), %rdx
	movq	%rdx, -8(%rbp)
	movq	%rax, %rsi
	leaq	.LC7(%rip), %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	addl	$1, -12(%rbp)
.L17:
	movl	-44(%rbp), %edx
	movl	-52(%rbp), %eax
	imull	%edx, %eax
	cmpl	%eax, -12(%rbp)
	jl	.L18
	leaq	-56(%rbp), %rdx
	leaq	-48(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC8(%rip), %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	movl	-48(%rbp), %eax
	movslq	%eax, %rdx
	movl	-56(%rbp), %eax
	cltq
	imulq	%rdx, %rax
	salq	$2, %rax
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, -32(%rbp)
	movl	$0, -12(%rbp)
	movq	-32(%rbp), %rax
	movq	%rax, -8(%rbp)
	jmp	.L19
.L20:
	movq	-8(%rbp), %rax
	leaq	4(%rax), %rdx
	movq	%rdx, -8(%rbp)
	movq	%rax, %rsi
	leaq	.LC7(%rip), %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	addl	$1, -12(%rbp)
.L19:
	movl	-48(%rbp), %edx
	movl	-56(%rbp), %eax
	imull	%edx, %eax
	cmpl	%eax, -12(%rbp)
	jl	.L20
	movl	-52(%rbp), %edx
	movl	-48(%rbp), %eax
	cmpl	%eax, %edx
	je	.L21
	leaq	.LC9(%rip), %rdi
	call	puts@PLT
	jmp	.L22
.L21:
	movl	-44(%rbp), %eax
	movslq	%eax, %rdx
	movl	-56(%rbp), %eax
	cltq
	imulq	%rdx, %rax
	salq	$2, %rax
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, -40(%rbp)
	movl	-56(%rbp), %r8d
	movl	-48(%rbp), %edi
	movl	-52(%rbp), %edx
	movl	-44(%rbp), %esi
	movq	-32(%rbp), %rcx
	movq	-24(%rbp), %rax
	subq	$8, %rsp
	pushq	-40(%rbp)
	movl	%r8d, %r9d
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	multiply_matrix
	addq	$16, %rsp
.L16:
	leaq	-52(%rbp), %rdx
	leaq	-44(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC8(%rip), %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	cmpl	$2, %eax
	je	.L23
.L22:
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	main, .-main
	.ident	"GCC: (Debian 8.2.0-4) 8.2.0"
	.section	.note.GNU-stack,"",@progbits
