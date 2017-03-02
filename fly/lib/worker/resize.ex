defmodule Fly.Worker.Resize do
  def call(input, %{size: size}) do
    %Porcelain.Result{out: output, status: _status} = 
      Porcelain.exec("convert",
                     ["-", "-strip", "-resize", size, "-"],
                     [in: input, out: :string])
    output
  end
end
