%%% ==================================================================
%%% File: "number_to_word_generator.erl"
%%%
%%% @author Gattu shivakrishna <shiva.krishn17892@gmail.com>
%%%
%%% @version 1.0.0
%%%
%%% Created : Monday, November 18 2019.
%%%
%%% @doc
%%% 	Module contain function to generator the possible words
%%    from given ten digit number using provided Dictionary file.
%%%
%%% @end
%%%
%%% @copyright 2019, GSK
%%% ==================================================================

-module(number_to_word_generator).

%% ==================================================================
%% EXPORT SECTION
%% ==================================================================

-export([ get_all_valid_words_from_number/1,
          number_to_word_mapper/3,
          extract_valid_words_from_dictionary_list/4
        ]).


%% ==================================================================
%% APIs
%% ==================================================================

%%------------------------------------------------------------------------------
%% @doc This function get all possible words from dictionary using ten digit number
%%
%% Function has one argument
%%
%%	Argument 1 : Ten number
%%  Eg : 2282968566
%%
%% Return values :  
%%  		ok
%%
%% 
%% @spec get_all_valid_words_from_number( integer() ) -> atom()
%%
%% @end
%% -----------------------------------------------------------------------------
-spec( get_all_valid_words_from_number( integer() ) -> atom() ).

get_all_valid_words_from_number( Ten_number ) ->

	AA = erlang:now(),

	Valid_words_dictionary = dict:from_list([{2,["a","b","c"]},{3,["d","e","f"]},{4,["g","h","i"]},{5,["j","k","l"]},{6,["m","n","o"]},{7,["p","q","r","s"]},{8,["t","u","v"]},{9,["w","x","y","z"]}]),
	
	List_of_words_from_dictionary = read_dictionary_file("dictionary.txt"), 

	Ten_Digits_list = split_phone_number_to_digits( Ten_number ),
	
	One_digit_bool = lists:member(1,Ten_Digits_list),
	Zero_digit_bool = lists:member(0,Ten_Digits_list),
	
	case erlang:length(Ten_Digits_list) of
	   10 when ((One_digit_bool == false) andalso (Zero_digit_bool ==false))->
	   
	   	Function = fun(Digit, Acc) ->
	   		
	   			Acc ++ [dict:fetch(Digit,Valid_words_dictionary )]
	   		   end,
	   	
	   	Alphabets_respective_to_digits = lists:foldl(Function,[], Ten_Digits_list),
	
		spawn(?MODULE,number_to_word_mapper,[AA,Alphabets_respective_to_digits, List_of_words_from_dictionary]),
	
		ok;
	   _Any_thing ->
	   	io:format("Enter Valid ten digit phone number without Zero and One")
	  end,
	ok.
	
%%------------------------------------------------------------------------------
%% @doc This function reads whole file data and returns in a list
%%
%% Function has one argument
%%
%%	Argument 1 : File name
%%  Eg : "dictionary.txt"
%%
%% Return values :  list of words from file
%%  		Eg: ["erlang", "is","a", "functional","language"]
%% 
%% @spec read_dictionary_file( list() ) -> list()
%%
%% @end
%% -----------------------------------------------------------------------------
-spec( read_dictionary_file( list() ) -> list() ).

read_dictionary_file(File) ->

	{ok, File_id} = file:open(File, [read,binary,raw]),
	Size = filelib:file_size(File), 
	{ok, Data} = file:pread(File_id, 0, Size),
	string:tokens(binary_to_list(Data), "\n").
	

%%------------------------------------------------------------------------------
%% @doc This function splits the Number into indiviual digits
%%
%% Function has one argument
%%
%%	Argument 1 : Ten digit number
%%  Eg : 2288687964
%%
%% Return values :  list of digits
%%  		Eg: [2,2,8,8,6,8,7,9,6,4]
%% 
%% @spec split_phone_number_to_digits( integer() ) -> list()
%%
%% @end
%% -----------------------------------------------------------------------------
-spec( split_phone_number_to_digits( integer() ) -> list() ).

split_phone_number_to_digits( Ten_number ) ->

	split_phone_number_to_digits(Ten_number, []).
	
