use app::WASM_BINARY_OPT;
use app_io::*;
use app_state::{WASM_BINARY, WASM_EXPORTS};
use gclient::{EventProcessor, GearApi, Result};
use gstd::{prelude::*, ActorId};

const ALICE: [u8; 32] = [
    212, 53, 147, 199, 21, 253, 211, 28, 97, 20, 26, 189, 4, 169, 159, 214, 130, 44, 133, 88, 133,
    76, 205, 227, 154, 86, 132, 231, 165, 109, 162, 125,
];

#[tokio::test]
#[ignore]
async fn gclient_test() -> Result<()> {
    let client = GearApi::dev_from_path(env!("GEAR_NODE_PATH")).await?;
    let mut listener = client.subscribe().await?;

    let mut gas_limit = client
        .calculate_upload_gas(None, WASM_BINARY_OPT.into(), vec![], 0, true)
        .await?
        .min_limit;
    let (mut message_id, program_id, _) = client
        .upload_program_bytes(
            WASM_BINARY_OPT,
            gclient::now_micros().to_le_bytes(),
            [],
            gas_limit,
            0,
        )
        .await?;

    assert!(listener.message_processed(message_id).await?.succeed());

    gas_limit = client
        .calculate_handle_gas(None, program_id, PingPong::Ping.encode(), 0, true)
        .await?
        .min_limit;
    (message_id, _) = client
        .send_message(program_id, PingPong::Ping, gas_limit, 0)
        .await?;

    let (_, raw_reply, _) = listener.reply_bytes_on(message_id).await?;

    assert_eq!(
        PingPong::Pong,
        Decode::decode(
            &mut raw_reply
                .expect("action failed, received an error message instead of a reply")
                .as_slice()
        )?
    );

    let state_binary = WASM_BINARY.to_vec();

    assert_eq!(
        client
            .read_state_using_wasm::<_, u128>(
                program_id,
                WASM_EXPORTS[2],
                state_binary.clone(),
                Some(ActorId::from(ALICE))
            )
            .await?,
        1
    );

    assert_eq!(
        client
            .read_state_using_wasm::<(), Vec<ActorId>>(
                program_id,
                WASM_EXPORTS[1],
                state_binary,
                None
            )
            .await?,
        vec![ALICE.into()]
    );

    Ok(())
}
