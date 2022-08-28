defmodule LiveView.Sales do
  def new_orders() do
    Enum.random(1..20)
  end

  def sales_amount() do
    Enum.random(10..100)
  end

  def satisfaction(), do: Enum.random(1..5)
end
