require 'roo'

# Handles ingestion of items from spreadsheets
module ItemIngestion
  include ActionView::Helpers::NumberHelper
  # Denotes a situation where the spreadsheet could not be processed
  class SpreadsheetError < StandardError; end

  FIRST_ROW = 4

  MIMETYPE_HANDLERS = {
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' => Roo::Excelx}
      # 'application/vnd.ms-excel' => Roo::Excel,
      # 'application/excel' => Roo::Excel}

  # COLUMNS = {
  #     name:               'A',
  #     manufacturer:       'B',
  #     categories:         'C',
  #     locations:          'D',
  #     lists:              'E',
  #     vendor_name:        'F',
  #     price:              'G',
  #     sku:                'H',
  #     taxable:            'I',
  #     asset:              'J',
  #     par:                'K',
  #     purchase_unit:      'L',
  #     pack_size:          'M',
  #     pack_unit:          'N',
  #     subpack_size:       'O',
  #     subpack_unit:       'P',
  #     inventory_unit:     'Q',
  #     price_unit:         'R',
  #     notes:              'S'
  # }

  # Returns a roo spreadsheet object to handle the given file
  def self.spreadsheet_for(file)
    
    # mime_types = MIME::Types.type_for(file.original_filename).map(&:content_type)
    # handlers = mime_types.map{|mt| MIMETYPE_HANDLERS[mt]}.compact

    # raise SpreadsheetError if handlers.empty?

    # # spreadsheet = handlers.first.new(file.path)
    # spreadsheet = handlers.new(file.path);
    # spreadsheet.default_sheet = spreadsheet.sheets.first
    spreadsheet = Roo::Spreadsheet.open(file)
    spreadsheet.default_sheet = spreadsheet.sheets.first
    return spreadsheet
  end

  def self.to_csv(src_file, dest_file)
    begin
      ss = spreadsheet_for(src_file)
      ss.to_csv(dest_file)
    rescue 
      return false
    end
    
  end

  def self.read_row(src_file,index)
    begin
      ss = spreadsheet_for(src_file)
      return ss.row(index)
    rescue 
      return false
    end
    
  end

end
