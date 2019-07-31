$:.unshift File.expand_path("./../lib", __FILE__)
require'bundler'
require 'csv'
require'controller'
Bundler.require

class Gossip
    attr_reader :author, :content
#initialize 
    def initialize(author, content)
        @author = author
        @content = content
    end
#save des données sous CSV
    def save
        CSV.open('./db/gossip.csv','ab') do |csv|
            csv << [@author,@content]
        end
    end
#Affiche les dataBases sur la page
    def self.all
        all_gossips = []
        CSV.read("./db/gossip.csv").each do |csv_line|
          all_gossips << Gossip.new(csv_line[0], csv_line[1])
        end
        return all_gossips
      end
#URL automate
    def self.find(id)
        Gossip.all[id.to_i]
    end

    def self.update(id, gossip_author, gossip_content)
        gossips = CSV.read('db/gossip.csv')
        gossips[id][0] = gossip_author
        gossips[id][1] = gossip_content
        CSV.open('db/gossip.csv', 'w') do |csv|
          gossips.each{|gossip| csv << gossip}
        end
      end
      
      def self.add_comment(id, author, comment)
        gossips = CSV.read('db/gossip.csv')
        if comment != ''
          author == '' ? gossips[id] << 'Anonymous' : gossips[id] << author
          gossips[id] << comment
          CSV.open('db/gossip.csv', 'w') do |csv|
            gossips.each{|gossip| csv << gossip}
          end
        end
    end   
end
