module deployer::random {

    use std::vector;
    use aptos_framework::randomness;

    /*
    * This function receives a vector of weights as input and returns
    * a random index number based on the weights.
    */
    public fun random_by_weights(weights: vector<u64>): u64 {
        let total_weights = 0u64;
        vector::for_each<u64>(weights, | value | {
            total_weights = total_weights + value;
        });

        let random_value = randomness::u64_range(1, total_weights);

        let cursor = 0u64;
        let i = 0u64;
        while (cursor < random_value) {
            cursor = cursor + *vector::borrow<u64>(&weights, i);
            i = i + 1;
        };

        i 
    }
}
