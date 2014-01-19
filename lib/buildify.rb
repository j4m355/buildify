require 'buildify/version'
require 'buildify/assembly_version'
require 'time_diff'

module Buildify
    class Version

    def generate_mode
			assign_a_version
    end

    def read_mode
      read_build_time
      read_version_file
    end

  	def what_version_is_this
			@build_version
		end

		def what_time_was_it_generated
			@build_time
		end		

		def assign_a_version
			write_build_time
			the_beginning_of_time = Time.local(1970,1,1)  
			years_between_the_beginning_of_time_and_now = (@build_time.year - the_beginning_of_time.year)
			double_decades_since_beginning_of_time = years_between_the_beginning_of_time_and_now.to_i / 20
			remainder_after_double_decade_count = years_between_the_beginning_of_time_and_now % 20
			if remainder_after_double_decade_count > 0 
				double_decades_since_beginning_of_time =  double_decades_since_beginning_of_time + 1
			end
			major = double_decades_since_beginning_of_time
			minor = (12 * remainder_after_double_decade_count) + @build_time.month
			minute_of_month = Time.diff(Time.local(@build_time.year,@build_time.month,1), @build_time, '%N')
			build = minute_of_month[:diff].to_i
			full_build_version = major.to_s + "." + minor.to_s + "." + build.to_s
			@build_version = full_build_version
			write_to_version_file  
		end

		def write_build_time
			@build_time = Time.now
			File.open('BUILDTIME', 'w') { |file| file.write(@build_time)}
    end

    def read_build_time
      build_time_file = File.open('BUILDTIME', 'rb')
      @build_time = build_time_file.read
      build_time_file.close
    end

		def write_to_version_file
			f = File.open('VERSION', 'w') 
			f.write(@build_version)
			f.close
    end

    def read_version_file
      version_file = File.open('VERSION', 'rb')
      @build_version = version_file.read
      version_file.close
    end



		private :assign_a_version, :write_build_time, :write_to_version_file, :read_build_time, :read_version_file

	end
end

