//Help Codes
//http://www.cplusplus.com/reference/queue/queue/pop/
#include <iostream>
#include <algorithm>
#include <fstream>
#include <string>
#include <queue>

using namespace std;

int main(int argc, char* argv[]) {

	//Queue for '-' and '+'
	queue <int> myqueue_i;
	queue <int> myqueue_j;
	
	//Queue for '*'
	queue <int> boomqueue_i;
	queue <int> boomqueue_j;

	//Open input files
	ifstream inFile;
	inFile.open(argv[1]);
	string line;
	inFile >> line;

	//Calculate N
	int M = line.length();
	int lines_counter = 1;
	int i, j;

	//Calculate N
	while (true) {
		inFile >> line;
		if (!inFile.eof()) {
			lines_counter++;
		}
		else
			break;
	}

	inFile.clear();
	inFile.seekg(0, inFile.beg);
	int N = lines_counter;

	//Create array
	char** T = new char*[N];

	//Fill array
	for (int i = 0; i < N; i++) {
		T[i] = new char[M];
		for (int j = 0; j < M; j++) {
			inFile >> T[i][j];
		}
	}

	/*//Print array T
	for (int i = 0; i < N; i++) {
		for (int j = 0; j < M; j++) {
			cout <<  T[i][j];
		}
		cout << "\n";
	}
	cout << "\n";*/

	//counter_out: metritis gia na vgazw se kathe xroniki stigmi ola ta '-' kai '+'
	//counter_in: metritis gia thn epomenh xroniki stigmi
	int counter_in = 0, counter_out = 0;
	
	//timer: pote tha ginei (an ginei) h sintelia tou kosmou
	int timer= 1;

	//Ftiaxnw 2o pinaka an kai tha mporousa na xrhsimopoihsw mono enan gia na valw tixaki 
	//girw girw
	char A[N + 2][M + 2] = {'X'};

	for (int i = 0; i < N; i++) {
		for (int j = 0; j < M; j++) {
			A[i + 1][j + 1] = T[i][j];
		}
	}

	for (int i = 0; i < N; i++) {
		for (int j = 0; j < M; j++) {
			A[i + 1][j + 1] = T[i][j];
			if (A[i + 1][j + 1] == '+' || A[i + 1][j + 1] =='-') {
				myqueue_i.push (i + 1);
				myqueue_j.push (j + 1);
				
				//Metraw ta prwta '-' kai '+' pou mpikan sthn oura
				counter_in++;
			}
		}
	}

	/*//Print array A
	for (int i = 1; i < N + 1; i++) {
		for (int j = 1; j < M + 1; j++) {
			cout <<  A[i][j];
		}
		cout << "\n";
	}
	cout << "\n";*/

	//Arxikopoihsh metritwn
	counter_out = counter_in;
	counter_in = 0;

	//Endeikseis gia sinteleia
	bool flag = true;
	bool boom = true;

	while (!myqueue_i.empty() && flag == true) {
		while (counter_out != 0 && flag == true) {
			while (counter_out != 0) {
				i = myqueue_i.front();
				j = myqueue_j.front();
				counter_out--;
				myqueue_i.pop();
				myqueue_j.pop();

				if (A[i][j] == '+') {
					switch (A[i + 1][j]) {
						case '.':
							A[i + 1][j] = '+';
							myqueue_i.push (i + 1);
							myqueue_j.push (j);
							counter_in++;
							break;
						case '-':
							boomqueue_i.push(i + 1);
							boomqueue_j.push(j);
							boom = false;
							break;
						default:
							A[i + 1][j] = A[i + 1][j];
					}
					switch (A[i - 1][j]) {
						case '.':
							A[i - 1][j] = '+';
							myqueue_i.push (i - 1);
							myqueue_j.push (j);
							counter_in++;
							break;
						case '-':
							boomqueue_i.push(i - 1);
							boomqueue_j.push(j);
							boom = false;
							break;
						default:
							A[i - 1][j] = A[i - 1][j];
					}
					switch (A[i][j + 1]) {
						case '.':
							A[i][j + 1] = '+';
							myqueue_i.push (i);
							myqueue_j.push (j + 1);
							counter_in++;
							break;
						case '-':
							boomqueue_i.push(i);
							boomqueue_j.push(j + 1);
							boom = false;
							break;
						default:
							A[i][j + 1] = A[i][j + 1];
					}
					switch (A[i][j - 1]) {
						case '.':
							A[i][j - 1] = '+';
							myqueue_i.push (i);
							myqueue_j.push (j - 1);
							counter_in++;
							break;
						case '-':
							boomqueue_i.push(i);
							boomqueue_j.push(j - 1);
							boom = false;
							break;
						default:
							A[i][j - 1] = A[i][j - 1];
					}
				}
				else {
					switch (A[i + 1][j]) {
						case '.':
							A[i + 1][j] = '-';
							myqueue_i.push (i + 1);
							myqueue_j.push (j);
							counter_in++;
							break;
						case '+':
							boomqueue_i.push(i + 1);
							boomqueue_j.push(j);
							boom = false;
							break;
						default:
							A[i + 1][j] = A[i + 1][j];
					}
					switch (A[i - 1][j]) {
						case '.':
							A[i - 1][j] = '-';
							myqueue_i.push (i - 1);
							myqueue_j.push (j);
							counter_in++;
							break;
						case '+':
							boomqueue_i.push(i - 1);
							boomqueue_j.push(j);
							boom = false;
							break;
						default:
							A[i - 1][j] = A[i - 1][j];
					}
					switch (A[i][j + 1]) {
						case '.':
							A[i][j + 1] = '-';
							myqueue_i.push (i);
							myqueue_j.push (j + 1);
							counter_in++;
							break;
						case '+':
							boomqueue_i.push(i);
							boomqueue_j.push(j + 1);
							boom = false;
							break;
						default:
							A[i][j + 1] = A[i][j + 1];
					}
					switch (A[i][j - 1]) {
						case '.':
							A[i][j - 1] = '-';
							myqueue_i.push (i);
							myqueue_j.push (j - 1);
							counter_in++;
							break;
						case '+':
							boomqueue_i.push(i);
							boomqueue_j.push(j - 1);
							boom = false;
							break;
						default:
							A[i][j - 1] = A[i][j - 1];
					}
				}
			}
			//Peranw oles tis ekrikseis pou exoun (an exoun) pragmatopoihthei
			while (!boomqueue_i.empty()) {
				A[boomqueue_i.front()][boomqueue_j.front()] = '*';
				boomqueue_i.pop();
				boomqueue_j.pop();
			}
			//Kanw elegxw an exei erthei h sinteleia tou kosmou alliws sinexizw
			if (boom == false) {
				flag = boom;
			}
			else {
				counter_out = counter_in;
				counter_in = 0;
				timer++;
			}
		}
	}


	//Print array A
	if(flag == false) {
		printf("%d\n", timer);
			}
	else {
		printf("the world is saved\n");
	}

	for (int i = 1; i < N + 1; i++) {
		for (int j = 1; j < M + 1; j++) {
			cout <<  A[i][j];
		}
		cout << "\n";
	}

	return 0;
}
