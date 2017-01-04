defmodule FileCountOptim do
  @read_ahead_size 64 * 1024

  def current(path) do
    File.stream!(path) |> Enum.count
  end

  def proposed(path) do
    modes = [:raw, :read_ahead]
    pattern = :binary.compile_pattern("\n")
    counter = &count_pattern(&1, pattern, &2)
    read = &IO.binread(&1, @read_ahead_size)
    fun = &count_lines(&1, path, counter, read, 0)
    case File.open(path, modes, fun) do
      {:ok, count} ->
        count
      {:error, reason} ->
        raise File.Error, reason: reason, action: "stream", path: path
    end
  end

  def recur_count(path) do
    modes = [:raw, :read_ahead]
    counter = &count_recur/2
    read = &IO.binread(&1, @read_ahead_size)
    fun = &count_lines(&1, path, counter, read, 0)
    case File.open(path, modes, fun) do
      {:ok, count} ->
        count
      {:error, reason} ->
        raise File.Error, reason: reason, action: "stream", path: path
    end
  end

  def read_line(path) do
    modes = [:raw, :read_ahead]
    fun = &count_read_line(&1, path, 0)
    case File.open(path, modes, fun) do
      {:ok, count} ->
        count
      {:error, reason} ->
        raise File.Error, reason: reason, action: "stream", path: path
    end
  end

  defp count_read_line(device, path, count) do
    case :file.read_line(device) do
      {:ok, _} ->
        count_read_line(device, path, count + 1)
      :eof ->
        count
      {:error, reason} ->
        raise File.Error, reason: reason, action: "stream", path: path
    end
  end

  defp count_lines(device, path, count, read, acc) do
    case read.(device) do
      data when is_binary(data) ->
        count_lines(device, path, count, read, count.(data, acc))
      :eof ->
        acc
      {:error, reason} ->
        raise File.Error, reason: reason, action: "stream", path: path
    end
  end

  defp count_pattern(data, pattern, acc),
    do: length(:binary.matches(data, pattern)) + acc

  defp count_recur(<<?\n, rest::binary>>, n),
    do: count_recur(rest, n + 1)
  defp count_recur(<<_, rest::binary>>, n),
    do: count_recur(rest, n)
  defp count_recur(<<>>, n),
    do: n
end
