class Concert
  attr_accessor :venue, :name, :location
  #What's my scope? Class scope
  @@all = [] #=> Class variables
  #In scope in class emthods and instance methods

  def self.create #constructor because it's an extension of initialize that adds more functionality than initialize
    c = self.new #instantiates a concert
    c.save #saves that concert
    c #returns that concert
  end
#method self.new_from_seatgeek(url) is involving scraping.
  def self.new_from_seatgeek(url)
    doc = Nokogiri::(open(url)) #used to scrape, or get info from a website!! WHAA?!?!
    properties = {}
    properties[:name] = doc.search("#event-title").text
    properties[:venue] = doc.search(".event-details-words").text.split(" - ").first
    self.new_from_hash(properties)
  end


  #Concert.new_from_hash({:venue => "MSG", :name => "Kanye"})
  def self.new_from_hash(hash) # constructor
    c = self.new
    c.name = hash[:name]
    c.venue = hash[:venue]
    c.location = hash[:location]
    c #this line returns everything.
  end
  


  def initialize # Instance Method because it's receiver is when an instance is created
    #instance scope
    #self #=> #<Concert>
   
  end

  def save 
    @@all << self
  end


  #step 1 for this method: What do I want as the outcome?
  #Concert.find_all_by_location("hogwarts") #=> []
  #Concert.find_all_by_location("NYC") #=> [#<>, #<>]

  def self.find_all_by_location(location)
    @@all.select{|c| c.location == location}
  end



  def self.find_by_location(location) #self is Concert (class) #method used to return one location
    #What's my scope? Class scope

    #I need to go through @@all and find the concert whose location matches the location passed into this method. 

    #one way (abstract way) to write this code 2 lines below:
    #find the first concert whose location is the location passed in.
    @@all.detect{|c| c.location == location} #detect will take out just the first return value that matches.

    #second method is below and it's less abstract

    # #first, I need to create a var that is the result
    # result = nil #Flag or a Switch - Maintaining State.

    # #do something that will set result to the correct concert
    # @@all.each do |concert| #start a loop
    #   result = concert if concert.location == location
    # end
    # #return result 
    # result #=> nil or a particular concert
  end

  def self.all #Class reader
    #Class Scope
    @@all #The classes copy of @all #=> A Class Instance Var
    #Where do I look for concerts?!
    #Wherever I'm looking for concerts, how do concerts get there?
    #Whose responsibility is it to keep track of concerts?
  end


  def Concert.find_by_location(location) #this class method is the exact same as def self.find_by_location(location).
  end
end


kanye_listening_party = Concert.new #=> A new concert was scheduled
kanye_listening_party.venue = "MSG"
kanye_listening_party.location = "NYC" #=> An instance of a concert


#Want the above code to do THIS. So how do we build this method?: Concert.find_by_location("NYC") #=> [#<Concert>, #<Concert>, etc.]

#1. Whose responsibility is it to find all concerts in NYC? 
  #=> An individual concert, like kanye_listening_party
  #=> or is it concerts in general? It's the concert class in general's responsibility to find all concerts in NYC.