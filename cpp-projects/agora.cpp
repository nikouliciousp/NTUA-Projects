//Help Codes
//Move item in vector
//https://stackoverflow.com/questions/33248613/best-way-to-move-item-in-vector
//Sort by value
//http://www.cplusplus.com/reference/algorithm/sort/

#include <iostream>
#include <algorithm>
#include <vector>
#include <string>

using namespace std;

struct village {
	long long int days;
	long long int pos;
};

long long lcm(long long int a, long long int b) {
	long long int temp_lcm = (a / __gcd(a, b)) * b;
	return temp_lcm;
}

int main(int argc, char* argv[]) {
	long long int N, i, temp_1, temp_2, temp_v1 = 0, temp_v2 = 0;

	FILE *fp;
	
	//Open input files
	fp = fopen(argv[1], "r");
	fscanf(fp, "%lld", &N);

	vector <village> villages_1(N);
	vector <village> villages_2(N);

	//Fill vectors
	for (i = 0; i < N; i++) {
		fscanf(fp, "%lld", &villages_1[i].days);
		villages_2[N - i - 1].days = villages_1[i].days;
		villages_1[i].pos = i + 1;
		villages_2[N - i - 1].pos = i + 1;
	}

	//Vriskw lcm pros sta aristera meta pros ta deksia kai krataw to mikrotero apotelesma
	
	//Algo solve right
	for(i = 0; i < N - 2; i++) {
		temp_1 =  lcm(villages_1[i].days, villages_1[i + 1].days);
		temp_2 =  lcm(villages_1[i].days, villages_1[i + 2].days);
		if(temp_1 < temp_2){
			temp_v1 = villages_1[i + 2].pos;
			villages_1[i + 1].days = temp_1;
		}
		else if(temp_1 == temp_2) {
			villages_1[i + 1].days = temp_1;
			temp_v1 = 0;
		}
		else {
			temp_v1 = villages_1[i + 1].pos;
			swap(villages_1.at(i+1), villages_1.at(i+2));
			villages_1[i + 1].days = temp_2;
		}
	}

	//Algo solve left
	for(i = 0; i < N - 2; i++) {
		temp_1 =  lcm(villages_2[i].days, villages_2[i + 1].days);
		temp_2 =  lcm(villages_2[i].days, villages_2[i + 2].days);
		if(temp_1 < temp_2){
			temp_v2 = villages_2[i + 2].pos;
			villages_2[i + 1].days = temp_1;
		}
		else if(temp_1 == temp_2) {
			villages_2[i + 1].days = temp_1;
			temp_v2 = 0;
		}
		else {
			temp_v2 = villages_2[i + 1].pos;
			swap(villages_2.at(i+1), villages_2.at(i+2));
			villages_2[i + 1].days = temp_2;
		}
	}

	//Select result
	if(villages_1[N - 2].days < villages_2[N - 2].days) {
		printf("%lld %lld\n", villages_1[N - 2].days, temp_v1);
	}
	else{
		printf("%lld %lld\n", villages_2[N - 2].days, temp_v2);
	}

	return 0;
}
