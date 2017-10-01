defmodule FireNotesTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "it can add a note using Firebase API" do
    %{"name" => note_id} = FireNotes.add "Hello World!"
    assert note_id != nil
  end

  test "it can show all notes using Firebase API" do
    FireNotes.add "Learn Elixir"
    FireNotes.add "Learn Erlang"

    assert capture_io(fn ->
      FireNotes.show
    end) =~ "Learn Elixir\nLearn Erlang\n"
  end
end
