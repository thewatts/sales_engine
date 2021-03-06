require_relative 'unit_conversions'

class InvoiceItem

  include UnitConversions

  attr_reader :id, :item_id, :invoice_id, :quantity, :unit_price,
              :created_at, :updated_at, :repo

  def initialize(data = {}, repo = nil)
    @id         = data[:id].to_i
    @item_id    = data[:item_id].to_i
    @invoice_id = data[:invoice_id].to_i
    @quantity   = data[:quantity].to_i
    @unit_price = convert_to_big_decimal(data[:unit_price])
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @repo       = repo
  end

  def self.public_attributes
    [ :id, :item_id, :invoice_id, :quantity,
      :unit_price, :created_at, :updated_at  ]
  end

  def invoice
    repo.engine.invoice_repository.find_by_id(invoice_id)
  end

  def item
    repo.engine.item_repository.find_by_id(item_id)
  end

  def total
    quantity * unit_price
  end

  def successful?
    invoice.successful?
  end
end
