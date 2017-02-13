
import org.moeaframework.core.Solution;
import org.moeaframework.core.variable.EncodingUtils;
import org.moeaframework.core.variable.RealVariable;
import org.moeaframework.problem.AbstractProblem;


public class PPSB_Problem extends AbstractProblem {

	//create a 3 by 3 array to represent the problem materials
	private double [][] pEc = new double[3][3]; 

	public PPSB_Problem() {
		//(numberOfVariables, numberOfObjectives,setOfConstraints);
		super(5,2,3);

		//pEc p=density E=young's constant c=Cost of material
		//properties of material 1
		pEc[0][0] = 100.0;
		pEc[0][1] = 1.60E+09;
		pEc[0][2] = 500.0;
		//properties of material 2
		pEc[1][0] = 2770.0;
		pEc[1][1] = 7.00E+10;
		pEc[1][2] = 1500.0;
		//properties of material 3
		pEc[2][0] = 7780.0;
		pEc[2][1] =  2.00E+11;
		pEc[2][2] = 800.0;
	}


	@Override
	public void evaluate(Solution solution) {
		double[] x = EncodingUtils.getReal(solution);
		double f1 = 0.0; 
		double f2 = 0.0; 

		double d1 = x[0];
		double d2 = x[1];
		double d3 = x[2];

		double b = x[3];
		double L = x[4];

		double EI = ((2*b) / 3) * ( (pEc[0][1]*Math.pow(d1,3)) + (pEc[1][1]*(Math.pow(d2,3)-Math.pow(d1,3))) + (pEc[2][1]*( Math.pow(d3,3) - Math.pow(d2,3))) );
		double mu = (2*b) * ( (pEc[0][0] * d1) + (pEc[1][0] * ( d2 - d1 )) + (pEc[2][0] * (d3 - d2)) );

		f1 = (Math.PI / ( 2* Math.pow(L,2) )) * (Math.pow((EI / mu),0.5));
		f2 = (2*b*L) * ( (pEc[0][2] * d1) + (pEc[1][2] * (d2 - d1)) + (pEc[2][2] * (d3 - d2)) );

		//objectives to be minimised are set f1 and f2
		solution.setObjective(0, f1);
		solution.setObjective(1, f2);

		//beam length constraint
		double constraintu = 0.0;
		if( (mu*L) > 2800 ){
			constraintu = (mu*L) - 2800;
		}else if( (mu*L) < 2000){
			constraintu = 2000 - (mu*L);
		}
		solution.setConstraint(0, constraintu);

		//material 2 wifth constraint
		double material2Width = 0.0;
		if(d2 - d1 > 0.58){
			material2Width = d2 - d1;
		}else if(d2 - d1 < 0.01){
			material2Width = Math.abs(d2 - d1);
		}
		solution.setConstraint(1, material2Width);

		// material 3 width constraint
		double material3Width = 0.0;
		if(d3 - d2 > 0.57){
			material3Width  = d3 - d2;
		}else if (d3 - d2 < 0.01){
			material3Width = Math.abs(d3 - d2);
		}
		solution.setConstraint(2, material3Width);
	}

	@Override
	public Solution newSolution() {
		Solution solution = new Solution(numberOfVariables, numberOfObjectives,numberOfConstraints);

		//setting variables with upper and lower bounds for problem
		solution.setVariable(0,  new RealVariable(0.01, 0.58));     //d1
		solution.setVariable(1,  new RealVariable(0.02, 0.59));     // d2
		solution.setVariable(2,  new RealVariable(0.30, 0.60));     // d3
		solution.setVariable(3,  new RealVariable(0.30, 0.55));     // b (beam width)
		solution.setVariable(4,  new RealVariable(3.00, 6.00));     // L (beam length)

		return solution;
	}



}