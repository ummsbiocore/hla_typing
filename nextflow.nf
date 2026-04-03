$HOSTNAME = ""
params.outdir = 'results'  


if (!params.input_reads){params.input_reads = ""} 
if (!params.mate){params.mate = ""} 

if (params.input_reads){
Channel
	.fromFilePairs( params.input_reads,checkExists:true , size: params.mate == "single" ? 1 : params.mate == "pair" ? 2 : params.mate == "triple" ? 3 : params.mate == "quadruple" ? 4 : -1 ) 
	.set{g_1_0_g_0}
  } else {  
	g_1_0_g_0 = Channel.empty()
 }

Channel.value(params.mate).set{g_2_1_g_0}


process OptiType {

publishDir params.outdir, mode: 'copy', saveAs: {filename -> if (filename =~ /.*_result.tsv$/) "result/$filename"}
publishDir params.outdir, mode: 'copy', saveAs: {filename -> if (filename =~ /.*coverage_plot.pdf$/) "coverage_plot/$filename"}
publishDir params.outdir, mode: 'copy', saveAs: {filename -> if (filename =~ /.*.bam$/) "bam/$filename"}
input:
 tuple val(name), file(reads)
 val mate

output:
 path "*_result.tsv"  ,emit:g_0_csvFile00 
 path "*coverage_plot.pdf"  ,emit:g_0_outputFilePdf11 
 path "*.bam"  ,emit:g_0_bamFile22 

container "quay.io/mustafapir/optitype:1.3.0"

//* params.type =  "rna"  //* @dropdown @options:"dna","rna"

script:

"""
mkdir hla_typing

path=\$(which optitype_config.ini)

echo \$path

OptiTypePipeline.py -i ${reads} --${params.type} \
    -o hla_typing \
    --prefix ${name} \
    -c \$path

mv hla_typing/* .

"""

}


workflow {


OptiType(g_1_0_g_0,g_2_1_g_0)
g_0_csvFile00 = OptiType.out.g_0_csvFile00
g_0_outputFilePdf11 = OptiType.out.g_0_outputFilePdf11
g_0_bamFile22 = OptiType.out.g_0_bamFile22


}

workflow.onComplete {
println "##Pipeline execution summary##"
println "---------------------------"
println "##Completed at: $workflow.complete"
println "##Duration: ${workflow.duration}"
println "##Success: ${workflow.success ? 'OK' : 'failed' }"
println "##Exit status: ${workflow.exitStatus}"
}
