import org.jfree.ui.RefineryUtilities;
import org.moeaframework.Analyzer;
import org.moeaframework.Executor;
import org.moeaframework.core.NondominatedPopulation;
import org.moeaframework.core.Problem;
import org.moeaframework.core.Solution;
import org.moeaframework.core.indicator.Hypervolume;

public class GDE3_PPSB_Solver {




public static void main(String[] args) {
		
		
		Analyzer analyzer = new Analyzer()
				.withProblemClass(PPSB_Problem.class)
				.includeAllMetrics()
				.showStatisticalSignificance();
		

		double bestHyperVolume = 0; //instantiate as 0 so that initial hyper volume set as best
		NondominatedPopulation bestNonDominatedPopulation = null;
		
		for (int count = 1; count < 31; count++) {
			
			System.out.println("Run " + count);
			
			Executor executor = new Executor()
			.withProblemClass(PPSB_Problem.class)
			.withMaxEvaluations(10000);		
			
			NondominatedPopulation returnedPop = executor.withAlgorithm("GDE3").run();
			analyzer.add("GDE3", returnedPop);
			
			Problem problem = new PPSB_Problem();
			Hypervolume hyperVolume = new Hypervolume(problem, returnedPop);
			
			//Shan's code
			int COUNT = returnedPop.size();
			// In order to plot in jFreeChart
			// We need to store the objective values in a 2d array
			float [][] data = new float[2][COUNT];
			int i=0;		
			System.out.format("Objective1  Objective2%n");
			for (Solution solution : returnedPop) {
				System.out.format("%.4f      %.4f%n",
						solution.getObjective(0),
						solution.getObjective(1));
				data[0][i] = (float) solution.getObjective(0);
				data[1][i] = (float) solution.getObjective(1);
				i++;
			}
			
			if(bestHyperVolume < hyperVolume.evaluate(returnedPop)){
				bestHyperVolume = hyperVolume.evaluate(returnedPop);
				bestNonDominatedPopulation = returnedPop;
			}
		}
		
		
		//Shan's code to plot results
		int COUNT = bestNonDominatedPopulation.size();
		// In order to plot in jFreeChart
		// We need to store the objective values in a 2d array
		float [][] data = new float[2][COUNT];
		int i=0;		

		for (Solution solution : bestNonDominatedPopulation) {

			data[0][i] = (float) solution.getObjective(0);
			data[1][i] = (float) solution.getObjective(1);
			i++;
		}
		
		
		// Instantiate a chart object of plotParetoFront
		plotParetoFront plotChart = new plotParetoFront("Pareto solutions", data);
		plotChart.pack();
		RefineryUtilities.centerFrameOnScreen(plotChart);
		plotChart.setVisible(true);
		
		analyzer.printAnalysis();
		
	}
}
