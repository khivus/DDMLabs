#include <iostream>
#include <math.h>

using namespace std;

extern "C" float cfunc(float x) {
	float f;
	cout << "x: " << x << endl; // Вывод значения аргумента
	f = (cos(x) + sin(x)) / exp(x); // Вычисление значения функции
	cout << "f: " << f << endl; // Вывод значения функции
	return f; // Возвращение результата
}
