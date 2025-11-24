module rabbit_nft::rabbit {
    use sui::package;
    use sui::display;
    use std::string::{String, utf8};

    public struct RabbitNFT has key, store {
        id: UID,
        name: String,
        image_url: String,
        description: String,
    }

    public struct RABBIT has drop {}

    fun init(otw: RABBIT, ctx: &mut TxContext) {
        let keys = vector[
            utf8(b"name"),
            utf8(b"image_url"),
            utf8(b"description"),
        ];

        let values = vector[
            utf8(b"{name}"),
            utf8(b"{image_url}"),
            utf8(b"{description}"),
        ];

        let publisher = package::claim(otw, ctx);
        let mut display = display::new_with_fields<RabbitNFT>(
            &publisher, keys, values, ctx
        );

        display.update_version();

        transfer::public_transfer(publisher, tx_context::sender(ctx));
        transfer::public_transfer(display, tx_context::sender(ctx));
    }

    #[allow(lint(self_transfer))]
    public fun mint(
        name: String,
        image_url: String,
        description: String,
        ctx: &mut TxContext
    ) {
        let nft = RabbitNFT {
            id: object::new(ctx),
            name,
            image_url,
            description,
        };

        transfer::public_transfer(nft, tx_context::sender(ctx));
    }
}