split_phone_number_to_digits(Ten_number, Accumulator) when Ten_number < 10->
	[Ten_number | Accumulator];
	
split_phone_number_to_digits(Ten_number, Accumulator) ->

	split_phone_number_to_digits( (Ten_number div 10), [ (Ten_number rem 10) | Accumulator]).
	
%%------------------------------------------------------------------------------
%% @doc This function validate the word is present in the dictionary or not
%%
%% Function has three argument
%%
%%	Argument 1 :  number to find words length
%%  Eg : 3 or 4 or 7 ..
%%	Argument 2 : word to find in dictionary
%%  Eg : "onto"
%%	Argument 3 : dictionary words in list
%%  Eg : ["AA","AMN","AMNY"......]
%%
%% Return values :  list of word which is matched with dictionary
%%  		Eg: ["ONTO","NOUN",....]
%% 
%% @spec validate_word_presence_in_dictionary_list(  integer(), list(),list() ) -> list()
%%
%% @end
%% -----------------------------------------------------------------------------
-spec( validate_word_presence_in_dictionary_list( integer(), list(),list() ) -> list() ).

validate_word_presence_in_dictionary_list(Number, Word_to_find, List_of_words_from_dictionary) ->
	
	Function = fun(Word_from_dictionary, Accumulator) ->
	
		case lists:prefix(string:to_upper(Word_to_find), Word_from_dictionary)  of
			true when erlang:length(Word_from_dictionary) ==Number->
				Accumulator ++ [Word_from_dictionary];
			true ->
				Accumulator;
			false ->
				Accumulator
		end
	end,
			
	lists:foldl(Function,[],List_of_words_from_dictionary).
	
%%------------------------------------------------------------------------------
%% @doc This function extract the valid words present in the dictionary
%%
%% Function has four argument
%%
%%	Argument 1 :  number to find words length
%%  Eg : 3 or 4 or 7 ..
%%	Argument 2 : Combination of word
%%  Eg : "ont"
%%	Argument 3 : remaining list of word
%%  Eg : [["m","n","o"],["a","b","c"]]
%%	Argument 4 :  list of word which is matched with dictionary
%%  		Eg: ["ONTO","NOUN",....]
%%
%% Return values :  valid words from dictionary
%%  		Eg: ["ONTO","NOUN",....]
%% 
%% @spec extract_valid_words_from_dictionary_list(  integer(), list(),list(),list() ) -> list()
%%
%% @end
%% -----------------------------------------------------------------------------
-spec( extract_valid_words_from_dictionary_list( integer(), list(),list(),list() ) -> list() ).

extract_valid_words_from_dictionary_list(_Number,_First_list_of_number, [], [])->
	
	[];
	
extract_valid_words_from_dictionary_list(_Number,_First_list_of_number, _Tail_of_remaining_list, []) ->

	[];
extract_valid_words_from_dictionary_list(_Number,_First_list_of_number, [], Valid_words_list_from_dictionary) ->		
	
	Valid_words_list_from_dictionary;
	
extract_valid_words_from_dictionary_list(Number, First_list_of_number, [Head_of_remaining_list | Tail_of_remaining_list], List_of_words_from_dictionary) ->

	Combination_of_alphabets_list = [string:join([Alphabet1,Alphabet2],"")|| Alphabet1 <- First_list_of_number, Alphabet2 <- Head_of_remaining_list],
	
	Function = fun(Word_from_combination_list, Acc) ->
	
		Acc ++ validate_word_presence_in_dictionary_list(Number,Word_from_combination_list, List_of_words_from_dictionary)
		
		end,
		
	Valid_words_list_from_dictionary = lists:foldl(Function, [], Combination_of_alphabets_list),
		
	extract_valid_words_from_dictionary_list(Number, Combination_of_alphabets_list, Tail_of_remaining_list, Valid_words_list_from_dictionary).	
	
	
