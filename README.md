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