baseCommand: []
class: CommandLineTool
cwlVersion: v1.0
id: scalpel-discovery-single
inputs:
  bam:
    doc: ''
    inputBinding:
      position: 1
      prefix: --bam
    type: File
  bed:
    doc: ''
    inputBinding:
      position: 2
      prefix: --bed
    type: File
  covratio:
    default: 0.01
    doc: ''
    inputBinding:
      position: 7
      prefix: --covratio
    type: double
  covthr:
    default: 5
    doc: ''
    inputBinding:
      position: 5
      prefix: --covthr
    type: long
  kmer:
    default: 25
    doc: ''
    inputBinding:
      position: 4
      prefix: --kmer
    type: long
  lowcov:
    default: 2
    doc: ''
    inputBinding:
      position: 6
      prefix: --lowcov
    type: long
  mapscore:
    default: 1
    doc: ''
    inputBinding:
      position: 12
      prefix: --mapscore
    type: long
  maxregcov:
    default: 10000
    doc: ''
    inputBinding:
      position: 10
      prefix: --maxregcov
    type: long
  mismatches:
    default: 3
    doc: ''
    inputBinding:
      position: 14
      prefix: --mismatches
    type: long
  pathlimit:
    default: 1000000
    doc: ''
    inputBinding:
      position: 13
      prefix: --pathlimit
    type: long
  radius:
    default: 100
    doc: ''
    inputBinding:
      position: 8
      prefix: --radius
    type: long
  ref:
    default: grch37
    doc: ''
    inputBinding:
      position: 3
      prefix: --ref
    type: string
  step:
    default: 100
    doc: ''
    inputBinding:
      position: 11
      prefix: --step
    type: long
  window:
    default: 400
    doc: ''
    inputBinding:
      position: 9
      prefix: --window
    type: long
label: 'Scalpel Discovery: Single mode'
outputs:
  outdir:
    doc: ''
    outputBinding:
      glob: outdir/*
    type: File
requirements:
- class: DockerRequirement
  dockerOutputDirectory: /data/out
  dockerPull: pfda2dockstore/scalpel-discovery-single:10
s:author:
  class: s:Person
  s:name: Matthew Lueder
