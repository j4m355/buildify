# Buildify

Generate a unique build number that conforms to the Microsoft BuildVersion property spec.  It also has the ability to update a solutions assemblies with new version number.

## Installation

Add this line to your application's Gemfile:

    gem 'buildify'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install buildify

## Usage

Example use in a rake file

####Example 1 is for writing to assemblyInfo.vb or .cs before a build takes place - note "generate_mode"

   require 'buildify'

   build = Buildify::Version.new

   task :setVersionGenerateMode do
     build.generate_mode #generates a unique build number
     puts build.what_version_is_this #how to access version number anywhere within rakefile
     puts build.what_time_was_it_generated #how to access build time anywhere within rakefile
   end

   task :update_assemblies do
     assembly = Buildify::AssemblyVersion.new(:company_name => "Ink Inc", :product_name => "Inc Wells for Inks", :version => build.what_version_is_this , :build_time => build.what_time_was_it_generated, :paths => ["MyVb.netProject/AssemblyInfo.vb","MyC#Project/Properties/AssemblyInfo.cs","MyOtherC#Project/Properties/AssemblyInfo.cs"])
     assembly.version_assemblies #updates the assemblyInfo files dictated in the options hash above
   end

####Example 2 is reading the build variables and making them accessible

    require 'buildify'

    build = Buildify::Version.new

    task :setVersionReadMode do
      build.read_mode
      puts build.what_version_is_this #how to access version number anywhere within rakefile
      puts build.what_time_was_it_generated #how to access build time anywhere within rakefile
    end


####Options hash for updating assemblies:

   :company_name => "Company Name",
   :product_name => "My crappy product",
   :version => my automatically generated version number ,
   :build_time => my automatically generated time,
   :paths => ["project1/AssemblyInfo.vb","project2/Properties/AssemblyInfo.cs"]


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
