defmodule Number_to_word_generator do
  @moduledoc """
  Module contain function to generator the possible words
  from given ten digit number using provided Dictionary file
  """
  @moduledoc since: "1.0.0"

  @doc """
  This function get all possible words 
  from dictionary using ten digit number.
  
  ## Parameters

    - ten_number: Integer that represents the 10 digit number
      
  Returns `:ok`.

  ## Examples

      iex> Number_to_word_generator.get_all_valid_words_from_number(2286854569)
      :ok
      [["act", "amounts"], ["act", "contour"], 
      ["bat", "amounts"], ["bat", "contour"], 
      ["acta", "mounts"], "catamounts"]

  """
  @doc since: "1.0.0"
  @spec get_all_valid_words_from_number(ten_number) :: integer()
  
  def get_all_valid_words_from_number( ten_number ) do

	valid_words_dictionary = %{2 => ["a","b","c"], 3 => ["d","e","f"], 4 => ["g","h","i"], 5 => ["j","k","l"], 6 => ["m","n","o"], 7 => ["p","q","r","s"], 8 => ["t","u","v"], 9 => ["w","x","y","z"]} ## map  used.
	
	list_of_words_from_dictionary = read_dictionary_file("dictionary.txt") 
	
#	IO.puts("list #{list_of_words_from_dictionary}")
	
	ten_Digits_list = split_phone_number_to_digits( ten_number )
	
	one_digit_bool = :lists.member(1,ten_Digits_list)
	
	zero_digit_bool = :lists.member(0,ten_Digits_list)
	
	case :erlang.length(ten_Digits_list) do
	   10 when ((one_digit_bool == false) and (zero_digit_bool ==false))->
	   
	   	function = fn(digit, acc) ->
	   			
	   			acc ++ [valid_words_dictionary[digit] ]
	   		   end
	   	
	   	alphabets_respective_to_digits = List.foldl(ten_Digits_list, [], function)
	   	
#	   	IO.puts("alphabets_respective_to_digits #{inspect alphabets_respective_to_digits}")
	
		spawn(Number_to_word_generator, :number_to_word_mapper,[alphabets_respective_to_digits, list_of_words_from_dictionary])
	
		:ok
	   _any_thing ->

	   	IO.puts "Enter Valid ten digit phone number without Zero and One"
	end
	:ok
	
   end
###################################################################################################  
@doc """
  This function reads whole file data and returns in a list
  
  ## Parameters

    - file: String that represents path of the file
      
  Returns : list of words from file

  ## Examples

      iex> Number_to_word_generator.read_dictionary_file("dictionary.txt")
       ["erlang", "is","a", "functional","language"]

  """
  @doc since: "1.0.0"
  @spec read_dictionary_file( String.t() ) :: list()
  
   defp read_dictionary_file( file ) do

	#{:ok, file_id} = File.open(file, [:read,:binary,:raw])
	#size = :filelib.file_size( file )
	#{:ok, data} = :file.pread( file_id, 0, size)
	
	{:ok, data} = File.read(file)
	
	String.split(String.downcase(data))
#	IO.puts("data #{a}")
	#:string.tokens(:erlang.binary_to_list(data), '\n')
   end
###################################################################################################  
  @doc """
  This function splits the Number into indiviual digits
  
  ## Parameters

    - ten_number: Integer that represents 10digit number
      
  Returns : list of digits

  ## Examples

      iex> Number_to_word_generator.read_dictionary_file(2288687964)
       [2,2,8,8,6,8,7,9,6,4]

  """
  @doc since: "1.0.0"
  @spec split_phone_number_to_digits( integer() ) :: list()

   defp split_phone_number_to_digits( ten_number ) do

	split_phone_number_to_digits(ten_number, [])
   end
	
   defp split_phone_number_to_digits(ten_number, accumulator) when ten_number < 10 do
	[ten_number | accumulator]
   end	
	
   defp split_phone_number_to_digits(ten_number, accumulator) do

	IO.puts "accumulator #{accumulator}"
	split_phone_number_to_digits( div(ten_number, 10), [ rem(ten_number, 10) | accumulator])
   end
   
