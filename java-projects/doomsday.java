//Help Codes
//https://www.geeksforgeeks.org/queue-interface-java/
//To diavasma arxeiou to ekana basei tou voithitikou kwdika pou dothike sto mathima apo tis parousiaseis

import java.util.LinkedList;
import java.util.Queue;
import java.io.*;

public class doomsday {
	static int solve(int N, int M, Queue<Integer> q_i, Queue<Integer> q_j, Queue<Integer> bq_i, Queue<Integer> bq_j, String[][] Arr, int i, int j, boolean flag, boolean boom, int counter_in, int counter_out, int timer) {
	while (!q_i.isEmpty() && flag == true) {
		while (counter_out != 0 && flag == true) {
			while (counter_out != 0) {
				i = q_i.remove();
				j = q_j.remove();
				counter_out--;

				if (Arr[i][j].equals("+")) {
					switch (Arr[i + 1][j]) {
						case ".":
							Arr[i + 1][j] = "+";
							q_i.add (i + 1);
							q_j.add (j);
							counter_in++;
							break;
						case "-":
							bq_i.add(i + 1);
							bq_j.add(j);
							boom = false;
							break;
						default:
							Arr[i + 1][j] = Arr[i + 1][j];
					}
					switch (Arr[i - 1][j]) {
						case ".":
							Arr[i - 1][j] = "+";
							q_i.add (i - 1);
							q_j.add (j);
							counter_in++;
							break;
						case "-":
							bq_i.add(i - 1);
							bq_j.add(j);
							boom = false;
							break;
						default:
							Arr[i - 1][j] = Arr[i - 1][j];
					}
					switch (Arr[i][j + 1]) {
						case ".":
							Arr[i][j + 1] = "+";
							q_i.add (i);
							q_j.add (j + 1);
							counter_in++;
							break;
						case "-":
							bq_i.add(i);
							bq_j.add(j + 1);
							boom = false;
							break;
						default:
							Arr[i][j + 1] = Arr[i][j + 1];
					}
					switch (Arr[i][j - 1]) {
						case ".":
							Arr[i][j - 1] = "+";
							q_i.add (i);
							q_j.add (j - 1);
							counter_in++;
							break;
						case "-":
							bq_i.add(i);
							bq_j.add(j - 1);
							boom = false;
							break;
						default:
							Arr[i][j - 1] = Arr[i][j - 1];
					}
				}
				else {
					switch (Arr[i + 1][j]) {
						case ".":
							Arr[i + 1][j] = "-";
							q_i.add (i + 1);
							q_j.add (j);
							counter_in++;
							break;
						case "+":
							bq_i.add(i + 1);
							bq_j.add(j);
							boom = false;
							break;
						default:
							Arr[i + 1][j] = Arr[i + 1][j];
					}
					switch (Arr[i - 1][j]) {
						case ".":
							Arr[i - 1][j] = "-";
							q_i.add (i - 1);
							q_j.add (j);
							counter_in++;
							break;
						case "+":
							bq_i.add(i - 1);
							bq_j.add(j);
							boom = false;
							break;
						default:
							Arr[i - 1][j] = Arr[i - 1][j];
					}
					switch (Arr[i][j + 1]) {
						case ".":
							Arr[i][j + 1] = "-";
							q_i.add (i);
							q_j.add (j + 1);
							counter_in++;
							break;
						case "+":
							bq_i.add(i);
							bq_j.add(j + 1);
							boom = false;
							break;
						default:
							Arr[i][j + 1] = Arr[i][j + 1];
					}
					switch (Arr[i][j - 1]) {
						case ".":
							Arr[i][j - 1] = "-";
							q_i.add (i);
							q_j.add (j - 1);
							counter_in++;
							break;
						case "+":
							bq_i.add(i);
							bq_j.add(j - 1);
							boom = false;
							break;
						default:
							Arr[i][j - 1] = Arr[i][j - 1];
					}
				}
			}
			//PerArrnw oles tis ekrikseis pou exoun (Arrn exoun) prArrgmArrtopoihthei
			while (!bq_i.isEmpty()) {
				Arr[bq_i.remove()][bq_j.remove()] = "*";
			}
			//KArrnw elegxw Arrn exei erthei h sinteleiArr tou kosmou Arrlliws sinexizw
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
	if(flag == false) {
		System.out.println(timer);
	}
	else {
		System.out.println("the world is saved");
	}
	for(i = 1; i <= N; i++) {
		for(j = 1; j <= M; j++) {
			System.out.print(Arr[i][j]);
		}
		System.out.println();
	}
    return 0;
	}
  
  public static void main(String[] args) {
    try {
		//Read M
		BufferedReader reader_1 = new BufferedReader(new FileReader(args[0]));
		String line_1 = reader_1.readLine();
		String[] a = line_1.split("");
		int M = a.length;
		reader_1.close();

		//Read N
		BufferedReader reader_2 = new BufferedReader(new FileReader(args[0]));
		int N = 0;
		while (reader_2.readLine() != null) N++;
		reader_2.close();
	
		//Read strings
		BufferedReader reader_3 = new BufferedReader(new FileReader(args[0]));
		String line_3 = reader_3.readLine();
		
		//Initialize Array
		String[][] Arr = new String[N + 2][M + 2];
		for(int i = 0; i < N + 2; i++) {
			for(int j = 0; j < M + 2; j++) {
				Arr[i][j] = "X";
			}
		}

		//Fill Array

		for(int i = 1; i <= N; i++) {
			String[] b = line_3.split("");
			for(int j = 1; j <= M; j++) {
				Arr[i][j] = b[j - 1];
			}
			line_3 = reader_3.readLine();
		}
		reader_3.close();
		/*for(int i = 1; i <= N; i++) {
			for(int j = 1; j <= M; j++) {
				System.out.print(Arr[i][j]);
			}
			System.out.println();
		}*/
		Queue<Integer> q_i = new LinkedList<Integer>();
		Queue<Integer> q_j = new LinkedList<Integer>();
		Queue<Integer> bq_i = new LinkedList<Integer>();
		Queue<Integer> bq_j = new LinkedList<Integer>();

		int counter_in = 0;
		int counter_out = 0;
		
		//Fill Queues
		for(int i = 0; i < N + 2; i++) {
			for(int j = 0; j < M + 2; j++) {
				if(Arr[i][j].equals("-") || Arr[i][j].equals("+")) {
					q_i.add(i);
					q_j.add(j);
					counter_out++;
				}
			}
		}
		int i = 0;
		int j = 0;
		int timer = 1;

		boolean flag = Boolean.valueOf(true);
		boolean boom = Boolean.valueOf(true);
		
		solve(N, M, q_i, q_j, bq_i, bq_j, Arr, i, j, flag, boom, counter_in, counter_out, timer);
		//System.out.println(q_i);
		//System.out.println(q_j);
		
		//System.out.println(N);
		//System.out.println(M);
    }
	catch(IOException e) {
		e.printStackTrace();
	}
  }
}

