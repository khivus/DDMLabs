#include <iostream>
#include <math.h>

using namespace std;

extern "C" float cfunc(float x) {
	float f;
	cout << "x: " << x << endl; // ����� �������� ���������
	f = (cos(x) + sin(x)) / exp(x); // ���������� �������� �������
	cout << "f: " << f << endl; // ����� �������� �������
	return f; // ����������� ����������
}
