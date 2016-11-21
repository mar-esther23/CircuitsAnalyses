#! perl -w

@numero_de_nodos = (0, 1, 2, 3, 4);
open(OUTFILE1,">new_sampling_for_combinations.txt");
@nodos = qw (GEN_blanco GEN1 GEN2 GEN3 GEN4);
@conectividad_gen1 = (0,0,0,0,0);
@conectividad_gen2 = (1,1,1,1,1);
@conectividad_gen_blanco = (1,1,1,1,1);
@conectividad_gen3 = (1,1,1,1,1);
@conectividad_gen4 = (1,1,1,1,1);
@Matriz_de_conectividad = (\@conectividad_gen1,\@conectividad_gen2,\@conectividad_gen_blanco,\@conectividad_gen3,\@conectividad_gen4);
#$filas_y_columnas = @numero_de_nodos;
#$Valores_necesarios_para_matriz = $filas_y_columnas * $filas_y_columnas;
#$matrices_posibles = 21;#(2**$Valores_necesarios_para_matriz)-8388607;#AHORA LAS MATRICES POSIBLES SON SOLO 20,315,932 PUES YA CHECO LAS PRIMERAS 13,238,500 Y NO ES NCESARIO VOLVER A GENERARLAS, EL COMO SE EVITA QUE SE GENEREN LAS MATRICES YA ANALIZADAS ESTA EN COMO SE GENERA EL NUMERO ALEATORIO QUE SER´A LA NUEVA MATRIZ (ver abajo $random_Matriz = int(rand($matrices_posibles)) + 13238500;)
$l=0;

for ($h=0;$h<1000000000000;$h++){#AHORA EN VEZ DE CHECAR HASTA QUE TERMINE LAS TOPOLOG´IAS, HARA EL PROCESO DE BUSQUEDA 1 BILLON DE VECES
	#$random_Matriz = 1048575;#int(rand($matrices_posibles)+294911);#GENERARA UN NUMERO ALEATORIO DE TOPOLOGIA A PARTIR DE NUMERO 13,238,500 QUE ES LA ULTIMA TOPOLOGIA QUE COMENZO A ANALIZAR
#LA BUSQUEDA ALEATORIA DE REDES QUE SE ENCUENTRA EN LA SUBRRUTINA "genera redes" QUE ESTA HASTA ABAJO DEL SCRIPT
    for ($po=0;$po<=7;$po++){
        $target = int(rand(5));
        $regulator = int(rand(4))+1;
        print "el target es $target\n$regulator\n";
        $Matriz_de_conectividad[$regulator][$target] = int(rand(2));
        print "Aca sale esto $Matriz_de_conectividad[$regulator][$target]\n"
    }
    #$Matriz_de_conectividad[1][0] = 0;
	#$p = 0;
	#$valores_para_matriz = decimal_a_vector_binario ($random_Matriz,$Valores_necesarios_para_matriz);
	#@valores_a_asignar = split (/\,/, $valores_para_matriz);
    #$cantidad_de_interacciones = 0;
	#for ($j=0;$j<$filas_y_columnas;$j++){
	#	for ($k=0;$k<$filas_y_columnas;$k++){
	#		$Matriz_de_conectividad[$j][$k] = $valores_a_asignar[$p];
    #        $cantidad_de_interacciones = $cantidad_de_interacciones+$valores_a_asignar[$p];
    #        #print "$cantidad_de_interacciones\n";
	#		$p++;
	#	};
	#};
    #print "$Matriz_de_conectividad[1][0]\n";
	#if ($cantidad_de_interacciones>17){
		if (Cumple_con_la_topologia_esperada(@Matriz_de_conectividad)){
		$l++;
		@interacciones = ();
			foreach $n (@numero_de_nodos){
				for ($m=0;$m<@numero_de_nodos;$m++){
					if ($Matriz_de_conectividad[$n][$m] == 1){
						@interacciones = (@interacciones, "$nodos[$n] $nodos[$m]");
					};
				};
			};
			@numero_de_reguladores_de_cada_nodo = contador_de_reguladores(@interacciones); 
			@reguladores_de_cada_nodo = nombres_de_los_reguladores(@interacciones);
			#print "@numero_de_reguladores_de_cada_nodo \n";#\n este es el nombre de los reguladores del GEN blanco: $reguladores_de_cada_nodo[0] \n este es el nombre de los reguladores del GEN1: $reguladores_de_cada_nodo[1] \n este es el nombre de los reguladores del GEN2: $reguladores_de_cada_nodo[2] \n este es el nombre de los reguladores del GEN3: $reguladores_de_cada_nodo[3] \n este es el nombre de los reguladores del GEN4: $reguladores_de_cada_nodo[4]\n";
			genera_redes ($numero_de_reguladores_de_cada_nodo[0], $numero_de_reguladores_de_cada_nodo[1], $numero_de_reguladores_de_cada_nodo[2], $numero_de_reguladores_de_cada_nodo[3], $numero_de_reguladores_de_cada_nodo[4], $reguladores_de_cada_nodo[0], $reguladores_de_cada_nodo[1], $reguladores_de_cada_nodo[2], $reguladores_de_cada_nodo[3], $reguladores_de_cada_nodo[4]);
		};
	#};
};