%%------------------------------------------------------------------------------
%% @doc This function do rpc async call to find valid words from dictionary 
%%      and returns a list
%%
%% Function has three argument
%%
%%	Argument 1 : time 
%%  Eg : {15651,155565,15416166}
%%	Argument 2 : List with aplhabets for digits
%%  Eg : [["m","n","o"],["a","b","c"].....]
%%	Argument 3 : dictionary words in list
%%  Eg : ["AA","AMN","AMNY"......]
%%
%% Return values : possible words for given number
%%  		Eg: [["act", "amounts"], ["act", "contour"], 
%%          ["bat", "amounts"], ["bat", "contour"], 
%%          ["acta", "mounts"], "catamounts"]
%% 
%% @spec number_to_word_mapper(  tuple(),list(),list() ) -> list()
%%
%% @end
%% -----------------------------------------------------------------------------
-spec( number_to_word_mapper( tuple(),list(),list() ) -> list() ).

number_to_word_mapper(Time,Alphabets_respective_to_digits, List_of_words_from_dictionary) ->

	Function_to_find_valid_words = 
		fun(Number, Accumulator) ->
		
			{First_number_alphabets_list,Remaining_number_alphabets_list }= lists:split(Number, Alphabets_respective_to_digits),
		
			{[Head_of_first_number_alphabets_list],Tail_of_first_number_alphabets_list }= lists:split(1, First_number_alphabets_list),
			{[Head_of_remaining_number_alphabets_list],Tail_of_remaining_number_alphabets_list }= lists:split(1, Remaining_number_alphabets_list),
		
			Rpc_key1 = rpc:async_call(node(), ?MODULE, extract_valid_words_from_dictionary_list, 
					 [Number, Head_of_first_number_alphabets_list,Tail_of_first_number_alphabets_list,List_of_words_from_dictionary]),
					 
			Rpc_key2 = rpc:async_call(node(), ?MODULE, extract_valid_words_from_dictionary_list, 
					 [(10-Number), Head_of_remaining_number_alphabets_list,Tail_of_remaining_number_alphabets_list,List_of_words_from_dictionary]),
		
		
		Accumulator ++[{Number, Rpc_key1,Rpc_key2}]
	    end,
		
	List_of_key = lists:foldl(Function_to_find_valid_words,[],[3,4,5,6,7]),
	
	
	
	
	{[First_number_list], Remaining_number_lists} = lists:split(1,Alphabets_respective_to_digits),
	

	Rpc_key1 = rpc:async_call(node(), ?MODULE, extract_valid_words_from_dictionary_list, [10,[lists:nth(1,First_number_list)],Remaining_number_lists,List_of_words_from_dictionary]), 
	
	Rpc_key2 = rpc:async_call(node(), ?MODULE, extract_valid_words_from_dictionary_list, [10,[lists:nth(2,First_number_list)],Remaining_number_lists,List_of_words_from_dictionary]),
	
	Rpc_key3 = rpc:async_call(node(), ?MODULE, extract_valid_words_from_dictionary_list, [10,[lists:nth(3,First_number_list)],Remaining_number_lists,List_of_words_from_dictionary]),
	
	Function = fun(Key_tuple, ACC)->
	
			case Key_tuple of
			   {_Number,Key1, Key2 } ->
				Key1_Result = rpc:yield(Key1),
				Key2_Result = rpc:yield(Key2),
					
				if (Key1_Result == []) or (Key2_Result == []) 
					->
					  ACC;
				   true ->
				   	ACC ++ [[string:to_lower(X),string:to_lower(Y)] || X<-Key1_Result,Y<-Key2_Result]
				 end;
		          {_Number,Key1,Key2, Key3} ->
			 
			 	Key1_result = rpc:yield(Key1),
				Key2_result = rpc:yield(Key2),
				Key3_result = rpc:yield(Key3),
				
				ACC ++Key1_result++Key2_result++Key3_result
			end
		 
		 end,
		Possible_words_list = lists:foldl(Function,[],List_of_key++[{10,Rpc_key1,Rpc_key2,Rpc_key3}]),
		io:format("Possible_words_list:~p~n",[Possible_words_list]),
		End_time =erlang:now(),
		io:format("End time ~p~nDiff:~p~n",[BB,timer:now_diff(End_time,Time)]),
		Possible_words_list.
	
	
