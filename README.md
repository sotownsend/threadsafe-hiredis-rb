# redis_ext

Ruby extension that wraps [hiredis](http://github.com/antirez/hiredis) reply
parsing code. It is targeted at speeding up parsing multi bulk replies.

## WARNING

This code is considered alpha. Do not use it for other purposes than
testing _yet_.

## Install

Install with Rubygems:

    gem install redis_ext --pre

## Usage

This gem can be used by simply requiring it. When it is required _after_
the `redis` gem is loaded, it automatically patches it to use `redis_ext`.

## Benchmarks

These numbers were generated by running `benchmark/compare.rb` against 
`ruby 1.8.7 (2010-08-16 patchlevel 302) [i686-darwin10.4.0]`. The tests run against
Redis 2.1.4 (development version), on a MacBook Pro with Core i7 processor.

                                                user     system      total        real
    ruby:MGET 100 keys                      9.140000   0.470000   9.610000 ( 12.189443)
     ext:MGET 100 keys                      4.990000   0.370000   5.360000 (  7.665459)
    ruby:MGET 500 keys                     42.320000   0.660000  42.980000 ( 53.082886)
     ext:MGET 500 keys                     22.480000   0.650000  23.130000 ( 33.128897)
    ruby:GET                                0.430000   0.300000   0.730000 (  1.164947)
     ext:GET                                0.410000   0.300000   0.710000 (  1.154530)
    ruby:GET (pipeline of 10)               1.940000   0.350000   2.290000 (  3.237119)
     ext:GET (pipeline of 10)               1.760000   0.350000   2.110000 (  3.093864)
    ruby:LRANGE 0,99                        4.740000   0.380000   5.120000 (  5.725984)
     ext:LRANGE 0,99                        0.720000   0.310000   1.030000 (  1.633836)
    ruby:LRANGE 0,99 (pipeline of 10)      43.380000   0.950000  44.330000 ( 47.842782)
     ext:LRANGE 0,99 (pipeline of 10)       4.890000   0.640000   5.530000 (  8.294088)
    ruby:LRANGE 0,499                      21.360000   0.660000  22.020000 ( 23.794228)
     ext:LRANGE 0,499                       1.970000   0.470000   2.440000 (  3.514437)
    ruby:LRANGE 0,499 (pipeline of 10)    210.710000   3.270000 213.980000 (224.486794)
     ext:LRANGE 0,499 (pipeline of 10)     17.030000   1.840000  18.870000 ( 29.134436)

## License

This code is released under the BSD license, after the license of hiredis.
