import 'dart:convert';

import 'package:bip39/bip39.dart' as bip39;
import 'package:web3dart/web3dart.dart';
import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:hex/hex.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

import '../constants/wallet.dart' as walletConstants;

abstract class WalletAddressService {
  String generateMnemonic();
  Future<String> getPrivateKey(String mnemonic);
  EthereumAddress getPublicKey(String privateKey);
  Future<void> sendTransaction(
    String receiver,
    String amountValueTx,
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
    String amountValueTx,
    String privateKey,
  ) async {

    dynamic apiUrl = walletConstants.url;
    dynamic httpClient = http.Client();
    dynamic ethClient = Web3Client(apiUrl, httpClient);

    EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);

    double amount = double.parse(amountValueTx);
    BigInt bigIntValue = BigInt.from(amount * pow(10, 18));

    EtherAmount ethAmount = EtherAmount.fromBigInt(EtherUnit.wei, bigIntValue);

    EtherAmount gasPrice = await ethClient.getGasPrice();

    try {
      await ethClient.sendTransaction(
        credentials,
        Transaction(
          to: EthereumAddress.fromHex(receiver),
          gasPrice: gasPrice,
          maxGas: 100000,
          value: ethAmount,
        ),
        chainId: 11155111,
      );
    } catch (e) {

    } finally {
      await ethClient.dispose();
    }
  }

  Future getBalance(String publicKey) async {

    Map<String, dynamic> requestBodyData = {
      "jsonrpc":"2.0",
      "method":"eth_getBalance",
      "params": [publicKey, "safe"],
      "id":1,
    };

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    http.Response response = await http.post(Uri.parse(walletConstants.url), headers: headers, body: jsonEncode(requestBodyData));

    if (response.statusCode != 200) {
      return null;
    }

    return jsonDecode(response.body);
  }
}
