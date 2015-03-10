#!/usr/bin/env ruby

require 'bio'

def main 
    inFile   = ARGV.shift
    inFh     = Bio::FastaFormat.open(inFile)
    baseName = File.basename(inFile, ".fa")
    kmerFh   = File.new(baseName + ".kmers", "w")
    locFh    = File.new(baseName + ".loc", "w")

    inFh.each do |rec|
        readKmers = kmers rec.seq
        kmerFh.print readKmers.join("\n")
        locFh.print rec.entry_id, "\t", readKmers.size, "\n"
    end
end

def kmers s, k=20
    n = s.length - k
    kmers = []
    for i in 0..n do
        kmers.push s.slice(i,k)
    end
    return kmers
end

main()
