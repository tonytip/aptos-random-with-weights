module deployer::main {
    use std::signer;
    use std::simple_map::{Self, SimpleMap};

    use deployer::random;

    struct Manager has key, store {
        admin_addr: address,
        weights: vector<u64>
    }

    struct RandomResult has key, store {
        results: SimpleMap<u64, u64>
    }

    fun init_module(deployer: &signer) {
        move_to(deployer, Manager {
            admin_addr: @deployer,
            weights: vector[600, 500, 800, 600, 800, 900]
        });
    }

    #[randomness]
    entry fun roll(player: &signer, key: u64) acquires Manager, RandomResult {
        let player_addr = signer::address_of(player);
        let resource = borrow_global<Manager>(@deployer);

        let random_value = random::random_by_weights(resource.weights);

        if (exists<RandomResult>(player_addr) == false) {
            move_to(player, RandomResult { results: simple_map::new() });
        };

        let player_results = borrow_global_mut<RandomResult>(player_addr);
        simple_map::upsert<u64, u64>(&mut player_results.results, key, random_value);

    }

    #[view]
    public fun get_random_result(player_addr: address, key: u64): u64 acquires RandomResult {
        let player_results = borrow_global<RandomResult>(player_addr);
        let rand = simple_map::borrow(&player_results.results, &key);
        *rand
    }



}