###################################################################################################  
  @doc """
  This function validate the given word is prefix of words present in dictionary or not
  
  ## Parameters

    - number: Integer that represents number to find words length
    - word_to_find: String that represents word to find in dictionary
    - list_of_words_from_dictionary: List that represents dictionary words in list
      
  Returns : list of word which is matched with dictionary

  ## Examples

      iex> Number_to_word_generator.validate_word_presence_in_dictionary_list(4,"ab",["amo","sno",...])
       ["abcf","abde","abeh",...]

  """
  @doc since: "1.0.0"
  @spec validate_word_presence_in_dictionary_list( integer(),list(),list() ) :: list()
   
 def validate_word_presence_in_dictionary_list(number, word_to_find, list_of_words_from_dictionary) do

	function = fn(word_from_dictionary, accumulator) ->

		word_length =String.length(word_from_dictionary)

		case String.starts_with?(word_from_dictionary, word_to_find) do
			true when word_length == number->

				accumulator ++ [word_from_dictionary]
			true ->
				
				accumulator
			false ->
				
				accumulator
		end
	end
			
	List.foldl(list_of_words_from_dictionary,[],function)
   end
################################################################################################### 
  @doc """
  This function extract the valid words present in the dictionary for the combination made using 
  given number
  
  ## Parameters

    - number: Integer that represents number to find words length
    - first_list_of_number: List that represents letter for digit
    - tail_of_remaining_list: List that represent letter for remaining digits
    - list_of_words_from_dictionary: List that represents dictionary words in list
      
  Returns : list of valid word which is matched with dictionary

  ## Examples

      iex> Number_to_word_generator.validate_word_presence_in_dictionary_list(4,["m","n","o"],
                                                                                [["a","b","c"],["m","n","o"]],
                                                                                ["amo","sno",...])
       ["noun","onto","moto",...]

  """
  @doc since: "1.0.0"
  @spec extract_valid_words_from_dictionary_list( integer(),list(),list(),list() ) :: list()

 def extract_valid_words_from_dictionary_list(_number,_first_list_of_number, [], []) do
	
	[]
   end
   	
   def extract_valid_words_from_dictionary_list(_number,_first_list_of_number, _tail_of_remaining_list, []) do

	[]
   end
   
   def extract_valid_words_from_dictionary_list(_number,_first_list_of_number, [], valid_words_list_from_dictionary) do		
	
	valid_words_list_from_dictionary
   end
   	
 def extract_valid_words_from_dictionary_list(number, first_list_of_number, [head_of_remaining_list | tail_of_remaining_list], list_of_words_from_dictionary) do

	 combination_of_alphabets_list =  for alphabet1 <- first_list_of_number, alphabet2 <- head_of_remaining_list, do: Enum.join([alphabet1,alphabet2],"") 

	 function = fn(word_from_combination_list, acc) ->

		 acc ++ validate_word_presence_in_dictionary_list(number,word_from_combination_list, list_of_words_from_dictionary)
		
		end
		
	 valid_words_list_from_dictionary = List.foldl(combination_of_alphabets_list, [], function)
 #	IO.puts("valid_words_list_from_dictionary #{inspect valid_words_list_from_dictionary}")	
	 extract_valid_words_from_dictionary_list(number, combination_of_alphabets_list, tail_of_remaining_list, valid_words_list_from_dictionary)
   end
   
