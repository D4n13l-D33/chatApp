import { ethers } from "ethers";
import { useCallback } from "react";
import { isSupportedChain } from "../utils";
import { getProvider } from "../constants/providers";
import {
  useWeb3ModalAccount,
  useWeb3ModalProvider,
} from "@web3modal/ethers/react";
import nameServiceABI from "../constants/ABIs/nameServiceABI.json";

const UseRegisterHook = (name) => {

    const { chainId } = useWeb3ModalAccount();
    const { walletProvider } = useWeb3ModalProvider();

     return useCallback(async () => {
        if (!isSupportedChain(chainId)) return console.error("Wrong network");
        const readWriteProvider = getProvider(walletProvider);
        const signer = await readWriteProvider.getSigner();

        console.log(signer, readWriteProvider);
        console.log(
          import.meta.env.VITE_staking_contract_address,
          readWriteProvider
        );

        const nameServiceContract = new ethers.Contract(
          import.meta.env.VITE_NAME_SERVICE_CONTRACT_ADDRESS,
          nameServiceABI,
          signer
        );
        console.log("connected");

        const register = await nameServiceContract.createENS(name);

        const registerReceipt = await register.wait();

        if (registerReceipt.status) {
            return console.log("registered");
        }

        return console.log("registration failed")
    



  }, [name,chainId, walletProvider]);

}

export default UseRegisterHook;