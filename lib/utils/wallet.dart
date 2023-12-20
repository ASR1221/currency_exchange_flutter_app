import 'package:bip39/bip39.dart' as bip39;
import 'package:web3dart/web3dart.dart';
import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:hex/hex.dart';
import 'package:http/http.dart' as http;

import '../constants/wallet.dart' as walletConstants;

abstract class WalletAddressService {
  String generateMnemonic();
  Future<String> getPrivateKey(String mnemonic);
  EthereumAddress getPublicKey(String privateKey);
  Future<void> sendTransaction(
    String receiver,
    EtherAmount txValue,
    String privateKey,
  );
}

class WalletAddress implements WalletAddressService {
  @override
  String generateMnemonic() {
    return bip39.generateMnemonic();
  }

  @override
  Future<String> getPrivateKey(String mnemonic) async {
    final seed = bip39.mnemonicToSeed(mnemonic);
    final master = await ED25519_HD_KEY.getMasterKeyFromSeed(seed);
    final privateKey = HEX.encode(master.key);
    return privateKey;
  }

  @override
  EthereumAddress getPublicKey(String privateKey) {
    final private = EthPrivateKey.fromHex(privateKey);
    final address = private.address;
    return address;
  }

  @override
  Future<void> sendTransaction(
    String receiver,
    EtherAmount txValue,
    String privateKey,
  ) async {

    var apiUrl = walletConstants.url;
    var httpClient = http.Client();
    var ethClient = Web3Client(apiUrl, httpClient);

    EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);

    EtherAmount gasPrice = await ethClient.getGasPrice();

    try {
      await ethClient.sendTransaction(
        credentials,
        Transaction(
          to: EthereumAddress.fromHex(receiver),
          gasPrice: gasPrice,
          maxGas: 100000,
          value: txValue,
        ),
        chainId: 11155111,
      );
    } catch (e) {

    } finally {
      await ethClient.dispose();
    }
  }
}
