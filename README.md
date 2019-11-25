# Number To Word Generator

This Project is used to generate possible words or combination of words from provided dictionary file for given 10 digit 
phone number.

## Getting Started

Number to word generator project is written in erlang and elixir language.

### Prerequisites

To use this project. You should install
* Erlang
* Elixir

### How to Install 

* Ubuntu 14.04/16.04/17.04/18.04/19.04 or Debian 7/8/9

```
1. Add Erlang Solutions repo: wget https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb && sudo dpkg -i erlang-solutions_2.0_all.deb
2. Run: sudo apt-get update
3. Install the Erlang/OTP platform and all of its applications: sudo apt-get install esl-erlang
4. Install Elixir: sudo apt-get install elixir
```
### Clone Project from Git

First open terminal, Press *Ctrl + Alt + t* 

```
shiva@shiva:~/Desktop$ git clone https://github.com/shiva6318/number_to_word_generator.git
Cloning into 'number_to_word_generator'...
remote: Enumerating objects: 38, done.
remote: Counting objects: 100% (38/38), done.
remote: Compressing objects: 100% (33/33), done.
remote: Total 38 (delta 13), reused 11 (delta 2), pack-reused 0
Unpacking objects: 100% (38/38), done.
```

### Compile and Run

After cloning the project, Enter into the project, compile and run by below steps:

* To Enter into project 
```
shiva@shiva:~/Desktop$ cd number_to_world_generator
shiva@shiva:~/number_to_word_generator$
```
In the folder, there are four files

1) **README.md** - File which explains about project and how to install and use it
2) **number_to_word_generator.erl** - Erlang file which will have functions to convert 10 digit phone number to possible words 
or combination of word from provided dictionary file.
3) **number_to_word_generator.ex** - Elixir file which will have functions to convert 10 digit phone number to possible words 
or combination of word from provided dictionary file.
4) **dictionary.txt** - Text file which have words for A to Z alphabets and it is used by erlang and elixir file to generator possible words for given number.

* To Compile and Run in erlang use below steps:

1. To get erlang shell
```
  shiva@shiva:~/number_to_word_generator$ erl

  Erlang/OTP 20 [erts-9.2] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:10] [kernel-poll:false]
  
  Eshell V9.2  (abort with ^G)
  1> 
```
2. To compile
```
2> c(number_to_word_generator).
{ok,number_to_word_generator}
```
3. Run the file
```
3> number_to_word_generator:get_all_valid_words_from_number(2282668687).
ok
Possible_words_list:[["act","amounts"],
                     ["act","contour"],
                     ["bat","amounts"],
                     ["bat","contour"],
                     ["cat","amounts"],
                     ["cat","contour"],
                     ["acta","mounts"],
                     "catamounts"]
```

* To Compile and Run in Elixir use below steps:

1. To get Elixir shell
```
shiva@shiva:~/number_to_word_generator$ iex

Erlang/OTP 20 [erts-9.2] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:10] [kernel-poll:false]

Interactive Elixir (1.3.3) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> 
```
2. To compile
```
iex(2)>  c("number_to_word_generator.ex")
[Number_to_word_generator]
```
3. Run the file
```
3> Number_to_word_generator.get_all_valid_words_from_number(2282668687).
:ok
Possible_words_list [["act", "amounts"], ["act", "contour"], ["bat", "amounts"], ["bat", "contour"], ["cat", "amounts"], ["cat", "contour"], ["acta", "mounts"], "catamounts"]
```

### ExUnit Test 

* To test the project using ExUnit:

1) Open terminal in project directory and type below command
```
shiva@shiva:~/number_to_word_generator$ elixir -r number_to_word_generator.ex number_to_word_generator_test.exs
..

Finished in 4.8 seconds (0.02s on load, 4.8s on tests)
2 tests, 0 failures

Randomized with seed 288247

```

## Design and Issues:

Project aim is to get all possible combination of words from provided dictionary for any given 10digit
phone number. Some Conditions are there for the project like word should be alteast contain 3 letters, 
output should be displayed in 1000ms and code should be written in elixir. 

First I started working on generating the required output in erlang because i dont have experience in Elixir.
I wrote one function to read all words present in dictionary and append in a list. Then I wrote another function
which will take argument as 3 to 10 and extract the words from dictionary list. The words from  list will
be taken and form order based on word length and displayed as output. But problem is displaying the output is taking 
more than one minute time.

Lets see how i sloved that, I started working how to display the output in 1000ms. I have analysed the code then i found the
problem. That is because of multiple loop for generate 3 to 10 letter words from dictionary list in sequence order.
every time we are scanning the list and extracting the valid words one by one. So i thought, i will scan the list
parallel for every number i.e, 3 to 10. Then i used rpc async call to do that. Even though displaying 
output is taking 25 seconds. Again i have analysed the time taken by each number then I found that 10 
letter word scaning is taking more time. So i splitted the scanning of 10letter word into 3 async call
then displaying output is within 1000ms. The project is completed in erlang but it should be in elixir.

Then I started learning basics of elixir and started converting the erlang code into elixir. The displaying 
output is same using elixir code but time taken is 20seconds. i tired to reduce the time to display
the output but i didnt succeded even though i am trying to do that by understanding the elixir implementation. I have attached the erlang code, elixir code and test file in the project.
Added READme file for reference to install, execute and use the project. 
 

