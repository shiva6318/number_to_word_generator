
ExUnit.start                        # Start the ExUnit

defmodule Number_word_generator_test do

  use ExUnit.Case                   # Using the test frame work here


  test "test1" do
    assert Number_to_word_generator.get_all_valid_words_from_number(2282668687) == :ok
    
  end
  test "test2" do
    
    assert Number_to_word_generator.get_all_valid_words_from_number(6685256522) == :ok
  end
end
