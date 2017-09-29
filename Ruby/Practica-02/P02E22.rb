require 'matrix'
class Image
  attr_accessor :data, :size
  def initialize(data = nil, size = 1024)
    @filters = 1
    self.size = size
    self.data = data || Matrix.build(size) { Math::PI }
  end

  def header_bytes
    Matrix.rows([(Image.new (data.map { |e| e**@filters })).data.first(size)])
  end

  # Distintos filtros de imágenes:
  def filter_a
    @filters *= 1.2
    self
  end

  def filter_b
    @filters *= 1.4
    self
  end

  def filter_c
    @filters *= 1.8
    self
  end

  def filter_d
    @filters *= 2
    self
  end

  def filter_e
    @filters *= 2.2
    self
  end

  def filter_f
    @filters *= 2.4
    self
  end

  #- Fin de filtros
  def all_filters
    ('a'..'f').inject(self) do |pipe, type|
      pipe.public_send "filter_#{type}"
    end
  end
end

image = Image.new
image.filter_a.filter_c.filter_e # => Esto no realiza ningún cálculo.
image.filter_a.filter_c.filter_e.header_bytes # => Esto sí realiza cálculos para obtener la info de la cabecera.

# Ni idea como probarlo.
# Lo que hice fue ir guardando los valores de los filtros en una variable y hacer el calculo una sola vez.
# Se deber poder hacer con lazy algo por el enunciado.
