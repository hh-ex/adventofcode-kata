defmodule AocKataTest do
  use ExUnit.Case
  doctest AocKata

  test "greets the world" do
    assert AocKata.hello() == :world
  end
end
