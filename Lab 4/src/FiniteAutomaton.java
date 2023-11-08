import java.io.File;
import java.io.FileNotFoundException;
import java.util.*;

public class FiniteAutomaton {

    // Separator used in the input file to separate elements
    private final String ELEM_SEPARATOR = ";";

    // Boolean flag indicating whether the FA is deterministic or not
    private boolean isDeterministic;

    // Initial state of the FA
    private String initialState;

    // Lists to store states, alphabet symbols, and final states of the FA
    private List<String> states;
    private List<String> alphabet;
    private List<String> finalStates;

    // Map to store transitions between states based on input symbols
    private final Map<Pair<String, String>, Set<String>> transitions;

    /**
     * Constructor for the FiniteAutomaton class. Reads FA details from the input file.
     * @param filePath - the file path of the file which will be read
     */
    public FiniteAutomaton(String filePath) {this.transitions = new HashMap<>();
        this.readFromFile(filePath);
    }

    /**
     * This method reads the content of the Finite Automaton from the file and populates the lists for the states,
     * alphabet, finalStates,
     * the string for the initial state, and the map for the transitions.
     * @param filePath - the file path of the file which will be read
     */
    private void readFromFile(String filePath) {
        try (Scanner scanner = new Scanner(new File(filePath))) {

            // Read states, initial state, alphabet, and final states from the file
            this.states = new ArrayList<>(List.of(scanner.nextLine().split(this.ELEM_SEPARATOR)));
            this.initialState = scanner.nextLine();
            this.alphabet = new ArrayList<>(List.of(scanner.nextLine().split(this.ELEM_SEPARATOR)));
            this.finalStates = new ArrayList<>(List.of(scanner.nextLine().split(this.ELEM_SEPARATOR)));

            // Read transitions and populate the transitions map
            while (scanner.hasNextLine()) {
                String transitionLine = scanner.nextLine();
                String[] transitionComponents = transitionLine.split(" ");

                // Validate and add transitions to the map
                if (states.contains(transitionComponents[0]) && states.contains(transitionComponents[2]) && alphabet.contains(transitionComponents[1])) {
                    Pair<String, String> transitionStates = new Pair<>(transitionComponents[0], transitionComponents[1]);
                    transitions.computeIfAbsent(transitionStates, k -> new HashSet<>()).add(transitionComponents[2]);
                }
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }

        // Check if the FA is deterministic
        this.isDeterministic = checkIfDeterministic();
    }

    /**
     * This method checks if the FA is deterministic or not.
     * @return true if the FA is deterministic, false otherwise
     */
    public boolean checkIfDeterministic() {
        // FA is deterministic if every transition leads to at most one state
        return this.transitions.values().stream().allMatch(list -> list.size() <= 1);
    }

    /**
     * This method returns the list of states of the FA.
     * @return the states of the FA
     */
    public List<String> getStates() {
        return this.states;
    }

    /**
     * This method returns the initial state of the FA.
     * @return the initial state of the FA
     */
    public String getInitialState() {
        return this.initialState;
    }

    /**
     * This method returns the alphabet of the FA.
     * @return the alphabet of the FA
     */
    public List<String> getAlphabet() {
        return this.alphabet;
    }

    /**
     * This method returns the list of final states of the FA.
     * @return the list of final states of the FA
     */
    public List<String> getFinalStates() {
        return this.finalStates;
    }

    /**
     * This method generates a string representation of the transitions in the FA.
     * @return a string containing the transitions of the FA
     */
    public String writeTransitions(){
        StringBuilder builder = new StringBuilder();
        builder.append("Transitions: \n");
        // Iterate through transitions and append them to the string
        transitions.forEach((K, V) -> {
            builder.append("<").append(K.getFirst()).append(",").append(K.getSecond()).append("> -> ").append(V).append("\n");
        });

        return builder.toString();
    }

    /**
     * This method checks if a sequence is accepted by the finite automaton.
     * @param sequence - the sequence to check if it's accepted
     * @return true if the sequence is accepted and contained by the list of final states of the FA, false otherwise
     */
    public boolean acceptsSequence(String sequence) {
        // Non-deterministic FAs cannot process sequences
        if (!this.isDeterministic) {
            return false;
        }

        // If the sequence is empty, check if the initial state is a final state
        if(sequence.length() == 0)
            return finalStates.contains(initialState);

        String currentState = this.initialState;

        // Iterate through the sequence and perform transitions based on input symbols
        for (int i = 0; i < sequence.length(); i++) {
            String currentSymbol = sequence.substring(i, i + 1);
            Pair<String, String> transition = new Pair<>(currentState, currentSymbol);
            // If the transition is not defined, the sequence is not accepted
            if (!this.transitions.containsKey(transition)) {
                return false;
            } else {
                // Perform the transition to the next state
                currentState = this.transitions.get(transition).iterator().next();
            }
        }

        // Check if the final state is reached after processing the sequence
        return this.finalStates.contains(currentState);
    }
}
