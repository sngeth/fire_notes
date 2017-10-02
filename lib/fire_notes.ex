defmodule FireNotes do
  @moduledoc """
  Documentation for FireNotes.
  """

  def add(text) do
    body = Poison.encode! %{"text" => text}

    case HTTPoison.post "#{api_url()}/notes.json?auth=#{database_secret()}", body do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body |> Poison.decode!
        IO.puts "Your note was saved!"

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
    end
  end

  def show do
    case HTTPoison.get "#{api_url()}/notes.json?auth=#{database_secret()}" do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body
        |> Poison.decode!
        |> print_notes()

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
    end
  end

  def print_notes(nil) do
    IO.puts "No notes to show"
  end

  def print_notes(res) do
    for {_, note} <- res, do: IO.puts note["text"]
  end

  def api_url do
    "https://fire-notes-7a80a.firebaseio.com"
  end

  def database_secret do
    System.get_env("FIRE_NOTES_SECRET")
  end
end
