DATAS SEGMENT
	;; data
DATAS ENDS

STACKS SEGMENT
	;; stack
STACKS ENDS

CODES SEGMENT
	ASSUME CS:CODES,DS:DATAS,ES:DATAS,SS:STACKS
START:
	MOV AX,DATAS
	MOV DS,AX
	;; your code
	MOV AH,4CH
	INT 21H
CODES ENDS
END START