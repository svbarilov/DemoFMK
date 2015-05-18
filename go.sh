#!/usr/bin/env bash

#check for WORKSPACE
if [ -n "${WORKSPACE}" ]; then
				PROJECT_ROOT=`pwd`
				pushd $WORKSPACE
				bundle install --gemfile $PROJECT_ROOT/Gemfile --path $WORKSPACE/ruby
				popd
else
				gem install rake && bundle install --path ruby
fi

rm -rf junit_format
rm -rf junit_format_rerun
rm report.html
rm rerun.html
rm rerun.txt

bundle exec cucumber -p $TEST_PROFILE

if [ $? == 1 ]; then
   c=1
   origsize=1
   newsize=0
   while (( newsize < origsize ))
    do
        origsize=$(stat -f "%z" rerun.txt)
   	    echo "Rerun failing scenarios $c time"
        bundle exec cucumber -p rerun
        echo "Adjusting test results after $c rerun"
        newsize=$(stat -f "%z" rerun.txt)
        (( c++ ))
        ruby junit_rerun_parser.rb
        if (( newsize == 0 ))
        then
        	break
        fi
   done

   if (( newsize == origsize ))
         then
         exit 1
   fi

fi