##########################################################################################################################################################################
sub decimal_a_vector_binario{
	my $la_regla = "";
	my $numero = $_[0];
	my $tamano = $_[1];
	for ($i=$tamano; $i>0; $i--){
		$valor_del_regulador= $numero % 2;
		$numero = $numero/2;
		$la_regla = "$valor_del_regulador," . "$la_regla"; 
	};
	chop $la_regla;
	return $la_regla;
};

##########################################################################################################################################################################
sub Checa_numero_de_reguladores{

	if  (($Matriz_de_conectividad[0][0]+$Matriz_de_conectividad[1][0]+$Matriz_de_conectividad[2][0]+$Matriz_de_conectividad[3][0]+$Matriz_de_conectividad[4][0]>3) || ($Matriz_de_conectividad[0][1]+$Matriz_de_conectividad[1][1]+$Matriz_de_conectividad[2][1]+$Matriz_de_conectividad[3][1]+$Matriz_de_conectividad[4][1]>4) || ($Matriz_de_conectividad[0][2]+$Matriz_de_conectividad[1][2]+$Matriz_de_conectividad[2][2]+$Matriz_de_conectividad[3][2]+$Matriz_de_conectividad[4][2]>4) || ($Matriz_de_conectividad[0][3]+$Matriz_de_conectividad[1][3]+$Matriz_de_conectividad[2][3]+$Matriz_de_conectividad[3][3]+$Matriz_de_conectividad[4][3]>3) || ($Matriz_de_conectividad[0][4]+$Matriz_de_conectividad[1][4]+$Matriz_de_conectividad[2][4]+$Matriz_de_conectividad[3][4]+$Matriz_de_conectividad[4][4]>4) ||($Matriz_de_conectividad[0][0] == 1 && $Matriz_de_conectividad[1][0] == 1)){
		return 0;
	}else{
		return 1;
	};
};

##########################################################################################################################################################################
sub Cumple_con_la_topologia_esperada{

	if (($Matriz_de_conectividad[1][2]==0) || ($Matriz_de_conectividad[2][0]==0) || ($Matriz_de_conectividad[3][4]==0) || ($Matriz_de_conectividad[4][0]==0) || ($Matriz_de_conectividad[0][2]==1) || ($Matriz_de_conectividad[0][1]==1) || ($Matriz_de_conectividad[0][0]==1) || ($Matriz_de_conectividad[0][3]==1) || ($Matriz_de_conectividad[0][4]==1)){

		return 0;
	}else{
		return 1;
	};
};

##########################################################################################################################################################################
sub contador_de_reguladores{

	$Reguladores_del_GEN1 = 1;
	$Reguladores_del_GEN2 = 0;
	$Reguladores_del_GEN_blanco = 0;
	$Reguladores_del_GEN3 = 1;
	$Reguladores_del_GEN4 = 0;
	@numero_de_reguladores_de_los_nodos = ($Reguladores_del_GEN_blanco, $Reguladores_del_GEN1, $Reguladores_del_GEN2, $Reguladores_del_GEN3, $Reguladores_del_GEN4);

	for ($y=0;$y<@interacciones;$y++){
		($nodo_origen,$nodo_destino) = split(" ",$interacciones[$y]);#divide las interacciones en el nodo de input y su nodo blanco
		for ($f=0; $f<@nodos; $f++){
			if ($nodo_destino eq $nodos[$f]){
				$numero_de_reguladores_de_los_nodos[$f]++;			
			};
		};
	};
	return @numero_de_reguladores_de_los_nodos;
};

