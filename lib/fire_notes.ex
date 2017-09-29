defmodule FireNotes do
  @moduledoc """
  Documentation for FireNotes.
  """

  def add(text) do
    body = Poison.encode! %{"text" => text}

    case HTTPoison.put "#{api_url}/note.json?auth=#{database_secret}", body do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body
        |> Poison.decode!
        |> Map.fetch!("text")
        |> IO.puts

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
    end
  end

  def api_url do
    "https://fire-notes-7a80a.firebaseio.com"
  end

  def database_secret do
    System.get_env("FIRE_NOTES_SECRET")
  end
end
