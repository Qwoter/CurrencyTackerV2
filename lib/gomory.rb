require "rglpk"
##
# Using Linear Programming for this task, method Gomory (Cutting-plane method).
# For most of data sets it's average time is polynomial, which is good for this task.
# For the fastest result i used C library <<Ruby GNU Linear Programming Kit>>.
# references:
# http://en.wikipedia.org/wiki/Linear_programming
# http://en.wikipedia.org/wiki/Cutting-plane_method
# http://en.wikipedia.org/wiki/GNU_Linear_Programming_Kit
# https://www.google.com/?q=Cutting-plane+method+polynomial+time
##
module Gomory
  ##
  # Example:
  # Country Currency Weight Value
  # Country A Currency A 5 25
  # Country B Currency B 4 50
  # Country C Currency C 3 10
  # Country D Currency D 10 110
  #
  # steps:
  # 1. Calculate value / weight for each currency.
  # ex. 5 12.5 3.(3) 11
  # 2. Creat function which we need to Maximize.
  # ex. 5*A + 12.5*B + 3.(3)*C + 11 * D = MAX (A,B..D are amount of our currency, coefficients are value / weight for each currency)
  # 3. Create restriction for our function.
  # ex. 5*A + 4*B + 3*C + 10 * D = max_weight (A,B..D are amount of our currency, coefficients are currency weights)
  # 4. We have a standard maximization problem from Linear Programming.
  # 5. Use the algorithm library... Explaining alg requires some complex Math.
  ##

  def self.calculate(data, max_weight, strict_equality = true)
    p = Rglpk::Problem.new
    p.name = "sample"
    p.obj.dir = Rglpk::GLP_MAX

    size = data.size
    rows = p.add_rows(1)
    rows[0].name = "p"
    rows[0].set_bounds(Rglpk::GLP_FX, max_weight, 0)
    coefs = []
    matrix = []
    cols = p.add_cols(size)

    data.each_with_index do |currency, i|
      cols[i].name = "x#{i}"
      cols[i].set_bounds(Rglpk::GLP_LO, 0.0, 0.0)
      cols[i].kind = Rglpk::GLP_IV

      coefs.push(currency.collector_value.to_f / currency.weight.to_f)

      matrix.push(currency.weight)
    end

      p.obj.coefs = coefs
      p.set_matrix(matrix)

      p.simplex()
      p.mip()
      z = p.obj.get
      w = 0

      result = []
      cols.each_with_index do |el, i|
        if el.mip_val > 0
          result << [{ amount: el.mip_val }, data[i], data[i].country]
          w += data[i].weight * el.mip_val
        end
      end

    result << { max_value: z, max_weight: w }
  end
end