##############################################################################################################
 @doc """
  This function do rpc async call to find valid words from dictionary and returns a list
  
  ## Parameters

    - number: Integer that represents number to find words length
    - first_list_of_number: List that represents letter for digit
    - tail_of_remaining_list: List that represent letter for remaining digits
    - list_of_words_from_dictionary: List that represents dictionary words in list
      
  Returns : list of valid word which is matched with dictionary

  ## Examples

      iex> Number_to_word_generator.validate_word_presence_in_dictionary_list(4,["m","n","o"],
                                                                                [["a","b","c"],["m","n","o"]],
                                                                                ["amo","sno",...])
       [["act", "amounts"], ["act", "contour"],["bat", "amounts"], ["bat", "contour"],  
       ["acta", "mounts"], "catamounts"]

  """
  @doc since: "1.0.0"
  @spec number_to_word_mapper( list(), list() ) :: list()
  
 def number_to_word_mapper( alphabets_respective_to_digits, list_of_words_from_dictionary) do

	function_to_find_valid_words = 
		fn(number, accumulator) ->
		
			{first_number_alphabets_list,remaining_number_alphabets_list } = Enum.split(alphabets_respective_to_digits, number)
		
		#	IO.puts("first_number_alphabets_list #{inspect first_number_alphabets_list},remaining_number_alphabets_list #{inspect remaining_number_alphabets_list }")
			{[head_of_first_number_alphabets_list],tail_of_first_number_alphabets_list } = Enum.split( first_number_alphabets_list, 1)
			{[head_of_remaining_number_alphabets_list],tail_of_remaining_number_alphabets_list }= Enum.split( remaining_number_alphabets_list,1)
	#		IO.puts("came #{number} head #{inspect head_of_first_number_alphabets_list} tail #{ inspect tail_of_first_number_alphabets_list} ")
			task_key1 = Task.async( Number_to_word_generator, :extract_valid_words_from_dictionary_list, 
					 [number, head_of_first_number_alphabets_list,tail_of_first_number_alphabets_list,list_of_words_from_dictionary])
	
			task_key2 = Task.async( Number_to_word_generator, :extract_valid_words_from_dictionary_list, 
					 [(10-number), head_of_remaining_number_alphabets_list,tail_of_remaining_number_alphabets_list,list_of_words_from_dictionary])
		
		
		accumulator ++[{number, task_key1,task_key2}]
	    end
		
	list_of_key = List.foldl([3,4,5,6,7],[],function_to_find_valid_words)
	
#	IO.puts("near 10 list_of_key ")
	## for 10digits word 
	{[first_number_list], remaining_number_lists} = Enum.split(alphabets_respective_to_digits,1)
	
	task_key11 = Task.async( Number_to_word_generator, :extract_valid_words_from_dictionary_list, [10, Enum.take(first_number_list,1), remaining_number_lists, list_of_words_from_dictionary])
	
	task_key12 = Task.async( Number_to_word_generator, :extract_valid_words_from_dictionary_list, [10,Enum.take(first_number_list,2), remaining_number_lists, list_of_words_from_dictionary])
	
	task_key13 = Task.async( Number_to_word_generator, :extract_valid_words_from_dictionary_list, [10,Enum.take(first_number_list,3), remaining_number_lists, list_of_words_from_dictionary])
	
	function = fn(key_tuple, acc)->
			
			case key_tuple do
			   {_number,key1, key2 } ->
			   	#IO.puts("key1 #{ inspect key1}, key2 #{inspect key2}")
				task1_result = Task.await(key1,:infinity)
				task2_result = Task.await(key2,:infinity)
				#IO.puts("task1_result #{inspect task1_result} task2_result #{inspect task2_result}")
				cond do
				
				(task1_result == []) or (task2_result == []) 
					->
					  acc
				   true ->
				   	acc ++ for  element1 <- task1_result, element2 <-task2_result, do: [String.downcase(element1),String.downcase(element2)]
				 end
		          {_number,task1,task2, task3} ->
			 
			 	task11_result = Task.await(task1,:infinity)
				task12_result = Task.await(task2,:infinity)
				task13_result = Task.await(task3,:infinity)
				
				acc ++task11_result++task12_result++task13_result
			end
		 
		 end
		 
		possible_words_list = List.foldl(list_of_key++[{10,task_key11,task_key12,task_key13}], [], function)
		
		IO.puts "Possible_words_list #{inspect possible_words_list}"

##		BB =erlang:now()
##		io:format("End time ~p~nDiff:~p~n",[BB,timer:now_diff(BB,AA)])
		possible_words_list
    end
    
    
end
