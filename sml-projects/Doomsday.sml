fun solve_3 (N, M, arr, Q) =
	let
		val boomQ = Queue.mkQueue() : (int*int*char) Queue.queue
		val testQ = Queue.mkQueue() : (int*int*char) Queue.queue
		
		val counter_out = ref (Queue.length Q)
		val counter_in = ref 0
		val counter_in_2 = ref 0
		val counter = ref 0
		val flag = ref 0
		val boom = ref 0
		val timer = ref 0
		
	in		
		while (!counter_out > 0 andalso !flag = 0) do (
			while (!counter_out > 0) do (
				let
				val q = Queue.dequeue Q;
				in
				
				case (Array2.sub (arr, #1 q, #2 q)) of
				#"+" =>	(case (Array2.sub (arr, (#1 q) + 1, #2 q)) of
						#"." => (Array2.update (arr, (#1 q) + 1, #2 q, #"+"), Queue.enqueue (Q, ((#1 q) + 1, #2 q, #"+")), counter_in := (!counter_in) + 1, flag := 0)
						| #"-" => (Array2.update (arr, (#1 q) + 1, #2 q, #"-"), Queue.enqueue (boomQ, ((#1 q) + 1, #2 q, #"*")), counter_in_2 := (!counter_in_2) + 1, boom := 1)
						| #"+" => (Array2.update (arr, (#1 q) + 1, #2 q, #"+"), Queue.enqueue (testQ, ((#1 q) + 1, #2 q, #"+")), counter_in := (!counter_in) + 0, flag := 0)
						| #"X" => (Array2.update (arr, (#1 q) + 1, #2 q, #"X"), Queue.enqueue (testQ, ((#1 q) + 1, #2 q, #"X")), counter_in := (!counter_in) + 0, flag := 0),
						case (Array2.sub (arr, (#1 q) - 1, #2 q)) of
						#"." => (Array2.update (arr, (#1 q) - 1, #2 q, #"+"), Queue.enqueue (Q, ((#1 q) - 1, #2 q, #"+")), counter_in := (!counter_in) + 1, flag := 0)
						| #"-" => (Array2.update (arr, (#1 q) - 1, #2 q, #"-"), Queue.enqueue (boomQ, ((#1 q) - 1, #2 q, #"*")), counter_in_2 := (!counter_in_2) + 1, boom := 1)
						| #"+" => (Array2.update (arr, (#1 q) - 1, #2 q, #"+"), Queue.enqueue (testQ, ((#1 q) - 1, #2 q, #"+")), counter_in := (!counter_in) + 0, flag := 0)
						| #"X" => (Array2.update (arr, (#1 q) - 1, #2 q, #"X"), Queue.enqueue (testQ, ((#1 q) - 1, #2 q, #"X")), counter_in := (!counter_in) + 0, flag := 0),
						case (Array2.sub (arr, #1 q, (#2 q) + 1)) of
						#"." => (Array2.update (arr, #1 q, (#2 q) + 1, #"+"), Queue.enqueue (Q, (#1 q, (#2 q) + 1, #"+")), counter_in := (!counter_in) + 1, flag := 0)
						| #"-" => (Array2.update (arr, #1 q, (#2 q) + 1, #"-"), Queue.enqueue (boomQ, (#1 q, (#2 q) + 1, #"*")), counter_in_2 := (!counter_in_2) + 1, boom := 1)
						| #"+" => (Array2.update (arr, #1 q, (#2 q) + 1, #"+"), Queue.enqueue (testQ, (#1 q, (#2 q) + 1, #"+")), counter_in := (!counter_in) + 0, flag := 0)
						| #"X" => (Array2.update (arr, #1 q, (#2 q) + 1, #"X"), Queue.enqueue (testQ, (#1 q, (#2 q) + 1, #"X")), counter_in := (!counter_in) + 0, flag := 0),
						case (Array2.sub (arr, #1 q, (#2 q) - 1)) of
						#"." => (Array2.update (arr, #1 q, (#2 q) - 1, #"+"), Queue.enqueue (Q, (#1 q, (#2 q) - 1, #"-")), counter_in := (!counter_in) + 1, flag := 0)
						| #"-" => (Array2.update (arr, #1 q, (#2 q) - 1, #"-"), Queue.enqueue (boomQ, (#1 q, (#2 q) - 1, #"*")), counter_in_2 := (!counter_in_2) + 1, boom := 1)
						| #"+" => (Array2.update (arr, #1 q, (#2 q) - 1, #"+"), Queue.enqueue (testQ, (#1 q, (#2 q) - 1, #"+")), counter_in := (!counter_in) + 0, flag := 0)
						| #"X" => (Array2.update (arr, #1 q, (#2 q) - 1, #"X"), Queue.enqueue (testQ, (#1 q, (#2 q) - 1, #"X")), counter_in := (!counter_in) + 0, flag := 0))
				| #"-" => (case (Array2.sub (arr, (#1 q) + 1, #2 q)) of
						#"." => (Array2.update (arr, (#1 q) + 1, #2 q, #"-"), Queue.enqueue (Q, ((#1 q) + 1, #2 q, #"-")), counter_in := (!counter_in) + 1, flag := 0)
						| #"+" => (Array2.update (arr, (#1 q) + 1, #2 q, #"+"), Queue.enqueue (boomQ, ((#1 q) + 1, #2 q, #"*")), counter_in_2 := (!counter_in_2) + 1, boom := 1)
						| #"-" => (Array2.update (arr, (#1 q) + 1, #2 q, #"-"), Queue.enqueue (testQ, ((#1 q) + 1, #2 q, #"-")), counter_in := (!counter_in) + 0, flag := 0)
						| #"X" => (Array2.update (arr, (#1 q) + 1, #2 q, #"X"), Queue.enqueue (testQ, ((#1 q) + 1, #2 q, #"X")), counter_in := (!counter_in) + 0, flag := 0),
						case (Array2.sub (arr, (#1 q) - 1, #2 q)) of
						#"." => (Array2.update (arr, (#1 q) - 1, #2 q, #"-"), Queue.enqueue (Q, ((#1 q) - 1, #2 q, #"-")), counter_in := (!counter_in) + 1, flag := 0)
						| #"+" => (Array2.update (arr, (#1 q) - 1, #2 q, #"+"), Queue.enqueue (boomQ, ((#1 q) - 1, #2 q, #"*")), counter_in_2 := (!counter_in_2) + 1, boom := 1)
						| #"-" => (Array2.update (arr, (#1 q) - 1, #2 q, #"-"), Queue.enqueue (testQ, ((#1 q) - 1, #2 q, #"-")), counter_in := (!counter_in) + 0, flag := 0)
						| #"X" => (Array2.update (arr, (#1 q) - 1, #2 q, #"X"), Queue.enqueue (testQ, ((#1 q) - 1, #2 q, #"X")), counter_in := (!counter_in) + 0, flag := 0),
						case (Array2.sub (arr, #1 q, (#2 q) + 1)) of
						#"." => (Array2.update (arr, #1 q, (#2 q) + 1, #"-"), Queue.enqueue (Q, (#1 q, (#2 q) + 1, #"-")), counter_in := (!counter_in) + 1, flag := 0)
						| #"+" => (Array2.update (arr, #1 q, (#2 q) + 1, #"+"), Queue.enqueue (boomQ, (#1 q, (#2 q) + 1, #"*")), counter_in_2 := (!counter_in_2) + 1, boom := 1)
						| #"-" => (Array2.update (arr, #1 q, (#2 q) + 1, #"-"), Queue.enqueue (testQ, (#1 q, (#2 q) + 1, #"-")), counter_in := (!counter_in) + 0, flag := 0)
						| #"X" => (Array2.update (arr, #1 q, (#2 q) + 1, #"X"), Queue.enqueue (testQ, (#1 q, (#2 q) + 1, #"X")), counter_in := (!counter_in) + 0, flag := 0),
						case (Array2.sub (arr, #1 q, (#2 q) - 1)) of
						#"." => (Array2.update (arr, #1 q, (#2 q) - 1, #"-"), Queue.enqueue (Q, (#1 q, (#2 q) - 1, #"-")), counter_in := (!counter_in) + 1, flag := 0)
						| #"+" => (Array2.update (arr, #1 q, (#2 q) - 1, #"+"), Queue.enqueue (boomQ, (#1 q, (#2 q) - 1, #"*")), counter_in_2 := (!counter_in_2) + 1, boom := 1)
						| #"-" => (Array2.update (arr, #1 q, (#2 q) - 1, #"-"), Queue.enqueue (testQ, (#1 q, (#2 q) - 1, #"-")), counter_in := (!counter_in) + 0, flag := 0)
						| #"X" => (Array2.update (arr, #1 q, (#2 q) - 1, #"X"), Queue.enqueue (testQ, (#1 q, (#2 q) - 1, #"X")), counter_in := (!counter_in) + 0, flag := 0));
						
						counter_out := (!counter_out) - 1

				end
			);
			while (!counter_in_2 > 0) do (
				let
					val bq = Queue.dequeue boomQ
				in
					Array2.update (arr, #1 bq, #2 bq, #3 bq);
					counter_in_2 := (!counter_in_2) - 1
				end
			);
			if (!boom = 1) then
				(flag := 1,
				counter_out := 0,
				counter_in := 0,
				counter_in_2 := 0,
				timer := (!timer) + 1)
			 else
				(flag := 0,
				counter_out := !counter_in,
				counter_in := 0,
				counter_in_2 := 0,
				timer := (!timer) + 1)
		);
			
		(N, M, arr, timer, flag)
	end
			
datatype for = to of int * int
    | downto of int * int

infix to downto

val for =
	fn lo to up =>
		(fn f => 
			let 
				fun loop lo = 
					if lo > up then 
						()
					else 
						(f lo; loop (lo+1))
			in 
				loop lo 
			end)
	| up downto lo =>
		(fn f => 
			let 
				fun loop up = 
					if up < lo then 
						()
					else 
						(f up; loop (up-1))
			in 
				loop up 
			end)

fun loop 0 f = f ()
  | loop n f = (f ();
loop (n-1) f)


open Char;
open String;
open List;

fun array2ToList arr = Array.foldr (op ::) [] arr

fun parse file =
    let 
		val instr = TextIO.openIn file
        val str   = TextIO.inputAll instr
    in 
		tokens isSpace str
		before
		TextIO.closeIn instr
    end

fun solve A = 
	let
		val N = length A
		
		fun lengthSubList nil = 0
			| lengthSubList (x::xs) = length x
			
		val M = lengthSubList A;
				
		val arr = Array2.fromList A;
		
		val arr_A = Array2.array (N + 2, M + 2, #"X")
		
	in
		(N, M, arr, arr_A)
			
	end

fun solve_1 (N, M, arr, arr_A) = 
	let
		val Ar = 
			for (0 to N-1)
				(fn i =>
					for (0 to M-1)
						(fn j =>
							Array2.update (arr_A, i + 1, j + 1, Array2.sub (arr, i, j)) 
						)
				)						
	in
		(N, M, arr_A)
	end

fun solve_2 (N, M, arr) = 
	let
		val Q = Queue.mkQueue() : (int*int*char) Queue.queue
		val Q_2 = Queue.mkQueue() : (int*int*char) Queue.queue
		
		val Ar = 
			for (0 to N+1)
				(fn i =>
					for (0 to M+1)
						(fn j =>
							let 
								val a = 
									if (Array2.sub (arr, i, j) = #"+") then
										Queue.enqueue (Q, (i, j, #"+"))
									else
										if (Array2.sub (arr, i, j) = #"-") then
											Queue.enqueue (Q, (i, j, #"-"))
										else
											Queue.enqueue (Q_2, (i, j, #"-"))
							in
								Q
							end
						)
				)						
	in
		(N, M, arr, Q)
	end

fun solve_4 (N, M, arr, timer, flag) = 
	let
		val A = Array2.array (N, M+1, "\n")
				
		val Ar = 
			for (0 to N-1)
				(fn i =>
					for (0 to M-1)
						(fn j =>
							Array2.update (A, i, j, (Char.toString (Array2.sub (arr, i+1, j+1)))) 
						)
				)
	in
		(A, timer, flag)
	end
	
fun myConcat (x, ans) = ans ^ x;

fun myprint arr = print (Array2.fold Array2.RowMajor myConcat "" arr);
	
fun doomsday file = 
	let
		val a = (solve_4 (solve_3 (solve_2 (solve_1 (solve (map explode (parse file)))))))
	in
		if ((!(#3 a)) = 0) then
			(print ("the world is saved"),
			print ("\n"),
			myprint (#1 a))
		else
			(print (Int.toString (!(#2 a))),
			print ("\n"),
			myprint (#1 a))
		end