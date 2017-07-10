require "prawn"
class Certificate

  attr_accessor :current_user
  attr_accessor :path

  PDF_OPTIONS = {
    :page_size   => "A5",
    :page_layout => :landscape,
    :background  => "public/images/congressista.png",
    :background_scale => 0.24,
    :margin      => [35, 5]
  }

  def initialize(current_user = nil, path = nil)
    @current_user = current_user
    @path = path
  end

  def pdf
    Prawn::Document.new(PDF_OPTIONS) do |pdf|
      if @current_user.name.size >= 42
        pdf.move_down 80
       else
        pdf.move_down 101
       end
      pdf.font Rails.root.join("public/fonts/biko/Biko_Bold.ttf")
      pdf.fill_color "FFFFFF" 
      pdf.text "#{@current_user.name.upcase}", :inline_format => true, :align => :center, :size => 23
    end
  end

  def render
    #pdf.render_file(path) #salvar aquivo em tmp
    pdf.render #retornar "source"
  end

  private
  def artigo
    if @current_user.gender == "Feminino"
      'a'
    else
      'o'
    end
  end
  #
end
