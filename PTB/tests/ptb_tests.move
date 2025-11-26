#[test_only]
module ptb::ptb_tests {
    use sui::test_scenario;
    use ptb::ptb;
    use challenge::transaction_blocks;

    #[test]
    fun test_ptb() {
        let owner = @0xA;
        let mut scenario = test_scenario::begin(owner);
        
        // 1. Create (using external package)
        {
            let ctx = test_scenario::ctx(&mut scenario);
            let obj = transaction_blocks::create_object(ctx);
            
            // 2. Emit event (using our module)
            ptb::emit_event(&obj);
            
            // 3. Destroy (using external package)
            transaction_blocks::destroy_object(obj);
        };

        test_scenario::end(scenario);
    }
}
