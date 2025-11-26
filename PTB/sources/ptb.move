module ptb::ptb {
    // use sui::object::{Self, ID}; // Implicitly available
    use sui::event;
    use challenge::transaction_blocks::{MoveObject, epoch_created};

    /// The event that will be emitted
    public struct ChallengeEvent has copy, drop {
        object_id: ID,
        epoch_created: u64,
    }

    /// Emit an event with the object's ID and epoch created
    public fun emit_event(obj: &MoveObject) {
        event::emit(ChallengeEvent {
            object_id: object::id(obj),
            epoch_created: epoch_created(obj),
        });
    }
}
