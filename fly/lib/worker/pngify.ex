defmodule Fly.Worker.Pngify do
  def call(input, _config) do
    %Porcelain.Result{out: output, status: _status} = 
      Porcelain.exec("convert",
                     ["-", "-strip", "png:-"],
                     [in: input, out: :string])
    output
  end
end
