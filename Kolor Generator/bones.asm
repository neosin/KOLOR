.386
.model	flat, stdcall
option	casemap :none

include		windows.inc
include		user32.inc
include		kernel32.inc
include		kolor.inc
include		gdi32.inc
include		masm32.inc
includelib	user32.lib
includelib	kernel32.lib
includelib	gdi32.lib
includelib	kolor.lib
includelib	masm32.lib

DlgProc		PROTO	:DWORD, :DWORD, :DWORD, :DWORD
PProc		PROTO	:DWORD, :DWORD, :DWORD, :DWORD
InfoProc	PROTO	:DWORD, :DWORD, :DWORD, :DWORD
.const

.const
IDD_MAIN 			equ		1000
IDC_MAIN_STITLE 	equ		1001
IDC_MAIN_SNAME 		equ		1002
IDC_MAIN_SSERIAL	equ		1003
IDC_MAIN_ENAME 		equ		1004
IDC_MAIN_ESERIAL 	equ		1005
IDC_MAIN_BABOUT 	equ		1006
IDC_MAIN_BCLOSE 	equ		1007
IDC_MAIN_BGEN 		equ		1008
IDC_MAIN_ITITLE 	equ		1009
IDD_ABOUT 			equ		2000
IDC_ABOUT_STITLE 	equ		2003
IDC_ABOUT_SINFO 	equ		2004
IDC_ABOUT_BCLOSE 	equ		2005
.data
col			KOLOR	<350DA7h, 0FFFFFFh, 0D8CE98h, 534B3Eh, 0E3DDC0h, 350DA7h>
szTitle		db		"Kolor Keygen Template", 0
sName		db		"Name:", 0
sSerial		db		"Serial:", 0
szInfo		db		10, 10, "Kolor Keygen Template", 10
			db		"by Prof. DrAcULA", 10
			db		"Released on: 01 June, 2020", 10
			db		"Enjoy!", 0
szFormat	db		"<%sh, %sh, %sh, %sh, %sh, %sh>"
szK1		db		11 dup(0)
szK2		db		11 dup(0)
szK3		db		11 dup(0)
szK4		db		11 dup(0)
szK5		db		11 dup(0)
szK6		db		11 dup(0)
.data?
hInstance	dd	?
szColor		db	10 dup(?)
szKOLOR		db	100 dup(?)
.code
start:
	invoke	GetModuleHandle, NULL
	mov	hInstance, eax
	invoke	DialogBoxParam, hInstance, 100, 0, offset DlgProc, 0
	invoke	ExitProcess, eax

DlgProc proc hWin:DWORD, uMsg:DWORD, wParam:DWORD, lParam:DWORD
	mov	eax, uMsg
	
	.if	eax == WM_INITDIALOG
		invoke	LoadIcon, hInstance, 200
		invoke	SendMessage, hWin, WM_SETICON, 1, eax
		invoke	RtlZeroMemory, addr szColor, sizeof szColor
		invoke	dw2hex, col.tbackground, addr szColor
		invoke	SetDlgItemText, hWin, 111, addr szColor
		invoke	RtlZeroMemory, addr szColor, sizeof szColor
		invoke	dw2hex, col.tfont, addr szColor
		invoke	SetDlgItemText, hWin, 114, addr szColor
		invoke	RtlZeroMemory, addr szColor, sizeof szColor
		invoke	dw2hex, col.background, addr szColor
		invoke	SetDlgItemText, hWin, 103, addr szColor
		invoke	RtlZeroMemory, addr szColor, sizeof szColor
		invoke	dw2hex, col.border, addr szColor
		invoke	SetDlgItemText, hWin, 104, addr szColor
		invoke	RtlZeroMemory, addr szColor, sizeof szColor
		invoke	dw2hex, col.ebackground, addr szColor
		invoke	SetDlgItemText, hWin, 109, addr szColor
		invoke	RtlZeroMemory, addr szColor, sizeof szColor
		invoke	dw2hex, col.efont, addr szColor
		invoke	SetDlgItemText, hWin, 107, addr szColor
	.elseif eax == WM_COMMAND
		mov	eax, wParam
		.if	eax == 106
			invoke	RtlZeroMemory, addr szK1, sizeof szK1
			invoke	GetDlgItemText, hWin, 111, addr szK1, sizeof szK1
			invoke	htodw, addr szK1
			mov		col.tbackground, eax
			invoke	RtlZeroMemory, addr szK2, sizeof szK2
			invoke	GetDlgItemText, hWin, 114, addr szK2, sizeof szK2
			invoke	htodw, addr szK2
			mov		col.tfont, eax
			invoke	RtlZeroMemory, addr szK3, sizeof szK3
			invoke	GetDlgItemText, hWin, 103, addr szK3, sizeof szK3
			invoke	htodw, addr szK3
			mov		col.background, eax
			invoke	RtlZeroMemory, addr szK4, sizeof szK4
			invoke	GetDlgItemText, hWin, 104, addr szK4, sizeof szK4
			invoke	htodw, addr szK4
			mov		col.border, eax
			invoke	RtlZeroMemory, addr szK5, sizeof szK5
			invoke	GetDlgItemText, hWin, 109, addr szK5, sizeof szK5
			invoke	htodw, addr szK5
			mov		col.ebackground, eax
			invoke	RtlZeroMemory, addr szK6, sizeof szK6
			invoke	GetDlgItemText, hWin, 107, addr szK6, sizeof szK6
			invoke	htodw, addr szK6
			mov		col.efont, eax
			invoke	RtlZeroMemory, addr szKOLOR, sizeof szKOLOR
			invoke	wsprintf, addr szKOLOR, addr szFormat, addr szK1, addr szK2, addr szK3, addr szK4, addr szK5, addr szK6
			invoke	SetDlgItemText, hWin, 2006, addr szKOLOR
			INVOKE DialogBoxParam, hInstance, IDD_MAIN, hWin, ADDR PProc, 0
		.endif
	.elseif	eax == WM_CLOSE
		invoke	EndDialog, hWin, 0
	.endif

	xor	eax, eax
	ret
