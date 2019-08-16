dtmc

const int AA = 0;
const int BB = 1;
const int AB = 2;
const int AO = 3;
const int BO = 4;
const int OO = 5;

const double firstbirth = 1/6;

module blood
	
	s: [0 .. 3] init 0;
	parent1 : [0..5];
	parent2 : [0..5];
	child: [0..5];

	[firstphase] s=0 -> firstbirth:(parent1'=AA)&(s'=1) + firstbirth:(parent1'=AB)&(s'=1) + firstbirth:(parent1'=BB)&(s'=1) + firstbirth:(parent1'=AO)&(s'=1) + firstbirth:(parent1'=BO)&(s'=1) + firstbirth:(parent1'=OO)&(s'=1);
	[firstphase] s=1 -> firstbirth:(parent2'=AA)&(s'=2) + firstbirth:(parent2'=AB)&(s'=2) + firstbirth:(parent2'=BB)&(s'=2) + firstbirth:(parent2'=AO)&(s'=2) + firstbirth:(parent2'=BO)&(s'=2) + firstbirth:(parent2'=OO)&(s'=2);

	[AAAA] s=2&(parent1=AA&parent2=AA) -> (child'=AA)&(s'=3);
	[AABB] s=2&((parent1=AA&parent2=BB)|(parent1=BB&parent2=AA)) -> (child'=AB)&(s'=3);
	[AAAB] s=2&((parent1=AA&parent2=AB)|(parent1=AB&parent2=AA)) -> 0.5:(child'=AA)&(s'=3) + 0.5:(child'=AB)&(s'=3);
	[AAAO] s=2&((parent1=AA&parent2=AO)|(parent1=AO&parent2=AA)) -> 0.5:(child'=AA)&(s'=3) + 0.5:(child'=AO)&(s'=3);
	[AABO] s=2&((parent1=AA&parent2=BO)|(parent1=BO&parent2=AA)) -> 0.5:(child'=AB)&(s'=3) + 0.5:(child'=AO)&(s'=3);
	[AAOO] s=2&((parent1=AA&parent2=OO)|(parent1=OO&parent2=AA)) -> (child'=AO)&(s'=3);

	[AOBB] s=2&((parent1=AO&parent2=BB)|(parent1=BB&parent2=AO)) -> 0.5:(child'=AB)&(s'=3) + 0.5:(child'=BO)&(s'=3);
	[AOAB] s=2&((parent1=AO&parent2=AB)|(parent1=AB&parent2=AO)) -> 0.25:(child'=AA)&(s'=3) + 0.25:(child'=AB)&(s'=3) + 0.25:(child'=AO)&(s'=3) + 0.25:(child'=BO)&(s'=3);
	[AOAO] s=2&((parent1=AO&parent2=AO)) -> 0.25:(child'=AA)&(s'=3) + 0.5:(child'=AO)&(s'=3) + 0.25:(child'=OO)&(s'=3);
	[AOBO] s=2&((parent1=AO&parent2=BO)|(parent1=BO&parent2=AO)) -> 0.25:(child'=AB)&(s'=3) + 0.25:(child'=AO)&(s'=3) + 0.25:(child'=BO)&(s'=3) + 0.25:(child'=OO)&(s'=3);
	[AOOO] s=2&((parent1=AO&parent2=OO)|(parent1=OO&parent2=AO)) -> 0.5:(child'=AO)&(s'=3) + 0.5:(child'=OO)&(s'=3);
	
	[ABBB] s=2&((parent1=AB&parent2=BB)|(parent1=BB&parent2=AB)) -> 0.5:(child'=AB)&(s'=3) + 0.5:(child'=BB)&(s'=3);
	[ABAB] s=2&((parent1=AB&parent2=AB)) -> 0.25:(child'=AA)&(s'=3) + 0.5:(child'=AB)&(s'=3) + 0.25:(child'=BB)&(s'=3);
	[ABBO] s=2&((parent1=AB&parent2=BO)|(parent1=BO&parent2=AB)) -> 0.25:(child'=AB)&(s'=3) + 0.25:(child'=AO)&(s'=3) + 0.25:(child'=BO)&(s'=3) + 0.25:(child'=BB)&(s'=3);
	[ABOO] s=2&((parent1=AB&parent2=OO)|(parent1=OO&parent2=AB)) -> 0.5:(child'=AO)&(s'=3) + 0.5:(child'=BO)&(s'=3);

	[BBBB] s=2&((parent1=BB&parent2=BB)) -> (child'=BB)&(s'=3);
	[BBBO] s=2&((parent1=BB&parent2=BO)|(parent1=BO&parent2=BB)) -> 0.5:(child'=BB)&(s'=3) + 0.5:(child'=BO)&(s'=3);
	[BBOO] s=2&((parent1=BB&parent2=OO)|(parent1=OO&parent2=BB)) -> (child'=BO)&(s'=3);

	[BOBO] s=2&((parent1=BO&parent2=BO)) -> 0.25:(child'=BB)&(s'=3) + 0.5:(child'=BO)&(s'=3) + 0.25:(child'=OO)&(s'=3);
	[BOOO] s=2&((parent1=BO&parent2=OO)|(parent1=OO&parent2=BO)) -> 0.5:(child'=BO)&(s'=3) + 0.5:(child'=OO)&(s'=3);

	[OOOO] s=2&((parent1=OO&parent2=OO)) -> (child'=OO)&(s'=3);

	[end] s=3 -> (s'=3);

endmodule