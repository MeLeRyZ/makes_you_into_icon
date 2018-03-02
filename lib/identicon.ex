defmodule Identicon do

  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_odd_squares
    |> build_pixel_map
    |> draw_image #do not use 'image' in ( ... ) cause don't need to update :)
    |> save_image(input)
  end

  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list
    %Identicon.Image{hex: hex}
  end

  def pick_color(image) do
    %Identicon.Image{hex: [r, g, b | _]} = image
    %Identicon.Image{image | color: {r, g, b}}
    #take 3 hex numbers and put in the same struct, to "not" copy
  end

  def build_grid(image) do
    %Identicon.Image{hex: hex} = image
    grid =
      hex
      |> Enum.chunk(3)
      |> Enum.map(&mirror_row/1) #link to spec func #for |>
      |> List.flatten
      |> Enum.with_index #makes tuples {num, index}

    %Identicon.Image{image | grid: grid}
  end

  defp mirror_row(row) do
    [first, second | _third] = row
    row ++ [second, first]
  end

  def filter_odd_squares(image) do
    %Identicon.Image{grid: grid} = image
    grid = Enum.filter grid, fn({code, _}) ->
      rem(code, 2) == 0 #0 or 1
    end
    %Identicon.Image{ image | grid: grid}
  end

  def build_pixel_map(image) do
    %Identicon.Image{grid: grid} = image
    pixel_map = Enum.map grid, fn({_code, index}) ->
      horizontal = rem(index, 5) * 50
      vertical = div(index, 5) * 50

      top_left = {horizontal, vertical}
      bottom_right = {horizontal + 50, vertical + 50}

      {top_left, bottom_right}
    end #genialnaya hernya!
    %Identicon.Image{image | pixel_map: pixel_map}
  end

  def draw_image(%Identicon.Image{color: color, pixel_map: pixel_map}) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)

    Enum.each pixel_map, fn({start, stop}) ->
      :egd.filledRectangle(image, start, stop, fill)
    end
    :egd.render(image) #just binary data
  end

  def save_image(image, input) do
    File.write("#{input}.png", image)
  end
end
