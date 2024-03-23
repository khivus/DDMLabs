#include <iostream>
#include <chrono>

using namespace std;

extern "C" float getf(float x); // Объявление внешней функции на языке ассемблера

int main(int argc, char** argv) {
	float x;
	float f;

	cout << "Input x: ";
	cin >> x;

	auto start = std::chrono::high_resolution_clock::now();

	f = getf(x); // Вызов функции из ассемблерного модуля

	cout << "Result: " << f << endl;

	auto end = std::chrono::high_resolution_clock::now();
	std::chrono::duration<double> duration = end - start;
	std::cout << "Execution Time: " << duration.count() << " seconds" << std::endl;

	return 0;
}
