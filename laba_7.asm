.386
scale  macro  p1
  fld  max_&p1
  fsub  min_&p1
  fild  p1&_result
  fdivp  st(1), st(0)

  fstp  scale_&p1
endm

x_result_  equ  320
y_result_  equ  200

_data  segment  use16
  min_x  dq  -6.283
  max_x  dq  6.283
  x_result  dw  x_result_
  
  crt_x  dw  ?
  scale_x  dq  ?

  min_y  dq  -0.5
  max_y  dq  5.5
  y_result  dw  y_result_
  crt_y  dw  ?
  scale_y  dq  ?

  step  dq  0.001
  tmp  dw  ?
  one dw 1
  
_data  ends

_code  segment  use16
  assume  cs:_code, ds:_data
begin:
  mov  ax, _data
  mov  ds, ax

  mov  ax, 13h		
  int  10h			

  finit				
  scale  x			
  scale  y

  call  draw_axis

  push  4
  push  offset func
  call  draw_gra
  add  sp, 4


  mov  ah, 8
  int  21h
  mov  ax, 3
  int  10h
  mov  ax, 4C00h
  int  21h
  


func  proc  
  fabs    	
  fst st(2)
  fmul st(2), st(0)
  fsqrt 
  fadd st(0), st(2)
  fld1
  faddp st(1), st(0)
  ffree  st(2)
  ret
func  endp

draw_gra  proc
  push  bp
  mov  bp, sp
  fld  min_x
beg:
  fld  st(0)
  fld  st(0)
  fld  st(0)
  call  get_x
  
  call func
  
  call  get_y
  push  2
  call  draw_point
  add  sp, 2
  fld  step
  faddp  st(1), st(0)
  fcom  max_x
  fstsw  ax
  sahf
  jna  beg
  ffree st(1)
  ffree  st(0)
  
  pop  bp
  ret
draw_gra  endp

get_x  proc
  fsub  min_x
  fdiv  scale_x
  frndint			
  fistp  crt_x		
  ret
get_x  endp

get_y  proc
  fsub  min_y
  fdiv  scale_y
  frndint
  fistp  crt_y			
  mov  ax, y_result
  sub  ax, crt_y
  mov  crt_y, ax
  ret
get_y  endp

draw_point  proc
  push bp
  mov  bp, sp
  mov  ax, 0A000h
  mov  es, ax
  mov  si, crt_y
  mov  di, crt_x
  cmp  si, y_result_
  jae  endl
  cmp  di, x_result_	
  jae  endl
  mov  ax, x_result_			
  mul  si
  add  ax, di
  
  mov  bx, ax
  mov  dx, [bp+4]			 
  mov  byte ptr es:[bx], dl
endl:
  pop  bp
  ret
draw_point  endp

draw_axis  proc
  fldz
  call  get_y
  mov  crt_x, 0
  mov  cx, x_result_
@x_c:
  push  15
  call  draw_point
  add  sp, 2
  inc  crt_x
  loop  @x_c

  fld  max_x
  fsub  min_x
  frndint
  fistp  tmp
  mov  cx, tmp

  fld  min_x
  frndint
  dec  crt_y
line_x:
  fld  st(0)
  call  get_x
  push  15
  call  draw_point
  add  sp, 2
  
  fld1
  faddp  st(1), st(0)
  loop  line_x
  ffree  st(0)

  fldz
  call  get_x
  mov  crt_y, 0
  mov  cx, y_result_
@y_c:
  push  15
  call  draw_point
  add  sp, 2
  inc  crt_y
  loop  @y_c

  fld  max_y
  fsub  min_y
  frndint
  fistp  tmp
  mov  cx, tmp

  fld  min_y
  frndint
  dec  crt_x
line_y:
  fst  st(1)
  call  get_y
  push  15
  call  draw_point
  add  sp, 2  

  fld1
  faddp  st(1), st(0)
  fcom  max_y
  loop  line_y
  ffree  st(0)
  ret
draw_axis  endp

_code  ends
  end  begin
