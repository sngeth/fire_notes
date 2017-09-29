defmodule FireNotesTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "it can add a note using Firebase API" do
    assert capture_io(fn ->
      FireNotes.add "Hello World!"
    end) == "Hello World!\n"
  end
end
