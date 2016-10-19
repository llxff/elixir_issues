defmodule Issues.TablePrinter do
  @columns Application.get_env(:issues, :columns)

  def puts([]) do
    IO.puts("No data")
  end

  def puts(issues) do
    print_header
    Enum.each(issues, &print_issue/1)
  end

  defp print_header do
    @columns
    |> Enum.map(&(fit_to_cell(&1.name, &1.size)))
    |> Enum.join("|")
    |> IO.puts

    @columns
    |> Enum.map(&separator/1)
    |> Enum.join("+")
    |> IO.puts
  end

  defp fit_to_cell(data, size) do
    data
    |> String.pad_leading(String.length(data) + 1)
    |> String.pad_trailing(size)
  end

  defp separator(%{ size: size }) do
    String.duplicate("-", size)
  end

  defp print_issue(issue) do
    @columns
    |> Enum.map(&(issue_value(issue, &1)))
    |> Enum.join("|")
    |> IO.puts
  end

  defp issue_value(issue, %{ size: size, value: key}) do
    issue[key]
    |> to_string
    |> cut_string(size)
    |> fit_to_cell(size)
  end

  defp cut_string(data, size) do
    if String.length(data) <= size do
      data
    else
      String.slice(data, 0, size - 4) <> "..."
    end
  end
end
