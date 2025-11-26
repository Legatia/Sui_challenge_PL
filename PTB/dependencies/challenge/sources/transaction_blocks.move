module challenge::transaction_blocks {
    use sui::object::{Self, ID, UID};
    use sui::tx_context::TxContext;
    use sui::event;

    /// Event emitted when an object is created
    public struct ObjectCreated has copy, drop {
        object_id: ID
    }

    /// Event emitted when an object is destroyed
    public struct ObjectDestroyed has copy, drop {
        object_id: ID
    }

    /// The main object type for this challenge
    public struct MoveObject has key {
        id: UID,
        epoch_created: u64,
    }

    /// Create a new MoveObject
    public fun create_object(ctx: &mut TxContext): MoveObject {
        let obj = MoveObject {
            id: object::new(ctx),
            epoch_created: ctx.epoch_timestamp_ms(),
        };
        
        event::emit(ObjectCreated {
            object_id: object::id(&obj),
        });
        
        obj
    }

    /// Destroy a MoveObject
    public fun destroy_object(obj: MoveObject) {
        let object_id = object::id(&obj);
        let MoveObject { id, epoch_created: _ } = obj;
        
        event::emit(ObjectDestroyed {
            object_id,
        });
        
        object::delete(id);
    }

    /// Get the epoch when the object was created
    public fun epoch_created(obj: &MoveObject): u64 {
        obj.epoch_created
    }
}
