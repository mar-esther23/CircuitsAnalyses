#! perl -w

open (FILE,"redes_Formato_GINsim.txt_results");
@All_functional_loops = ();
$loops = "";
$do_not_add_loop = 0;
$s=0;
@circuits = ();
open(OUTFILE1,">Loops_Functionality.txt");
open(OUTFILE2,">Loops_Functionality_Easy_Format.txt");
print OUTFILE1 "\@All_functional_loops = (";

while (<FILE>){
    if (/\*.\*/){#Busca en el archivo de entrada el comienzo de cada funcionalidad
        print OUTFILE2 $s . ",";
        $s++;
        $number_of_loops = @All_functional_loops;#Para saber el numero de funcionalidades encontradas
        $loops = loop_reorganization(@circuits);#Manda cada funcionalidad a dos subrutinas que reorganizan el orden de los circuitos para que siempre aparezcan en el mismo orden
        chop $loops;
        chop $loops;
        if ($number_of_loops == 0 and $loops ne ""){#A partir de aqui, compara con los loops ya encontrados y si es nuevo lo añade a un arreglo e imprimer la nueva funcionalidad en un archivo de salida
            $contador ++;
            @All_functional_loops = (@All_functional_loops, $loops);
            print OUTFILE1"\"$loops\", ";
            print OUTFILE2 "1," . "$loops\n";
        }
        elsif ($number_of_loops == 0 and $loops eq ""){#A partir de aqui, compara con los loops ya encontrados y si es nuevo lo añade a un arreglo e imprimer
            $none_loops = "NONE";
            print OUTFILE2 "NONE," . "$none_loops\n";
        }else{
            for ($i = 0; $i <= $number_of_loops - 1; $i++){
                if ($loops eq ""){
                    $do_not_add_loop = 1;
                    $loop_number = "NONE";
                }
                elsif ($All_functional_loops[$i] eq $loops){
                    $do_not_add_loop = 1;
                    $loop_number = $i+1;
                }else{
                    $do_not_add_loop = $do_not_add_loop;
                };
            };
            if ($do_not_add_loop == 1){
                if ($loops eq ""){
                    print OUTFILE2  $loop_number . "," . "NONE\n";
                }else{
                    print OUTFILE2  $loop_number . "," . "$loops\n";
                }
                @All_functional_loops = (@All_functional_loops);
            }else{
                $contador++;
                @All_functional_loops = (@All_functional_loops, $loops);
                $loop_number = @All_functional_loops;
                print OUTFILE1"\"$loops\", ";
                print OUTFILE2 $loop_number . "," . "$loops\n";
            };
        };
        NEXT_LOOP:
        $loops = "";
        @circuits = ();
    };
    $do_not_add_loop = 0;
    
        if (/^(.?\d.*)/){#Busca cada loop que es funcional
        $gen1_presence = 0;
        $gen2_presence = 0;
        $gen3_presence = 0;
        $gen4_presence = 0;
        @parts_of_loop = split / /, $1;
        $number_of_pieces = @parts_of_loop;#toda esta parte es para organizar a los genes para que aparezcan de la misma forma siempre que es: GEN1, GEN2, GEN3 y GEN4 Esta parte se podria convertir en una subrutina
        for ($j = 0; $j < $number_of_pieces; $j++){
            if ($parts_of_loop[$j] eq "GEN1"){
                $gen1_presence = $j;
            }; #50
            if ($parts_of_loop[$j] eq "GEN2"){
                $gen2_presence = $j;
            };
            if ($parts_of_loop[$j] eq "GEN3"){
                $gen3_presence = $j;
            };
            if ($parts_of_loop[$j] eq "GEN4"){
                $gen4_presence = $j;
            };
        };
        
        if ($parts_of_loop[0] =~ m/\d+/){
            $loop_reorganized = $parts_of_loop[0] . " " . $parts_of_loop[3];
        }elsif ($parts_of_loop[4] =~ m/\d+/){
            $loop_reorganized = $parts_of_loop[1] . " " . $parts_of_loop[4];
        }else{
            $loop_reorganized = $parts_of_loop[1] . " " . $parts_of_loop[3];
        }
        
        if ($gen1_presence > 0){
            $loop_reorganized = $loop_reorganized . " " . $parts_of_loop[$gen1_presence];
        };
        if ($gen2_presence > 0){
                $loop_reorganized = $loop_reorganized . " " . $parts_of_loop[$gen2_presence];
        };
        if ($gen3_presence > 0){
            $loop_reorganized = $loop_reorganized . " " . $parts_of_loop[$gen3_presence];
        };
        if ($gen4_presence > 0){
            $loop_reorganized = $loop_reorganized . " " . $parts_of_loop[$gen4_presence];
        };
        if ($gen1_presence == 0 and $gen2_presence == 0 and $gen3_presence == 0 and $gen4_presence == 0){
            @circuits = @circuits;
        }else{
            @circuits = (@circuits, $loop_reorganized);
        };
    };
};

