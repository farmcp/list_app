#!/usr/bin/env ruby
# copy or symlink this file to .git/hooks/

# automatically strip spaces from the end of lines and add newlines to the end of files as necessary
filetypes = %w(
  builder
  conf
  css
  erb
  haml
  html
  json
  rake
  rb
  rhtml
  rxml
  scss
  js
  txt
  xml
  yaml
  yml
)

paths = %w(
  app
  config
  db/migrate
  lib
  public
  test
  spec
)

filetype_regexp = /\.(#{filetypes.join('|')})$/
paths_regexp = /^tapjoyads\/(#{paths.join('|')})/

files = Array(`git diff-index --name-status --cached HEAD | grep -v ^D | cut -c3-`)
files.each do |f|

  # Only examine specified file types and paths
  if f =~ filetype_regexp && f =~ paths_regexp

    # Add a linebreak to the end of the file if it doesn't already have one
    unless `tail -c1 #{f}` == "\n"
      `echo >> #{f}`
      `git add #{f}`
    end

    # Remove trailing whitespace if it exists
    if `grep -q "[[:blank:]]$" #{f}`
      # sed command works differently on Mac and Linux
      if `uname` =~ /Darwin/
        `sed -i "" -e $'s/[ \t]*$//g' #{f}`
      elsif `uname` =~ /Linux/
        `sed -i -e 's/[ \t]*$//g' #{f}`
      end
      `git add #{f}`
    end

    if (f =~ /\.min\.js$/) # for .min.js files, we want to go back and remove last linebreak
      `perl -i -pe 'chomp if eof' #{f}`
      `git add #{f}`
    end
  end
end

# don't allow migrations to be added without a change to schema.rb, or vice-versa
def schema_modified?
  %x[ git diff --staged --name-only | egrep 'db\/schema\.rb$' ] != ""
end

def migrations_modified?
  %x[ git diff --staged --name-only | egrep 'db\/migrate\/.+\.rb$' ] != ""
end

if schema_modified?
  unless migrations_modified?
    puts "COMMIT FAILED: You've modified schema.rb without adding / altering any migrations. (To commit without checking for this, use the --no-verify flag.)"
    exit 1
  end
elsif migrations_modified?
  unless schema_modified?
    puts "COMMIT FAILED: You've added / altered a migration without modifying schema.rb. (To commit without checking for this, use the --no-verify flag.)"
    exit 1
  end
end
