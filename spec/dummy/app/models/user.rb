class User < ApplicationRecord

  has_many :cards, dependent: :destroy
  has_many :blocks, dependent: :destroy
  # belongs_to :current_block, class_name: 'Block'
  # belongs_to :current_block

  def set_current_block(block)
    update_attribute(:current_block_id, block.id)
  end

  def reset_current_block
    update_attribute(:current_block_id, nil)
  end
end