#######################################################################################

sub loop_reorganization{
    $cacho_uno = "";
    $cacho_dos = "";
    $cacho_tres = "";
    $cacho_cuatro = "";
    $cacho_cinco = "";
    $cacho_seis = "";
    $cacho_siete = "";
    $cacho_ocho = "";#100
    $cacho_nueve = "";
    $cacho_diez = "";
    $cacho_once = "";
    $cacho_doce = "";
    $cacho_trece = "";
    $cacho_catorce = "";
    $cacho_quince = "";
    $cacho_dieciseis = "";
    $cacho_diecisiete = "";
    $cacho_dieciocho = "";
    $cacho_diecinueve = "";
    $cacho_veinte = "";
    $cacho_veintiuno = "";
    $cacho_veintidos = "";
    $cacho_veintitres = "";
    $uno = 100;
    $dos = 100;
    $tres = 100;
    $cuatro = 100;
    $cinco = 100;
    $seis = 100;
    $siete = 100;
    $ocho = 100;
    $nueve = 100;
    $diez = 100;
    $once = 100;
    $doce = 100;
    $trece = 100;
    $catorce = 100;
    $quince = 100;
    $dieciseis = 100;
    $diecisiete = 100;
    $dieciocho = 100;
    $diecinueve = 100;
    $veinte = 100;
    $veintiuno = 100;
    $veintidos = 100;
    $veintitres = 100;
    @circuits_array = @_;
    for($p=0; $p<@circuits_array; $p++){
        @en_pedazos = split / /,$circuits_array[$p];
        $element_size = @en_pedazos;
        if ($element_size == 6){
            $uno = $p;
            foreach $cacho(@en_pedazos){
                $cacho_uno = $cacho_uno . $cacho . " ";
            }
        }elsif($element_size == 5 and $en_pedazos[2] eq "GEN1" and  $en_pedazos[3] eq "GEN2"){
            if ($en_pedazos[4] eq "GEN3"){
                $dos = $p; #150
                foreach $cacho(@en_pedazos){
                    $cacho_dos = $cacho_dos . $cacho . " ";
                }
            }else{
                $tres = $p;
                foreach $cacho(@en_pedazos){
                    $cacho_tres = $cacho_tres . $cacho . " ";
                }
            }
        }elsif($element_size == 5 and $en_pedazos[2] eq "GEN1" and  $en_pedazos[3] eq "GEN3"){
            if ($en_pedazos[4] eq "GEN2"){
                $cuatro = $p;
                foreach $cacho(@en_pedazos){
                    $cacho_cuatro = $cacho_cuatro . $cacho . " ";
                }
            }else{
                $cinco = $p;
                foreach $cacho(@en_pedazos){
                    $cacho_cinco = $cacho_cinco . $cacho . " ";
                }
            }
        }elsif($element_size == 5 and $en_pedazos[2] eq "GEN1" and  $en_pedazos[3] eq "GEN4"){
            if ($en_pedazos[4] eq "GEN2"){
                $seis = $p;
                foreach $cacho(@en_pedazos){
                    $cacho_seis = $cacho_seis . $cacho . " ";
                }
            }else{
                $siete = $p;
                foreach $cacho(@en_pedazos){
                    $cacho_siete = $cacho_siete . $cacho . " ";
                }
            }
        }elsif($element_size == 5 and $en_pedazos[2] eq "GEN2" and  $en_pedazos[3] eq "GEN3"){
            if ($en_pedazos[4] eq "GEN1"){
                $ocho = $p;
                foreach $cacho(@en_pedazos){
                    $cacho_ocho = $cacho_ocho . $cacho . " ";
                }
            }else{
                $nueve = $p;
                foreach $cacho(@en_pedazos){
                    $cacho_nueve = $cacho_nueve . $cacho . " ";
                }
            }
        }elsif($element_size == 5 and $en_pedazos[2] eq "GEN2" and  $en_pedazos[3] eq "GEN4"){
            if ($en_pedazos[4] eq "GEN1"){
                $diez = $p;
                foreach $cacho(@en_pedazos){
                    $cacho_diez = $cacho_diez . $cacho . " "; #200
                }
            }else{
                $once = $p;
                foreach $cacho(@en_pedazos){
                    $cacho_once = $cacho_once . $cacho . " ";
                }
            }
        }elsif($element_size == 5 and $en_pedazos[2] eq "GEN3" and  $en_pedazos[3] eq "GEN4"){
            if ($en_pedazos[4] eq "GEN1"){
            $doce = $p;
            foreach $cacho(@en_pedazos){
                $cacho_doce = $cacho_doce . $cacho . " ";
                }
            }else{
                $trece = $p;
                foreach $cacho(@en_pedazos){
                    $cacho_trece = $cacho_trece . $cacho . " ";
                }
            }
        }elsif($element_size == 4 and $en_pedazos[2] eq "GEN1" and  $en_pedazos[3] eq "GEN2"){
            $catorce = $p;
            foreach $cacho(@en_pedazos){
                $cacho_catorce = $cacho_catorce . $cacho . " ";
            }
        }elsif($element_size == 4 and $en_pedazos[2] eq "GEN1" and  $en_pedazos[3] eq "GEN3"){
            $quince = $p;
            foreach $cacho(@en_pedazos){
                $cacho_quince = $cacho_quince . $cacho . " ";
            }
        }elsif($element_size == 4 and $en_pedazos[2] eq "GEN1" and  $en_pedazos[3] eq "GEN4"){
            $dieciseis = $p;
            foreach $cacho(@en_pedazos){
                $cacho_dieciseis = $cacho_dieciseis . $cacho . " ";
            }
        }elsif($element_size == 4 and $en_pedazos[2] eq "GEN2" and  $en_pedazos[3] eq "GEN3"){
            $diecisiete = $p;
            foreach $cacho(@en_pedazos){
                $cacho_diecisiete = $cacho_diecisiete . $cacho . " ";
            }
        }elsif($element_size == 4 and $en_pedazos[2] eq "GEN2" and  $en_pedazos[3] eq "GEN4"){
            $dieciocho = $p;
            foreach $cacho(@en_pedazos){
                $cacho_dieciocho = $cacho_dieciocho . $cacho . " ";
            }
        }elsif($element_size == 4 and $en_pedazos[2] eq "GEN3" and  $en_pedazos[3] eq "GEN4"){
            $diecinueve = $p;
            foreach $cacho(@en_pedazos){
                $cacho_diecinueve = $cacho_diecinueve . $cacho . " ";
            }
        }elsif($element_size == 3 and $en_pedazos[2] eq "GEN1"){#250
            $veinte = $p;
            foreach $cacho(@en_pedazos){
                $cacho_veinte = $cacho_veinte . $cacho . " ";
            }
        }elsif($element_size == 3 and $en_pedazos[2] eq "GEN2"){
            $veintiuno = $p;
            foreach $cacho(@en_pedazos){
                $cacho_veintiuno = $cacho_veintiuno . $cacho . " ";
            }
        }elsif($element_size == 3 and $en_pedazos[2] eq "GEN3"){
            $veintidos = $p;
            foreach $cacho(@en_pedazos){
                $cacho_veintidos = $cacho_veintidos . $cacho . " ";
            }
        }elsif($element_size == 3 and $en_pedazos[2] eq "GEN4"){
            $veintitres = $p;
            foreach $cacho(@en_pedazos){
                $cacho_veintitres = $cacho_veintitres . $cacho . " ";
            };
        };
    };
    @for_pre_good_loop = ($cacho_uno,$cacho_dos,$cacho_tres,$cacho_cuatro,$cacho_cinco,$cacho_seis,$cacho_siete,$cacho_ocho,$cacho_nueve,$cacho_diez,$cacho_once,$cacho_doce,$cacho_trece);
    @from_pre_good_loop = pre_good_loop(@for_pre_good_loop);
    @for_good_loop =($uno,$dos,$tres,$cuatro,$cinco,$seis,$siete,$ocho,$nueve,$diez,$once,$doce,$trece,$catorce,$quince,$dieciseis,$diecisiete,$dieciocho,$diecinueve,$veinte,$veintiuno,$veintidos,$veintitres,$from_pre_good_loop[0],$from_pre_good_loop[1],$from_pre_good_loop[2],$from_pre_good_loop[3],$from_pre_good_loop[4],$from_pre_good_loop[5],$from_pre_good_loop[6],$from_pre_good_loop[7],$from_pre_good_loop[8],$from_pre_good_loop[9],$from_pre_good_loop[10],$from_pre_good_loop[11],$from_pre_good_loop[12],$cacho_catorce,$cacho_quince,$cacho_dieciseis,$cacho_diecisiete,$cacho_dieciocho,$cacho_diecinueve,$cacho_veinte,$cacho_veintiuno,$cacho_veintidos,$cacho_veintitres);
    $loop_final_organization = good_loop(@for_good_loop);
    #@loop_reorganized_two_formats = ($loop_final_organization,@for_good_loop);
    return $loop_final_organization;
};

