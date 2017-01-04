inputs = %{
  "Small (100 lines)" => "data/100",
  "Medium (10000 lines)" => "data/10000",
  "Huge (1000000 lines)" => "data/1000000"
}
runs = %{
  "current" => &FileCountOptim.current/1,
  "proposed" => &FileCountOptim.proposed/1,
  "recur_count" => &FileCountOptim.recur_count/1,
  "read_line" => &FileCountOptim.read_line/1
}

Benchee.run(runs, inputs: inputs, time: 10)
