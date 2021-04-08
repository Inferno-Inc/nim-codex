import std/random
import pkg/nitro

proc example*(_: type EthAddress): EthAddress =
  EthPrivateKey.random().toPublicKey.toAddress

proc example*(_: type UInt256): UInt256 =
  var bytes: array[32, byte]
  for b in bytes.mitems:
    b = rand(byte)
  UInt256.fromBytes(bytes)

proc example*(_: type UInt48): UInt48 =
  # workaround for https://github.com/nim-lang/Nim/issues/17670
  uint64.rand mod (UInt48.high + 1)

proc example*(_: type SignedState): SignedState =
  var wallet = Wallet.init(EthPrivateKey.random())
  let hub, asset, receiver = EthAddress.example
  let chainId, amount = UInt256.example
  let nonce = UInt48.example
  let channel = wallet.openLedgerChannel(hub, chainId, nonce, asset, amount).get
  wallet.pay(channel, asset, receiver, amount).get