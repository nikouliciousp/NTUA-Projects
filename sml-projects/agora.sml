fun parse file =
	let
		(* A function to read an integer from specified input. *)
        fun readInt input = 
	    Option.valOf (TextIO.scanStream (LargeInt.scan StringCvt.DEC) input)

		(* Open input file. *)
    	val inStream = TextIO.openIn file

        (* Read an integer N (number of villages) and consume newline. *)
		val N:IntInf.int = readInt inStream
		val _ = TextIO.inputLine inStream

        (* A function to read N integers from the open file. *)
		fun readInts 0 acc = rev acc (* Replace with 'rev acc' for proper order. *)
			| readInts i acc = readInts (i - 1) (readInt inStream::acc)
			
		val villages = readInts N []
    in
		(N, villages)
    end
				   
fun solve (N:IntInf.int, villages) = 
	let
		
		fun gcd (a:IntInf.int, b:IntInf.int) = 
			if (b = 0) then 
				a 
		else 
			(gcd (b, a mod b))
		
		fun lcp (a:IntInf.int, b:IntInf.int) = ((a * b) div gcd (a, b))
							 
		(*val A = villages;*)

		(*Create list index*)
		fun createList (start, ending) = 
			if(start = ending) then
				[]
			else
				start::createList(start + 1, ending)
				
		(*val B = createList (1, N + 1)*)
		
		fun zipLists nil l = nil
			|   zipLists l nil  = nil
			|   zipLists (a::la) (b::lb)  = (a:IntInf.int, b:IntInf.int)::(zipLists la lb);
		
		(*val villages = zipLists A B*)

		fun check [] = []
			| check ((f1, f2)::[]) = 
				(f1, f2)::[]
			| check ((f1, f2)::(f3, f4)::[]) = 
				if (lcp (f1, f3) <= f1) then
					(f1, 0)::(f3, f4)::[]
				else	
					(f1, f4)::(f3, f4)::[]
			| check ((f1, f2)::(f3, f4)::(f5, f6)::tl) = 
				if (lcp (f1, f3) <= lcp (f1, f5)) then 
					(f1, f2)::check ((lcp (f1, f3), 0)::(f5, f6)::tl)
				else 
					(f1, f2)::check ((lcp (f1, f5), 0)::(f3, f4)::tl)
					
		(*val A = check villages
		val B = check (rev villages)*)
		
		fun nth (xs, i:IntInf.int) =
			if i < 0 then 
				raise Subscript
			else
				case xs of
					[] => raise Subscript
			| (x::xs') => 
				if i=0 then 
					x 
				else 
					nth(xs',i-1)
					
		val result_1 = nth (check (zipLists villages (createList (1, N + 1))), N - 2)
		val result_2 = nth (check (rev (zipLists villages (createList (1, N + 1)))), N - 2)
		
		val result = 
			if ((#1 result_1) < (#1 result_2)) then
				result_1
			else
				result_2
		
	in
		result : (IntInf.int * IntInf.int)
	end
		
fun agora fileName = print (LargeInt.toString (#1 (solve (parse fileName))) ^ " " ^ LargeInt.toString (#2 (solve (parse fileName))) ^ "\n")

(*fun main ()=
	let
		val argv= (CommandLine.arguments())
		val file = hd argv
		val result = (agora file)
	in 
		print (LargeInt.toString (#1 result) ^ " " ^ LargeInt.toString (#2 result) ^ "\n")
end

val _ = main ()*)  