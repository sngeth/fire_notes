defmodule FireNotesTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import ExUnit.CaptureIO

  setup_all do
    HTTPoison.start
  end

  test "add notes using Firebase API" do
    ExVCR.Config.filter_url_params(true)

    use_cassette "firebase_post" do
      %{"name" => note_id} = FireNotes.add "Learn Elixir"
      assert note_id != nil

      assert capture_io(fn ->
        FireNotes.show
      end) =~ "Learn Elixir\n"
    end
  end
end