DlgProc endp

PProc proc hWnd:DWORD, uMsg:DWORD, wParam:DWORD, lParam:DWORD
	mov	eax, uMsg
	.if	eax == WM_INITDIALOG
		invoke	InitProc, col
		invoke	LoadIcon, hInstance, 200
		invoke	SendMessage, hWnd, WM_SETICON, 1, eax
		invoke	SetWindowText, hWnd, addr szTitle
		invoke	SetDlgItemText, hWnd, IDC_MAIN_STITLE, addr szTitle
		invoke	SetDlgItemText, hWnd, IDC_MAIN_SNAME, addr sName
		invoke	SetDlgItemText, hWnd, IDC_MAIN_SSERIAL, addr sSerial
		invoke	RegionProc, hWnd
	.elseif eax == WM_PAINT
		invoke	PaintProc, hWnd
	.elseif eax == WM_CTLCOLORSTATIC
		invoke	GetDlgCtrlID, lParam
		.if eax == IDC_MAIN_STITLE
			invoke	StaticProc, hWnd, wParam, 0
		.elseif eax == IDC_MAIN_ESERIAL
			invoke	StaticProc, hWnd, wParam, 1
		.elseif eax == IDC_MAIN_SNAME||eax == IDC_MAIN_SSERIAL
			invoke	StaticProc, hWnd, wParam, 2
		.endif
    	ret
    .elseif eax == WM_CTLCOLOREDIT
    	invoke	EditProc, wParam
    	ret
    .elseif eax == WM_DRAWITEM
    	.if wParam == IDC_MAIN_BABOUT||wParam == IDC_MAIN_BCLOSE
    		invoke	DrawProc, hWnd, lParam, 0
    	.else
    		invoke	DrawProc, hWnd, lParam, 1
    	.endif
	.elseif eax == WM_LBUTTONDOWN
		invoke	SendMessage, hWnd, WM_NCLBUTTONDOWN, 2, 0
	.elseif eax == WM_COMMAND
		mov	eax, wParam
    	mov edx, wParam
    	shr edx, 16
    	.if wParam == IDC_MAIN_BGEN
    		;
    	.elseif wParam == IDC_MAIN_BABOUT
    		INVOKE DialogBoxParam, hInstance, IDD_ABOUT, hWnd, ADDR InfoProc, 0
    	.elseif wParam == IDC_MAIN_BCLOSE
    		invoke	OutitProc
    		invoke	EndDialog, hWnd, 0
    	.endif
	.elseif	eax == WM_CLOSE
		invoke	OutitProc
		invoke	EndDialog, hWnd, 0
	.endif
	xor	eax, eax
	ret
PProc endp
;----------------------------------------------------------------------------------------
InfoProc proc hWnd:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM
	.if uMsg == WM_CTLCOLORSTATIC
    	invoke	GetDlgCtrlID, lParam
		.if eax == IDC_ABOUT_STITLE
			invoke	StaticProc, hWnd, wParam, 0
		.elseif eax == IDC_ABOUT_SINFO
			invoke	StaticProc, hWnd, wParam, 1
		.endif
    	ret
	.elseif uMsg == WM_DRAWITEM
    	invoke	DrawProc, hWnd, lParam, 1
   	.elseif uMsg == WM_PAINT
    	invoke	PaintProc, hWnd
  	.elseif uMsg == WM_INITDIALOG
  		invoke	SetWindowText, hWnd, addr szTitle
		invoke	SetDlgItemText, hWnd, IDC_ABOUT_STITLE, addr szTitle
		invoke	SetDlgItemText, hWnd, IDC_ABOUT_SINFO, addr szInfo
		invoke	RegionProc, hWnd
    .elseif uMsg == WM_LBUTTONDOWN
		invoke	SendMessage, hWnd, WM_NCLBUTTONDOWN, 2, 0
  	.elseif uMsg == WM_COMMAND
    	.if wParam == IDC_ABOUT_BCLOSE
      		invoke	SendMessage, hWnd, WM_CLOSE, 0, 0
    	.endif
  	.elseif uMsg == WM_CLOSE
    	invoke EndDialog, hWnd, 0
  	.endif
  	xor eax, eax
  	ret
InfoProc ENDP
;----------------------------------------------------------------------------------------
end start