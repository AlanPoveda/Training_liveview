defmodule LiveView.Stores do
  def search_by_cep(cep) do
    :timer.sleep(2000)

    list_stores()
    |> Enum.filter(&(&1.cep == cep))
  end

  def serch_by_city(city) do
    :timer.sleep(2000)

    list_stores()
    |> Enum.filter(&(&1.city == city))
  end

  def list_stores() do
    [
      %{
        name: "Loja 1",
        cep: "001",
        city: "Sao paulo",
        street: "rua sao paulo 1",
        open: true
      },
      %{
        name: "Loja 2",
        cep: "002",
        city: "Sao paulo",
        street: "rua sao paulo 2",
        open: false
      },
      %{
        name: "Loja 3",
        cep: "003",
        city: "Sao paulo",
        street: "rua sao paulo 3",
        open: true
      },
      %{
        name: "Loja 4",
        cep: "004",
        city: "Sao paulo",
        street: "rua sao paulo 4",
        open: true
      },
      %{
        name: "Loja 5",
        cep: "005",
        city: "Brasilia",
        street: "rua sao paulo 5",
        open: false
      }
    ]
  end
end