#######################################################################################
sub pre_good_loop{
    @motifs = @_;
    @loops1 = ();
    for($e=0; $e<@motifs;$e++){
        #print "$motifs[$e] = $e \n";
        $value_chido = $motifs[$e];
        @trozado = ();
        @trozado = split / /,$motifs[$e];
        if (@trozado == 18){
            #print "aqui ta el error \n";
            if (($trozado[0] <= $trozado[6] and ($trozado[1] >= $trozado[7] or $trozado[7]==0)) and ($trozado[0] <= $trozado[12] and ($trozado[1] >= $trozado[13] or $trozado[13]==0)) and ($trozado[6] <= $trozado[12] and ($trozado[7] >= $trozado[13] or $trozado[13]==0))){
                @loops1 = (@loops1,$value_chido);
                #print "$loops1 B\n$value_chido B\n";
                #print "$network_number = @loops1 X\n";
            }elsif(($trozado[0] <= $trozado[6] and ($trozado[1] >= $trozado[7] or $trozado[7]==0)) and ($trozado[0] <= $trozado[12] and ($trozado[1] >= $trozado[13] or $trozado[13]==0)) and ($trozado[12] <= $trozado[6] and ($trozado[13] >= $trozado[7] or $trozado[7]==0))){
                $circuito_corregido = $trozado[0] . " " . $trozado[1] . " " . $trozado[2] . " " . $trozado[3] . " " . $trozado[4] . " " . $trozado[5] . " " . $trozado[12] . " " . $trozado[13] . " " . $trozado[14] . " " . $trozado[15] . " " . $trozado[16] . " " . $trozado[17] . " " . $trozado[6] . " " . $trozado[7] . " " . $trozado[8] . " " . $trozado[9] . " " . $trozado[10] . " " . $trozado[11] . " ";
                @loops1 = (@loops1,$circuito_corregido);
                
            }elsif(($trozado[6] <= $trozado[0] and ($trozado[7] >= $trozado[1] or $trozado[1]==0)) and ($trozado[6] <= $trozado[12] and ($trozado[7] >= $trozado[13] or $trozado[13]==0)) and ($trozado[0] <= $trozado[12] and ($trozado[1] >= $trozado[13] or $trozado[13]==0))){
                $circuito_corregido = $trozado[6] . " " . $trozado[7] . " " . $trozado[8] . " " . $trozado[9] . " " . $trozado[10] . " " . $trozado[11] . " " . $trozado[0] . " " . $trozado[1] . " " . $trozado[2] . " " . $trozado[3] . " " . $trozado[4] . " " . $trozado[5] . " " . $trozado[12] . " " . $trozado[13] . " " . $trozado[14] . " " . $trozado[15] . " " . $trozado[16] . " " . $trozado[17] . " ";
                @loops1 = (@loops1,$circuito_corregido);
                
            }elsif(($trozado[6] <= $trozado[0] and ($trozado[7] >= $trozado[1] or $trozado[1]==0)) and ($trozado[6] <= $trozado[12] and ($trozado[7] >= $trozado[13] or $trozado[13]==0)) and ($trozado[12] <= $trozado[0] and ($trozado[13] >= $trozado[1] or $trozado[1]==0))){
                $circuito_corregido = $trozado[6] . " " . $trozado[7] . " " . $trozado[8] . " " . $trozado[9] . " " . $trozado[10] . " " . $trozado[11] . " " . $trozado[12] . " " . $trozado[13] . " " . $trozado[14] . " " . $trozado[15] . " " . $trozado[16] . " " . $trozado[17] . " " . $trozado[0] . " " . $trozado[1] . " " . $trozado[2] . " " . $trozado[3] . " " . $trozado[4] . " " . $trozado[5] . " ";
                @loops1 = (@loops1,$circuito_corregido);#300
                
            }elsif(($trozado[12] <= $trozado[0] and ($trozado[13] >= $trozado[1] or $trozado[1]==0)) and ($trozado[12] <= $trozado[6] and ($trozado[13] >= $trozado[7] or $trozado[7]==0)) and ($trozado[0] <= $trozado[6] and ($trozado[1] >= $trozado[7] or $trozado[7]==0))){
                $circuito_corregido = $trozado[12] . " " . $trozado[13] . " " . $trozado[14] . " " . $trozado[15] . " " . $trozado[16] . " " . $trozado[17] . " " . $trozado[0] . " " . $trozado[1] . " " . $trozado[2] . " " . $trozado[3] . " " . $trozado[4] . " " . $trozado[5] . " " . $trozado[6] . " " . $trozado[7] . " " . $trozado[8] . " " . $trozado[9] . " " . $trozado[10] . " " . $trozado[11] . " ";
                @loops1 = (@loops1,$circuito_corregido);
                
            }else{
                $circuito_corregido = $trozado[12] . " " . $trozado[13] . " " . $trozado[14] . " " . $trozado[15] . " " . $trozado[16] . " " . $trozado[17] . " " . $trozado[6] . " " . $trozado[7] . " " . $trozado[8] . " " . $trozado[9] . " " . $trozado[10] . " " . $trozado[11] . " " . $trozado[0] . " " . $trozado[1] . " " . $trozado[2] . " " . $trozado[3] . " " . $trozado[4] . " " . $trozado[5] . " " ;
                @loops1 = (@loops1,$circuito_corregido);
            };
        }elsif (@trozado == 12){
            if ($trozado[0] <= $trozado[6] and ($trozado[1] >= $trozado[7] or $trozado[7]==0)){
                @loops1 = (@loops1,$value_chido);#310
            }else{
                $circuito_corregido = $trozado[6] . " " . $trozado[7] . " " . $trozado[8] . " " . $trozado[9] . " " . $trozado[10] . " " . $trozado[11] . " " . $trozado[0] . " " . $trozado[1] . " " . $trozado[2] . " " . $trozado[3] . " " . $trozado[4] . " " . $trozado[5] . " ";
                @loops1 = (@loops1,$circuito_corregido)
            };
        }elsif (@trozado == 10){
            if ($trozado[0] <= $trozado[5] and ($trozado[1] >= $trozado[6] or $trozado[6]==0)){
                #print "@trozado aqui toy \n";
                @loops1 = (@loops1,$value_chido);
            }else{
                $circuito_corregido = $trozado[5] . " " . $trozado[6] . " " . $trozado[7] . " " . $trozado[8] . " " . $trozado[9] . " " . $trozado[0] . " " . $trozado[1] . " " . $trozado[2] . " " . $trozado[3] . " " . $trozado[4] . " ";
                @loops1 = (@loops1,$circuito_corregido)
            }
        }else{
            @loops1 = (@loops1,$value_chido);
        };
    };
    #print "@loops1\n";
    return @loops1;
};
#######################################################################################

