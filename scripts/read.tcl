set files [exec sh -c {find -name "*.v" -type f}]
foreach file $files {
    analyze -format verilog -library WORK $file
}
elaborate $TOP -architecture "verilog" -library WORK