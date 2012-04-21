require File.expand_path(File.dirname(__FILE__) + '/../lib/sourcecode')

this_dir = File.dirname(__FILE__) + "/../"
this_dir_expanded = File.expand_path(File.dirname(__FILE__) + "/../")
puts this_dir
puts this_dir_expanded

describe "SourceCode"  do
    before :each do
      @doc = SourceCode.new('tests/test.rb', :file)
    end
    it "should create an array for storing a sourcecode file" do
      @doc.should be_an_instance_of(SourceCode)
    end
    
    describe "#count_methods" do
      before :each do
        @ruby_methods = {'reverse'=>['string','hash','array'], 'split'=>['string'], 'each'=>['array', 'hash'], 'find'=>['array'], 'sort_by'=>['string', 'object']}
      end
      
      it "should return an array of methods" do
        puts "counting methods #{@doc.count_methods(@ruby_methods)}"
        @doc.count_methods(@ruby_methods).should == {"reverse"=>1, "each"=>2, "split"=>1, "find"=>1}
      end

      it "should return methods followed by paranthesis as part of the #count_methods array" do
        @doc = SourceCode.new('tests/test_parens.rb')
        @doc.count_methods(@ruby_methods).should == {"sort_by"=>1, "each"=>2, "split"=>2}
      end

      it "should return an array of methods, ignoring anything commented." do
        @doc = SourceCode.new('tests/test_commenting.rb')
        @doc.count_methods(@ruby_methods).should == {"reverse"=>1, "each"=>2, "split"=>1, "find"=>1}
      end
      
      it "should return a method popularity hash when passing string" do
        file_contents = "def hello
          'tony'.my_special_method.reverse.each.split
          dog_list.each.find
        end"
        SourceCode.new(file_contents, :string).count_methods(@ruby_methods).should == {"reverse"=>1, "each"=>2, "split"=>1, "find"=>1} 
      end
      
      it "should parse out singe .'s " do
        @doc = SourceCode.new('tests/period_test.rb')
        @doc.count_methods(@ruby_methods).should == {"reverse"=>1, "each"=>2, "split"=>1, "find"=>1}
      end
      
    end
    
#    describe "#from_git" do
#      it "should download copy of git source code into sub directory /repos/*name_of_repo" do
#        @ruby_methods = {'reverse'=>['string','hash','array'], 'split'=>['string'], 'each'=>['array', 'hash'], 'find'=>['array']}
#        doc = SourceCode.from_git('git://github.com/sharksforcheap/test.git')
#        doc.count_methods(@ruby_methods).should == {"reverse"=>1, "each"=>2, "split"=>1, "find"=>1}
#      end
#    end
    
    describe "#from_file" do
      before :each do
        @ruby_methods = {'reverse'=>['string','hash','array'], 'split'=>['string'], 'each'=>['array', 'hash'], 'find'=>['array']}
      end
      
      it "should be able to instantiate through factory method on single file" do
        code_obj = SourceCode.from_file('tests/test.rb')
        code_obj.count_methods(@ruby_methods).should == {"reverse"=>1, "each"=>2, "split"=>1, "find"=>1}
      end
      
    end
    
    describe "#from_dir" do
      before :each do
        @ruby_methods = {'reverse'=>['string','hash','array'], 'split'=>['string'], 'each'=>['array', 'hash'], 'find'=>['array']}
      end      
    
      it "should be able to instantiate through factory method on directory" do
        code_obj = SourceCode.from_dir('tests/test_input_directory/subdir')
        code_obj.count_methods(@ruby_methods).should == {"reverse"=>1, "each"=>2, "split"=>1, "find"=>1}
      end
    
      it "should be able to instantiate through factory method on directory if given with final slash" do
        code_obj = SourceCode.from_dir('tests/test_input_directory/subdir/')
        code_obj.count_methods(@ruby_methods).should == {"reverse"=>1, "each"=>2, "split"=>1, "find"=>1}
      end
    
      it "should be able to instantiate through factory method on directory with subdirectories" do
        code_obj = SourceCode.from_dir('tests/test_input_directory')
        code_obj.count_methods(@ruby_methods).should == {"reverse"=>3, "each"=>6, "split"=>3, "find"=>3}
      end
      
      it "should not interpret non-directories as directories" do
        code_obj = SourceCode.from_dir('tests/readme_test')
        code_obj.count_methods(@ruby_methods).should == {"reverse"=>1, "each"=>2, "split"=>1, "find"=>1}
      end
      
    end
end
