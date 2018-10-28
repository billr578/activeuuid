class UuidArticle < ActiveRecord::Base
  include ActiveUUID::UUID

  attribute :id, ActiveUUID::ColumnType.new
  attribute :another_uuid, ActiveUUID::ColumnType.new
end
