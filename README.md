# FileCountOptim

Benchmark for testing implementations of `Enumerable.count/1` for `File.Stream`.

## Usage

`$ mix run benchmark.exs`

## Results

On a mid 2015 MacBook Pro with 4 cores 2.2 GHz i7 and 16GB RAM.

```
Erlang/OTP 19 [erts-8.2] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:10] [hipe] [kernel-poll:false]
Elixir 1.5.0-dev
Benchmark suite executing with the following configuration:
warmup: 2.0s
time: 10.0s
parallel: 1
inputs: Huge (1000000 lines), Medium (10000 lines), Small (100 lines)
Estimated total run time: 144.0s


Benchmarking with input Huge (1000000 lines):
Benchmarking current...
Benchmarking proposed...
Benchmarking read_line...
Benchmarking recur_count...

Benchmarking with input Medium (10000 lines):
Benchmarking current...
Benchmarking proposed...
Benchmarking read_line...
Benchmarking recur_count...

Benchmarking with input Small (100 lines):
Benchmarking current...
Benchmarking proposed...
Benchmarking read_line...
Benchmarking recur_count...

##### With input Huge (1000000 lines) #####
Name                  ips        average  deviation         median
proposed             4.02      248.64 ms     ±3.62%      248.58 ms
recur_count          3.40      294.41 ms     ±4.37%      290.18 ms
read_line            1.22      817.86 ms     ±3.91%      806.50 ms
current              1.08      925.23 ms     ±5.24%      911.27 ms

Comparison:
proposed             4.02
recur_count          3.40 - 1.18x slower
read_line            1.22 - 3.29x slower
current              1.08 - 3.72x slower

##### With input Medium (10000 lines) #####
Name                  ips        average  deviation         median
proposed           452.59        2.21 ms    ±11.83%        2.15 ms
recur_count        313.31        3.19 ms     ±6.88%        3.15 ms
read_line          109.97        9.09 ms     ±6.11%        8.94 ms
current            101.86        9.82 ms    ±14.58%        9.45 ms

Comparison:
proposed           452.59
recur_count        313.31 - 1.44x slower
read_line          109.97 - 4.12x slower
current            101.86 - 4.44x slower

##### With input Small (100 lines) #####
Name                  ips        average  deviation         median
proposed          13.59 K       73.61 μs    ±29.75%       68.00 μs
recur_count       11.99 K       83.41 μs    ±27.13%       77.00 μs
read_line          6.49 K      154.07 μs    ±22.86%      142.00 μs
current            5.83 K      171.60 μs    ±41.22%      157.00 μs

Comparison:
proposed          13.59 K
recur_count       11.99 K - 1.13x slower
read_line          6.49 K - 2.09x slower
current            5.83 K - 2.33x slower
```
