require 'rake'

module Buildify
  class AssemblyVersion
    include Rake::DSL

    def initialize(opts = {})
      @options = opts
    end

    def version_assemblies()
      @options[:paths].each do |path|
        if path.include? '.vb'
          File.open(path, 'w') do |f|
            f.puts "Imports System.Reflection"
            f.puts "Imports System.Runtime.InteropServices"
            f.puts "<assembly: AssemblyCompany(\"" + @options[:company_name] + "\")>"
            f.puts "<assembly: AssemblyProduct(\"" + @options[:product_name] + "\")>"
            f.puts "<assembly: AssemblyCopyright(\"Copyright " + Time.now.year.to_s + " " + @options[:company_name] + "\")>"
            f.puts "<assembly: AssemblyVersion(\"" + @options[:version] + "\")>"
            f.puts "<assembly: AssemblyFileVersion(\"" + @options[:version] + "\")>"
          end
        end

        if path.include? '.cs'
          File.open(path, 'w') do |f|
            f.puts "using System.Reflection;"
            f.puts "using System.Runtime.InteropServices;"
            f.puts "[assembly: AssemblyCompany(\"" + @options[:company_name] + "\")]"
            f.puts "[assembly: AssemblyProduct(\"" + @options[:product_name] + "\")]"
            f.puts "[assembly: AssemblyCopyright(\"Copyright " + Time.now.strftime("%Y") + " " + @options[:company_name] + "\")]"
            f.puts "[assembly: AssemblyVersion(\"" + @options[:version] + "\")]"
            f.puts "[assembly: AssemblyFileVersion(\"" + @options[:version] + "\")]"
          end
        end

      end
    end

  end
end