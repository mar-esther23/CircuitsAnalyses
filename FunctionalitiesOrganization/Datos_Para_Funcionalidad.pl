#! perl -w

open (FILE,"epistasis-5-genes-unknown-sign-motif1-expectation.out");
open(OUTFILE1,">redes_Stalin_Prueba.txt");
$contador=0;

while (<FILE>){
    
    #BUSCA LAS REGLAS
    
    if (/(^.*)/){
        @linea_resultados = split("\;",$1);
        #print $linea_resultados[6] . "\n";
        @GEN1 = split(",",$linea_resultados[6]);
        $regla_GEN1 = $GEN1[1];
        $regla_GEN2 = $linea_resultados[7];
        $regla_GEN3 = $linea_resultados[8];
        $regla_GEN4 = $linea_resultados[9];
        $regla_GEN_BLANCO = $linea_resultados[10];
        
    };

##########################################################################################################
    #IMPRIME LAS REGLAS
    if (/(^\d+),.*/){#27
        $contador++;
        #print OUTFILE1 "This is the network number $r \n";
        #print OUTFILE1 "INP1: INP1\nINP2: INP2\nGEN1: $regla_GEN1\nGEN2: $regla_GEN2\nGEN3: $regla_GEN3\nGEN4: $regla_GEN4\nGEN_BLANCO: $regla_GEN_BLANCO\n\n";
        $nueva_red = "INP1, 1\n" . "INP2, 1\n" . "GEN1, $regla_GEN1\n" . "GEN2, $regla_GEN2\n" . "GEN_BLANCO, $regla_GEN_BLANCO\n" . "GEN3, $regla_GEN3\n" . "GEN4, $regla_GEN4\n\n";
        $nueva_red =~ s/~/!/g;
        #print "$nueva_red\n";
        open(OUTFILE,">for_r.net");
        print OUTFILE "targets,factors\n";
        print OUTFILE "$nueva_red\n";
        close OUTFILE;
        print OUTFILE1 "********************************************\n";
        print OUTFILE1 "esta es la red numero $contador\n";
        print OUTFILE1 "$nueva_red\n";
        $data = qx/Rscript corre_boolnet.r for_r.net/;
        print OUTFILE1 "$data\n";
        unlink ("for_r.net");
    };
##########################################################################################################
    
};
close OUTFILE1;

