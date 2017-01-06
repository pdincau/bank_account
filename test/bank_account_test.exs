defmodule BankAccountTest do
  use ExUnit.Case
  doctest BankAccount

  test "starts off with a balance of 0" do
    account = spawn_link(BankAccount, :start, [])

    verify_balance_is 0, account
  end

  defp verify_balance_is(expected_amount, account) do
    send(account, {:check_balance, self})
    assert_receive {:balance, ^expected_amount}
  end
end
