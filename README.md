# Aptos Random with Weights

Randomness on Aptos with weights

### Create a default profile
```
aptos init
aptos init --profile player
```

### Compiles
```
aptos move compile --named-addresses deployer=default
```

### Deploy
```
aptos move publish --named-addresses deployer=default
```

### Run scripts to test
You need to deploy the contract first, then run the following scripts:
```
npm i
cd scripts/
# Copy the .env fiel
cp .env.example .env
# Test randomness
node call-random.js
```

### Explain the algorithm
The first step  is to determine the total weights:
```
let total_weights = 0u64;
vector::for_each<u64>(weights, | value | {
    total_weights = total_weights + value;
});
```
Next, we generate a random number within the range of 1 to the total weight:
```
let random_value = randomness::u64_range(1, total_weights);
```
This random number is to determine where is the landed position. We're moving the cursor from left to right by incrementing it by the weight of each element:
```
let cursor = 0u64;
let i = 0u64;
loop {
    cursor = cursor + *vector::borrow<u64>(&weights, i);
    if (cursor >= random_value) break;
    i = i + 1;
};

i
```
When the loop stops, we will get "i" as the index in the array values.