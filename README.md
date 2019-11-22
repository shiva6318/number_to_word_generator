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
git clone https://github.com/shiva6318/number_to_word_generator.git
```

### Compile and Run

After cloning the project, Enter into the project, compile and run by below steps:

* To Enter into project 
```
cd number_to_world_generator
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
erl

  Erlang/OTP 19 [erts-9.2] [source-f9282c6] [smp:4:4] [async-threads:10] [hipe] [kernel-poll:false]
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
iex

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




