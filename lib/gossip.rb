$:.unshift File.expand_path("./../lib", __FILE__)
require'bundler'
require 'csv'
require'controller'
Bundler.require

class Gossip
    attr_reader :author, :content

    def initialize(author, content)
        @author = author
        @content = content
    end

    def save
        CSV.open('./db/gossip.csv','ab') do |csv|
            csv << [@author,@content]
        end
    end

    def self.all
        all_gossips = []
        CSV.read("./db/gossip.csv").each do |csv_line|
          all_gossips << Gossip.new(csv_line[0], csv_line[1])
        end
        return all_gossips
      end

    def find(id)
        all_gossips[id]
    end
end