##########################################################################################################################################################################
sub nombres_de_los_reguladores{

	@reguladores_del_GEN1 = ("INP1");
	$lista_de_nombres_GEN1 = "INP1";	
	@reguladores_del_GEN2 = ();
	$lista_de_nombres_GEN2 = "";	
	@reguladores_del_GEN_blanco = ();
	$lista_de_nombres_GEN_blanco = "";	
	@reguladores_del_GEN3 = ("INP2");
	$lista_de_nombres_GEN3 = "INP2";	
	@reguladores_del_GEN4 = ();
	$lista_de_nombres_GEN4 = "";	
	for ($e=0;$e<@interacciones;$e++){
		($nodo_origen,$nodo_destino) = split(" ",$interacciones[$e]);#divide las interacciones en el nodo de input y su nodo blanco

		if ($nodo_destino eq $nodos[1]){
			@reguladores_del_GEN1 = (@reguladores_del_GEN1, $nodo_origen);
			$lista_de_nombres_GEN1 = arreglo_a_cadena(@reguladores_del_GEN1);
#			print "$lista_de_nombres_GEN1 **************\n";
		}elsif ($nodo_destino eq $nodos[2]){
			@reguladores_del_GEN2 = (@reguladores_del_GEN2, $nodo_origen);
			$lista_de_nombres_GEN2 = arreglo_a_cadena(@reguladores_del_GEN2);
		}elsif ($nodo_destino eq $nodos[0]){
			@reguladores_del_GEN_blanco = (@reguladores_del_GEN_blanco, $nodo_origen);
			$lista_de_nombres_GEN_blanco = arreglo_a_cadena(@reguladores_del_GEN_blanco);
		}elsif ($nodo_destino eq $nodos[3]){
			@reguladores_del_GEN3 = (@reguladores_del_GEN3, $nodo_origen);
			$lista_de_nombres_GEN3 = arreglo_a_cadena(@reguladores_del_GEN3);
		}elsif ($nodo_destino eq $nodos[4]){
			@reguladores_del_GEN4 = (@reguladores_del_GEN4, $nodo_origen);
			$lista_de_nombres_GEN4 = arreglo_a_cadena(@reguladores_del_GEN4);
		}; 
	}; 
	@lista_de_nombres_GENES = ($lista_de_nombres_GEN_blanco, $lista_de_nombres_GEN1, $lista_de_nombres_GEN2, $lista_de_nombres_GEN3, $lista_de_nombres_GEN4);
	return @lista_de_nombres_GENES;
};

#####################################################################################################################################################
sub arreglo_a_cadena{
	my $cadena_final = "";
	foreach my $parte (@_){
		$cadena_final .= "\'" . $parte . "\' ";
	};
	chop $cadena_final;
	return $cadena_final;
};

##################################################################################################################################
sub effect_of_last_regulator{

	my @input = @_;
	my @pairs = ();
	while(@input){
		my $pair = shift(@input);
		$pair .= shift(@input);
		push(@pairs,$pair);
	};
	my $number_of_pairs = @pairs;
	my $positive_effects = 0;
	my $negative_effects = 0;
	my $neutral_effects = 0;
	for(my $i1=0;$i1<$number_of_pairs;$i1++){
		if(($pairs[$i1] eq "00") or ($pairs[$i1] eq "11")){
			$neutral_effects++;
		};
		if($pairs[$i1] eq "01"){
			$positive_effects++;
			;
		};
		if($pairs[$i1] eq "10"){
			$negative_effects++;
		};
	};
	if($neutral_effects == $number_of_pairs){
		return 1;
	}elsif(($positive_effects>0) and ($negative_effects>0)){
		return 1;
	};
};

