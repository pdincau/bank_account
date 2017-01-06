defmodule BankAccountTest do
  use ExUnit.Case
  doctest BankAccount

  test "starts off with a balance of 0" do
    account = spawn_link(BankAccount, :start, [])

    verify_balance_is 0, account
  end

  test "has balance incremented by the amount of a deposit" do
    account = spawn_link(BankAccount, :start, [])

    send(account, {:deposit, 100})

    verify_balance_is 100, account
  end

  defp verify_balance_is(expected_amount, account) do
    send(account, {:check_balance, self})
    assert_receive {:balance, ^expected_amount}
  end

end
