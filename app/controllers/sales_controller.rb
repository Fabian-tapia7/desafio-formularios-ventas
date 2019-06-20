class SalesController < ApplicationController
  def new

  end

  def create
    @sale = Sale.new(sale_params)
    @sale.total = @sale.value * (100 - @sale.discount.to_f)/100

    if @sale.tax == 1
      @sale.tax = 19
      @sale.total = @sale.total * ((100 - @sale.tax.to_f)/100)
    else
      @sale.tax = 0
    end

    @sale.save

    redirect_to done_path(@sale)

  end

  def done
    @sale = Sale.find(params[:id])
  end

  private

  def sale_params
    params.require(:sale).permit(:cod, :detail, :category, :value, :discount, :tax)
  end

end
