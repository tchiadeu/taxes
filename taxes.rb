class Calculator
  NOTARY_FEES = 0.08

  def initialize(months:, taxes:, amount: nil, cash_flow: nil)
    @months = months
    @taxes = taxes
    @amount = amount
    @cash_flow = cash_flow
  end

  def cost
    x = 1 + period_tax
    x_exposed = x**@months
    uprow = @amount * x_exposed * period_tax
    downrow = x_exposed - 1
    mensual = uprow / downrow
    {
      mensual:,
      total: mensual * @months,
      taxes: (mensual * @months) - @amount
    }
  end

  def capacity
    cash = @cash_flow / 12 * 0.33
    x = 1 + period_tax
    x_exposed = x**@months
    uprow = cash * (x_exposed - 1)
    downrow = x_exposed * period_tax
    total = uprow / downrow
    property = total / (1 + NOTARY_FEES)
    { total: , property: , notary: total - property  }
  end

  private

  def period_tax
    x = (1 + @taxes.fdiv(100))
    exponent = (1.fdiv(12))
    (x**exponent - 1).round(6)
  end
end
