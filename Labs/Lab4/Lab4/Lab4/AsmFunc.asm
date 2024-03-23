.586
.XMM
.MODEL flat, C

.DATA

one dd 1          ; Одно для вычитания из x
res dd 0          ; Конечный результат

i dd ?            ; Счетчик итераций
temp dd ?         ; Временная переменная
xminone dd ?      ; Результат вычитания из x

.CODE

extern cfunc:near  ; Объявление внешней функции на C++

public getf        ; Объявление публичной процедуры
getf proc C x:dword ; Начало процедуры с аргументом x
    finit          ; Инициализация сопроцессора

    fld x          ; Загрузка x в стек FPU
    fild one       ; Загрузка единицы в стек FPU
    fsub           ; Вычитание из x единицы
    fstp xminone   ; Сохранение результата вычитания в xminone

yappy:
    fld xminone    ; Загрузка xminone в стек FPU
    fild i         ; Загрузка i в стек FPU
    fadd           ; Сложение
    fstp temp      ; Сохранение результата в temp
    push temp      ; Помещение temp в стек вызовов
    call cfunc     ; Вызов функции на C
    fst temp       ; Сохранение результата функции

    fld res         ; Загрузка значения res в вершину стека FPU
    fcompp          ; Сравнение двух значений в стеке и установка флагов процессора
    fstsw ax        ; Сохранение состояния флагов в регистре AX
    sahf            ; Копирование флагов из регистра AH в регистр FLAGS в процессоре
    jb move_to_tmp  ; Если результат больше предыдущего максимального

go_back:
    inc i          ; Инкремент счетчика
    cmp i, 4       ; Сравнение с 4
    jb yappy       ; Переход к yappy, если меньше
    jmp avoid      ; Переход к avoid

move_to_tmp:
    mov eax, temp  ; Перемещение значения temp в eax
    mov res, eax   ; Перемещение eax в res
    jmp go_back    ; Переход к go_back

avoid:
    fld res        ; Загрузка res в стек FPU
    ret            ; Возврат из процедуры

getf endp          ; Конец процедуры
End                ; Конец файла