#################################################################################################
sub rearrange_vector{

	my @input = @_;
	my $size = @input;
	my @even = ();
	my @odd = ();
	for(my $i2=0;$i2<$size;$i2++){
		if($i2%2 == 0){
			push(@even,$input[$i2]);
		}else{
			push(@odd,$input[$i2]);
		};
	};
	my @output = (@even,@odd);
	return @output;
};

#####################################################################################################################################################
sub genera_redes{

	$numero_de_reguladores1 = $_[1];
	$numero_de_reguladores2 = $_[2];
	$numero_de_reguladores_blanco = $_[0];
	$numero_de_reguladores3 = $_[3];
	$numero_de_reguladores4 = $_[4];
	$numero_de_posiciones_en_la_regla1 = 2**$numero_de_reguladores1;
	$numero_de_posiciones_en_la_regla2 = 2**$numero_de_reguladores2;
	$numero_de_posiciones_en_la_regla_blanco = 2**$numero_de_reguladores_blanco;
	$numero_de_posiciones_en_la_regla3 = 2**$numero_de_reguladores3;
	$numero_de_posiciones_en_la_regla4 = 2**$numero_de_reguladores4;
	$numero_total_de_reglas1 = (2**($numero_de_posiciones_en_la_regla1))-1;
	$numero_total_de_reglas2 = (2**($numero_de_posiciones_en_la_regla2))-1;
	$numero_total_de_reglas_blanco = (2**($numero_de_posiciones_en_la_regla_blanco))-1;
	$numero_total_de_reglas3 = (2**($numero_de_posiciones_en_la_regla3))-1;
	$numero_total_de_reglas4 = (2**($numero_de_posiciones_en_la_regla4))-1;
	$reguladores_GEN1 = $_[6];
	$reguladores_GEN2 = $_[7];
	$reguladores_GEN_blanco = $_[5];
	$reguladores_GEN3 = $_[8];
	$reguladores_GEN4 = $_[9];
    #print "XXXXXXXXXXXXX$reguladores_GEN1\n";



	for($z1=0;$z1<10;$z1++){ # $reglas AHORA NO GENERA TODAS LAS REGLAS POSIBLES SINO SOLO 20
		$random_Regla1 = int(rand($numero_total_de_reglas1));#AQUI GENERA EL NUMERO ALEATORIO QUE SERA LA REGLA
		$regla_binaria_GEN1 = decimal_a_vector_binario ($random_Regla1,$numero_de_posiciones_en_la_regla1);#UTILIZA EL NUMERO ALEATORIO PARA GENERAR LA REGLA. SE HACE EL MISMO PROCEDIMIENTO PARA GENERAR LAS REGLAS DE LOS OTROS NODOS. LO DEMAS DEL PROGRAA ESTA IGUAL 
		@input_vector1 = split (",", $regla_binaria_GEN1);
		$buena_regla1 = 0;
		for($w1=0;$w1<$numero_de_reguladores1;$w1++){
			if (!effect_of_last_regulator(@input_vector1)){
			$buena_regla1 ++;
			}; 
			@input_vector1 = rearrange_vector(@input_vector1);
		}; 

		if ($buena_regla1 eq $numero_de_reguladores1){
			$regla_GEN1 = "[" . $regla_binaria_GEN1 . "]";
			$regla_booleana1 = qx/python -m elogic \'s\' \'$regla_GEN1\' $reguladores_GEN1/;
			chomp $regla_booleana1;
			$regla_Booleana_para_usar_GEN1 = "GEN1, $regla_booleana1";

			for($z2=0;$z2<10;$z2++){ # $reglas
				$random_Regla2 = int(rand($numero_total_de_reglas2));
				$regla_binaria_GEN2 = decimal_a_vector_binario ($random_Regla2,$numero_de_posiciones_en_la_regla2);
				@input_vector2 = split (",", $regla_binaria_GEN2);
				$buena_regla2 = 0;
				for($w2=0;$w2<$numero_de_reguladores2;$w2++){
					if (!effect_of_last_regulator(@input_vector2)){
					$buena_regla2 ++;
					}; 
					@input_vector2 = rearrange_vector(@input_vector2);
				}; 
				if ($buena_regla2 eq $numero_de_reguladores2){
					$regla_GEN2 = "[" . $regla_binaria_GEN2 . "]";
					$regla_booleana2 = qx/python -m elogic \'s\' \'$regla_GEN2\' $reguladores_GEN2/;
					chomp $regla_booleana2;
					$regla_Booleana_para_usar_GEN2 = "GEN2, $regla_booleana2";

					for($z_blanco=0;$z_blanco<10;$z_blanco++){ # $reglas
						$random_Regla_blanco = int(rand($numero_total_de_reglas_blanco));
						$regla_binaria_GEN_blanco = decimal_a_vector_binario ($random_Regla_blanco,$numero_de_posiciones_en_la_regla_blanco);
						@input_vector_blanco = split (",", $regla_binaria_GEN_blanco);
						$buena_regla_blanco = 0;
						for($w_blanco=0;$w_blanco<$numero_de_reguladores_blanco;$w_blanco++){
							if (!effect_of_last_regulator(@input_vector_blanco)){
							$buena_regla_blanco ++;
							}; 
							@input_vector_blanco = rearrange_vector(@input_vector_blanco);
						}; 
						if ($buena_regla_blanco eq $numero_de_reguladores_blanco){
							$regla_GEN_blanco = "[" . $regla_binaria_GEN_blanco . "]";
							$regla_booleana_blanco = qx/python -m elogic \'s\' \'$regla_GEN_blanco\' $reguladores_GEN_blanco/;
							chomp $regla_booleana_blanco;
							$regla_Booleana_para_usar_GEN_blanco = "GEN_BLANCO, $regla_booleana_blanco";

							for($z3=0;$z3<10;$z3++){ # $reglas
								$random_Regla3 = int(rand($numero_total_de_reglas3));
								$regla_binaria_GEN3 = decimal_a_vector_binario ($random_Regla3,$numero_de_posiciones_en_la_regla3);
								@input_vector3 = split (",", $regla_binaria_GEN3);
								$buena_regla3 = 0;
								for($w3=0;$w3<$numero_de_reguladores3;$w3++){
									if (!effect_of_last_regulator(@input_vector3)){
									$buena_regla3 ++;
									}; 
									@input_vector3 = rearrange_vector(@input_vector3);
								}; 
								if ($buena_regla3 eq $numero_de_reguladores3){
									$regla_GEN3 = "[" . $regla_binaria_GEN3 . "]";
									$regla_booleana3 = qx/python -m elogic \'s\' \'$regla_GEN3\' $reguladores_GEN3/;
									chomp $regla_booleana3;
									$regla_Booleana_para_usar_GEN3 = "GEN3, $regla_booleana3";

									for($z4=0;$z4<10;$z4++){ # $reglas
										$random_Regla4 = int(rand($numero_total_de_reglas4));
										$regla_binaria_GEN4 = decimal_a_vector_binario ($random_Regla4,$numero_de_posiciones_en_la_regla4);
										@input_vector4 = split (",", $regla_binaria_GEN4);
										$buena_regla4 = 0;
										for($w4=0;$w4<$numero_de_reguladores4;$w4++){
											if (!effect_of_last_regulator(@input_vector4)){
											$buena_regla4 ++;
											}; 
											@input_vector4 = rearrange_vector(@input_vector4);
										}; 
										if ($buena_regla4 eq $numero_de_reguladores4){
											$regla_GEN4 = "[" . $regla_binaria_GEN4 . "]";
											$regla_booleana4 = qx/python -m elogic \'s\' \'$regla_GEN4\' $reguladores_GEN4/;
											chomp $regla_booleana4;
											$regla_Booleana_para_usar_GEN4 = "GEN4, $regla_booleana4";
		
											$contador ++;
											$nueva_red = "INP1, INP1\n" . "INP2, INP2\n" . "$regla_Booleana_para_usar_GEN1\n" . "$regla_Booleana_para_usar_GEN2\n" . "$regla_Booleana_para_usar_GEN_blanco\n" . "$regla_Booleana_para_usar_GEN3\n" . "$regla_Booleana_para_usar_GEN4\n";
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
									};
								};
							};
						};
					};
				};
			};
		};		
	};
};

