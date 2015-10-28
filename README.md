##Documentation

###Problem Description (Overview)

Create a Twitter bot that takes TweetSec's propietary algorithm for evaluating password strength, applies it to any message it receives, and reply with the result.

## Features Implemented as Part of the Exercise

* Capture tweets sent to a Twitter account
* Evaluate the 'password strength' of each message

###Approach

Below follows a synopsis of some of the technical issues.

####Algorithm for English word substitution

The Aho-Corasick algorithm (via ahocorasick gem) is used as the workhorse to pattern match the English words in a tweet.  At a high level, it constructs a finite state machine from the words found in an older edition of Webster's dictionary.  This machine can then be used to locate the occurrences of those words in a tweet.

####Limitations

There's a couple of limitations to be aware of with this approach.  The first is that if a word is not in Webster's dictionary (or equivalent source), Aho-Corasick will not be able to substitute that whole word.  This can affect the computation of the password strength since the length of the updated tweet text is used.

The other limitation is the source dictionary itelf.  The dictionary of words in 'data/english_words.txt' does not contain the word *this* but it contains *th*.  This means the substitution algorithm may substitute 'z' for 'th' in a tweet, altering the computed password strength we might have gotten if we don't consider *th* an English word.  The spec tests highlight some of this behavior.

##Technical notes!

###Installation instructions

I used the RVM package manager and you'll notice the .ruby-gemset and .ruby-version files in this code repository.

Step 1: *bundle install* to your RVM gemset (or whatever setup is most convenient for you)

Step 2: *ruby tweetsec_cli.rb -t* to run the program using sample tweet data found in data/sample_tweets.txt.  Otherwise, you need to provide your own *.env* file formatted as shown in the example file *example.env*.

The *.env* file contains all the keys necessary to capture tweets from a Twitter account.  It's expected you will have access to your own keys to your own Twitter account if you wish to run the program with the data of your choice.  Then you will run the file as *ruby tweetsec_cli.rb* without any arguments.

###Requirements

This was created and tested on an Ubuntu 14.04 Linux system.  It should likely run on an OSx box without any trouble.

##Sources

https://github.com/adambom/dictionary - Webster's unabridged dictionary from Project Gutenberg - 1913 edition
