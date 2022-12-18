import java.io.*;
import java.util.Arrays;  
import java.util.List;  
import java.util.ArrayList;  
import java.util.LinkedList;
import java.util.Deque;
import java.lang.*;

public class pistes {

	//Number of pistes
	public static int N;
	
	//ArraList contains all pistes
	public static List<MyObject> pistes_ArrayList = new ArrayList<MyObject>();
	
	//Maximum stars
	public static long finalStars = 0;
	
	public static void main(String args[]) {
		try {
			//Read file
			BufferedReader reader = new BufferedReader(new FileReader(args[0]));
			
			//Read N
			N = Integer.parseInt(reader.readLine());
						
			for(int i = 0; i <= N; i++) {

				//Read all pistes
				//Temp ArraList pista_ArrayList for reading input
				List<Integer> pista_ArrayList = new ArrayList<Integer>();
			
				//ArraLists for inKeys, outKeys and visited pistes
				List<Integer> inKeys_ArrayList = new ArrayList<Integer>();
				List<Integer> outKeys_ArrayList = new ArrayList<Integer>();
				List<Integer> visit_ArrayList = new ArrayList<Integer>();
			
				//Ints for k, r and s
				int k_int;
				int r_int;
				long s_long;
			
				String[] a = reader.readLine().split(" ");
				int[] x = new int[a.length];
				
				for (int j = 0; j < a.length; j++) {
					pista_ArrayList.add(Integer.parseInt(a[j]));
				}
				k_int = pista_ArrayList.remove(0);
				r_int = pista_ArrayList.remove(0);
				s_long = Long.valueOf(pista_ArrayList.remove(0));

				for (int j = 0; j < k_int; j++) {
					inKeys_ArrayList.add(pista_ArrayList.remove(0));
				}

				visit_ArrayList.add(i);
				outKeys_ArrayList.addAll(pista_ArrayList);
				
				pistes_ArrayList.add(new MyObject(k_int, r_int, s_long, inKeys_ArrayList, outKeys_ArrayList, visit_ArrayList));
			}
			reader.close();
			//Help print
			//System.out.println(pistes_ArrayList.get(4).getVisited());
						
			Deque<State> deque = new LinkedList<State>();
						
			//Add first state into deque
			deque.add(new State(0, pistes_ArrayList.get(0).gets(), pistes_ArrayList.get(0).getoutKeys(), pistes_ArrayList.get(0).getVisited()));
			//Help print
			//System.out.println(deque.pollFirst().getKeysLeft()); //remove first element from queue and print it
			
			while(!deque.isEmpty()) {
				
				State st = deque.pollFirst();
				List<Integer> temp_ArrayList = new ArrayList<Integer>();
				//Help print
				//System.out.println(st.getCurrent());
				
				finalStars = Math.max(finalStars, st.stars);
				
				//All pistes can be visit
				temp_ArrayList = st.next_pistes();
				//Help print
				//System.out.println(st.getCurrent());
				
				for(int i = 0; i < temp_ArrayList.size(); i++) {
					
					List<Integer> temp_outKeys = new ArrayList<Integer>();
					List<Integer> temp_inKeys = new ArrayList<Integer>();
					List<Integer> temp_visit = new ArrayList<Integer>();
					temp_outKeys.addAll(pistes_ArrayList.get(temp_ArrayList.get(i)).getoutKeys());
					temp_inKeys.addAll(pistes_ArrayList.get(temp_ArrayList.get(i)).getinKeys());
					temp_visit.addAll(pistes_ArrayList.get(temp_ArrayList.get(i)).getVisited());
					
					int count = 0;
					
					
					temp_outKeys.addAll(st.keysLeft);
					for(int j = 0; j < temp_outKeys.size(); j++) {
						for(int l = 0; l < temp_inKeys.size(); l++) {
							if(temp_outKeys.get(j) == temp_inKeys.get(l)) {
								temp_outKeys.set(j, -1);
								temp_inKeys.set(l, -2);
							}
						}
					}
										
					for(int j = 0; j < temp_outKeys.size(); j++) {
						if(temp_outKeys.get(j) == -1) {
							temp_outKeys.set(j, -3);
						}
					}

					temp_visit.addAll(st.visitedPistes);
					
					deque.add(new State(temp_ArrayList.get(i), st.stars + pistes_ArrayList.get(temp_ArrayList.get(i)).gets(), temp_outKeys, temp_visit));
				}
			}
			System.out.println(finalStars);
		}
		catch(IOException e) {
			e.printStackTrace();
		}
	}
	
	public static class MyObject {
		public int k;
		public int r;
		public long s;
		public List<Integer> inKeys;
		public List<Integer> outKeys;
		public List<Integer> visited;
		
		//constructor
		public MyObject(int k, int r, long s, List<Integer> inKeys, List<Integer> outKeys, List<Integer> visited) {
			this.k = k;
			this.r = r;
			this.s = s;
			this.inKeys = inKeys;
			this.outKeys = outKeys;
			this.visited = visited;
		}
		
		public int getk() {
			return k;
		}

		public int getr() {
			return r;
		}

		public long gets() {
			return s;
		}

		public void sets(long s) {
			this.s = s;
		}
		
		public List<Integer> getinKeys() {
			return inKeys;
		}

		public List<Integer> getoutKeys() {
			return outKeys;
		}

		public List<Integer> getVisited() {
			return visited;
		}
	}
	
	public static class State {
		public int current;
		public long stars;
		public List<Integer> keysLeft;
		public List<Integer> visitedPistes;
		
		//constructor
		public State(int current, long stars, List<Integer> keysLeft, List<Integer> visitedPistes) {
			this.current = current;
			this.stars = stars;
			this.keysLeft = keysLeft;
			this.visitedPistes = visitedPistes;
		}
		
		public int getCurrent() {
			return current;
		}
		
		public long getStars() {
			return stars;
		}
		
		public List<Integer> getKeysLeft() {
			return keysLeft;
		}
		
		public List<Integer> getVisitedPistes() {
			return visitedPistes;
		}
		
		public List<Integer> next_pistes() {
			List<Integer> result = new ArrayList<Integer>();
			
			for(int i = 0; i <= N; i++) {
				List<Integer> temp_keysLeft = new ArrayList<Integer>();
				List<Integer> temp_inKeys = new ArrayList<Integer>();
				temp_keysLeft.addAll(keysLeft);
				temp_inKeys.addAll(pistes_ArrayList.get(i).getinKeys());
				int count = 0;
				
				if(visitedPistes.contains(i)) {
					continue;
				}
				
				for(int j = 0; j < temp_keysLeft.size(); j++) {
					for(int l = 0; l < temp_inKeys.size(); l++) {
						if(temp_inKeys.get(l) == temp_keysLeft.get(j)) {
							temp_inKeys.set(l, -1);
							temp_keysLeft.set(j, -2);
							count++;
						}
					}
				}

				if(count == pistes_ArrayList.get(i).getinKeys().size()) {
					result.add(i);
				}
			}
			//Help print
			//System.out.println(result);
			return result;
		}
	}
}
