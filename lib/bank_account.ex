defmodule BankAccount do

  def start do
    loop
  end

  defp loop do
    receive do
      {:check_balance, pid} ->
        divulge_balance(pid)
    end
    loop
  end

  defp divulge_balance(pid) do
    send(pid, {:balance, 0})    
  end

end
