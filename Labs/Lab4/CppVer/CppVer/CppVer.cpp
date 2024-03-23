#include <iostream>
#include <math.h>
#include <chrono>

using namespace std;

int main() {
	int i;
	float x, temp, xd;
	float f = -99999999;

	cout << "Input x: ";
	cin >> x;
	
	auto start = std::chrono::high_resolution_clock::now();

	for (int j = 0; j < 10000000; j++) {


		for (i = -1; i < 3; i++) {
			xd = x + i;
			temp = (cos(xd) + sin(xd)) / exp(xd);
			f = max(temp, f);
		}

	}

	cout << "Result: " << f << endl;

	auto end = std::chrono::high_resolution_clock::now();
	std::chrono::duration<double> duration = end - start;
	std::cout << "Execution Time: " << duration.count() << " seconds" << std::endl;

	return 0;
}