sub good_loop{
    @values = @_;
    $loops1 = "";
    if ($values[0] != 100){
        $loops1 = $values[23] . " ";
    };
    if ($values[1] != 100){
        $loops1 = $loops1 . $values[24] . " ";
    };
    if ($values[2] != 100){
        $loops1 = $loops1 . $values[25] . " ";
    };
    if ($values[3] != 100){
        $loops1 = $loops1 . $values[26] . " ";
    };
    if ($values[4] != 100){
        $loops1 = $loops1 . $values[27] . " ";
    };
    if ($values[5] != 100){
        $loops1 = $loops1 . $values[28] . " ";
    };
    if ($values[6] != 100){
        $loops1 = $loops1 . $values[29] . " ";
    };
    if ($values[7] != 100){
        $loops1 = $loops1 . $values[30] . " ";
    };
    if ($values[8] != 100){
        $loops1 = $loops1 . $values[31] . " ";
    };
    if ($values[9] != 100){
        $loops1 = $loops1 . $values[32] . " ";
    };
    if ($values[10] != 100){
        $loops1 = $loops1 . $values[33] . " ";
    };
    if ($values[11] != 100){
        $loops1 = $loops1 . $values[34] . " ";
    };
    if ($values[12] != 100){
        $loops1 = $loops1 . $values[35] . " ";
    };
    if ($values[13] != 100){
        $loops1 = $loops1 . $values[36] . " ";
    };
    if ($values[14] != 100){
        $loops1 = $loops1 . $values[37] . " ";
    };
    if ($values[15] != 100){
        $loops1 = $loops1 . $values[38] . " ";
    };
    if ($values[16] != 100){
        $loops1 = $loops1 . $values[39] . " ";
    };
    if ($values[17] != 100){
        $loops1 = $loops1 . $values[40] . " ";
    };
    if ($values[18] != 100){
        $loops1 = $loops1 . $values[41] . " ";
    };
    if ($values[19] != 100){
        $loops1 = $loops1 . $values[42] . " ";
    };
    if ($values[20] != 100){
        $loops1 = $loops1 . $values[43] . " ";
    };
    if ($values[21] != 100){
        $loops1 = $loops1 . $values[44] . " ";
    };
    if ($values[22] != 100){
        $loops1 = $loops1 . $values[45] . " ";
    };
    return $loops1;
};

#######################################################################################

#print OUTFILE1"\@All_functional_loops = (";
#foreach $bucle(@All_functional_loops){
#    chop $bucle;
#    chop $bucle;
#     $loops_string = $loops_string . "\"$bucle\", ";
#}
#chop $loops_string;
#chop $loops_string;
print OUTFILE1")\;";
close OUTFILE1;
close OUTFILE2;

