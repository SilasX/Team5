require "./Statistics.rb"

describe "Statistics" do
  before :each do
    @methods_hash = {"sort"=>3, "each"=>2, "find"=>1, 
      "split"=>43, "reverse"=>9, "pop"=>5, "center" => 12,
      "gsub" => 40, "really_popular"=> 80, "not_at_all_popular"=>1,
      "tony"=>16, "christian"=>30, "lachy"=>17
      }
    @stats = Statistics.new(@methods_hash)
  end
  it "statistics should take a hash as an input" do
    @stats.should be_an_instance_of(Statistics)
  end
  it "should return a top 5 list" do
    @stats.top_five.should == {"really_popular" => 80, "split"=>43, "gsub"=>40, "christian"=>30, "lachy"=>17}
  end
  it "should return the top (user input) list" do
    @stats.top_list(5).should == {"really_popular" => 80, "split"=>43, "gsub"=>40, "christian"=>30, "lachy"=>17}
    @stats.top_list(10).should == {"really_popular" => 80, "split"=>43, "gsub"=>40, "christian"=>30, "lachy"=>17, "tony"=>16, "center"=> 12, "reverse"=> 9, "pop"=> 5, "sort"=>3}
  end
 end