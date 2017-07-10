module CheckoutHelper
  def pagseguro(value)
    percert_taxa = 0.0399
    fixed_taxa = 0.4
    (value + fixed_taxa) / (1 - percert_taxa)
  end
end
