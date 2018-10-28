class UuidArticleWithNaturalKey < ActiveRecord::Base
  include ActiveUUID::UUID
  self.table_name = "uuid_articles"

  attribute :id, ActiveUUID::ColumnType.new
  attribute :another_uuid, ActiveUUID::ColumnType.new

  natural_key :title
end
