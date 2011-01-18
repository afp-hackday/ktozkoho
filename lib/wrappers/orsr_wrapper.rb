# coding: utf-8
require 'open-uri'

module Wrappers
  module ORSRWrapper
    extend self

    HistoricalData = Struct.new(:addresses, :names, :evidence_url)

    ORSR_URL = "http://orsr.sk"
    ORSR_ICO_SEARCH = "http://orsr.sk/hladaj_ico.asp?SID=0&ICO="

    def reload_historical_data
      Datanest::Organisation.find_each do |organisation|
        reload_historical_data_for_organisation(organisation)
      end
    end

    def reload_historical_data_for_organisation organisation
      historical_data = load_historical_data_for_organisation organisation

      historical_data.addresses.each do |addr|
        historical_data.names.each do |name|
          organisation.historical_data.create(:name => name, :address => addr)
        end
      end

      organisation.save
    end

    handle_asynchronously :reload_historical_data_for_organisation

    def load_historical_data_for_organisation organisation
      Nokogiri::HTML(open(create_search_url organisation.ico)).search('a.link').each do |element|
        if element.content == 'Úplný'
          return follow_search_result element['href']
        end
      end

      HistoricalData.new
    end

    def create_search_url ico
      ORSR_ICO_SEARCH + ico
    end

    def follow_search_result url
      historical_data = HistoricalData.new
      historical_data.evidence_url = url

      Nokogiri::HTML(open("#{ORSR_URL}/#{url}"), nil, 'cp1250').search('//body/table').each do |table|
        table.search('./tr/td/span').each do |element|
          case element.content.gsub(/\u00A0/, ' ')
            when "Sídlo: " then          historical_data.addresses = scrape_addresses(table)
            when "Obchodné meno: " then  historical_data.names     = scrape_names(table)
          end
        end
      end

      historical_data
    end

    def scrape_addresses table
      addresses = []

      table.search('tr > td[2] > table').each do |address_table|
        street = []
        city = []

        address_element = street

        address_table.search('tr > td[1] > *').each do |address_line|
          if address_line.name == 'span'
            address_element << address_line.content.strip
          elsif address_line.name == 'br'
            address_element = city
          end
        end

        address = "#{street.join(' ')}"
        address += ", #{city.join(' ')}" unless city.empty?

        addresses << address
      end

      addresses
    end

    def scrape_names table
      names = []

      table.search('tr > td[2] > table').each do |names_table|
        names_table.search('tr > td[1] > *').each do |names_line|
          if names_line.name == 'span'
            names << names_line.content.strip
          end
        end
      end

      names
    end

  end
end
