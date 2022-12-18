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

fun parse file =
    let
    (* A function to read an integer from specified input. *)
    fun readInt input = Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)
    fun readIntInf input = Option.valOf (TextIO.scanStream (IntInf.scan StringCvt.DEC) input)

    (* Open input file. *)
    val inStream = TextIO.openIn file

    (* Read an integer (number of pistes) and consume newline. *)
    val N = (readInt inStream) + 1
    val _ = TextIO.inputLine inStream

    fun readIntList 0 acc = rev acc 
        | readIntList i acc = readIntList (i - 1) (readInt inStream::acc)
    
    (* A function to read N pistes from the open file. *)
    fun readInts 0 acc = rev acc 
      | readInts i acc = 
        let
            val k = readInt inStream
            val r = readInt inStream
            val s = readIntInf inStream
        in
            readInts (i - 1) (( k, r, s, readIntList (k + r) [], []:int list) :: acc)
        end
        
    val pistesList = readInts N []
    in
   	(N - 1, pistesList)
    end
    
(* Sort a list of integers. *) 
fun mergeSort nil = nil 
    | mergeSort [e] = [e] 
    | mergeSort theList = 
    let
    (* From the given list make a pair of lists 
     * (x,y), where half the elements of the 
     * original are in x and half are in y. *) 
    fun halve nil = (nil, nil) 
        | halve [a] = ([a], nil) 
        | halve (a::b::cs) = 
        let 
            val (x, y) = halve cs 
        in
            (a::x, b::y) 
        end;
    (* Merge two sorted lists of integers into 
     * a single sorted list. *) 
     fun merge (nil, ys) = ys 
        | merge (xs, nil) = xs 
        | merge (x::xs, y::ys) = 
            if x < y then 
                x :: merge(xs, y::ys) 
            else 
                y :: merge(x::xs, ys); 
        val (x, y) = halve theList 
    in
        merge (mergeSort x, mergeSort y) 
    end;
    
(*Fix and sort pistesList inkeys and outkeys*)	
fun solve_1 (N, pistesList):int * (int * int * IntInf.int * int list * int list) list =
    let
        fun testfun1 [] = []
            | testfun1 ((k, r, s, ki, ko)::[]) = (k, r, s, mergeSort (rev (List.drop (rev ki, r))), mergeSort (List.drop (ki, k)))::[]
            | testfun1 ((k, r, s, ki, ko)::tl) = (k, r, s, mergeSort (rev (List.drop (rev ki, r))), mergeSort (List.drop (ki, k)))::testfun1 tl
            
        val new_pistesList = testfun1 pistesList

    in
        (N, new_pistesList)
    end

(*Insert pista 0 in Queue*)
fun solve_2 (N:int, pistesList:(int * int * IntInf.int * int list * int list) list) =
    let
        (*Data States: current, stars, visitedPistes, keysLeft*)
        val States = Queue.mkQueue() :(int * IntInf.int * int list * int list) Queue.queue 
        val temp_pista_0 = List.nth (pistesList, 0)
        val test = Queue.enqueue (States, (0, #3 temp_pista_0, [0], #5 temp_pista_0))
    in
        (N, pistesList, States)
    end
    
    fun abs n = if n<0 then ~n else n;

(*Algo slove*)
fun solve_3 (N:int, pistesList:(int * int * IntInf.int * int list * int list) list, States:(int * IntInf.int * int list * int list) Queue.queue) =
    let
        val inf_stars:IntInf.int = 0
        val final_stars = ref inf_stars
        val temp_States = Queue.mkQueue() :(int * IntInf.int * int list * int list) Queue.queue 
                    
        (*Return keys left: inkeys - keysleft prev States*)	
        fun delete_ListsElmns ([], []) = []
            | delete_ListsElmns (l, []) = []
            | delete_ListsElmns ([], l) = l
            | delete_ListsElmns (x::xs, y::ys) = if (x = y) then delete_ListsElmns (xs, ys) else if (x < y) then [y]@(delete_ListsElmns (xs, ys)) else [y]@(delete_ListsElmns (x::xs, ys))
  
        (*If false then visited pista*)	
        fun exists_in (item: int, mylist: int list) =
            if null mylist then 
                false
            else 
                if hd mylist = item then 
                    true
            else 
                exists_in (item, tl mylist)
                
        val test_1 = while (not (Queue.isEmpty States)) do
            let
                (*Data States: current, stars, visitedPistes, keysLeft*)
                val temp_State = Queue.dequeue States :int * IntInf.int * int list * int list
                val best = if ((!final_stars) >= (#2 temp_State)) then (!final_stars) else (#2 temp_State)
                val for_loop = 
                    for (1 to N)
                        (fn i =>
                            let
                                val temp_pista: int * int * IntInf.int * int list * int list = List.nth (pistesList, i)
                                val tmp_l = #4 temp_pista
                            in
                                if (not (exists_in (i, (#3 temp_State)))) then
                                    
                                    if ((length tmp_l = 0) orelse (mergeSort ((delete_ListsElmns (mergeSort ((delete_ListsElmns (tmp_l, (#4 temp_State)))), (#4 temp_State)))) = tmp_l andalso (mergeSort ((delete_ListsElmns (tmp_l, (#4 temp_State)))@tmp_l) = (#4 temp_State)))) then 
                                        if (length tmp_l = 0) then
                                            Queue.enqueue (States, (i, (#3 temp_pista) + (#2 temp_State), (#3 temp_State)@[i], mergeSort ((#5 temp_pista)@(#4 temp_State))))
                                        else
                                            Queue.enqueue (States, (i, (#3 temp_pista) + (#2 temp_State), (#3 temp_State)@[i], mergeSort (mergeSort (delete_ListsElmns ((#4 temp_pista), (#4 temp_State)))@(#5 temp_pista))))
                                    else									
                                        Queue.enqueue (temp_States, (i, (#3 temp_pista), (#3 temp_State), (#4 temp_pista)))
                                else
                                    Queue.enqueue (temp_States, (i, (#3 temp_pista), (#3 temp_State), (#4 temp_pista)))
                            end
                        )
            in
                final_stars := best
            end
    in
        final_stars
    end
    
fun pistes fileName = print (IntInf.toString (!(solve_3 (solve_2 (solve_1 (parse fileName))))) ^ "\n")