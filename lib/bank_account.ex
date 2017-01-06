defmodule BankAccount do

  def start do
    loop([])
  end

  defp loop(events) do
    receive do
      {:check_balance, pid} ->
        divulge_balance(pid, events)
        loop(events)
      {:deposit, amount} ->
        events = deposit(amount, events)
        loop(events)
    end
  end

  defp divulge_balance(pid, events) do
    send(pid, {:balance, calculate_balance(events)})    
  end

  defp calculate_balance(events) do
    deposits = sum(events)
    deposits
  end

  defp sum(events) do
    Enum.reduce(events, 0, fn({_, amount}, acc) -> acc + amount end)
  end

  defp deposit(amount, events) do
    events ++ [{:deposit, amount}]
  end
end
