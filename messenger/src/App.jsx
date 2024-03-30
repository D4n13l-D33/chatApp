import { useState } from "react";
import { configureWeb3Modal } from "./connection";
import '@radix-ui/themes/styles.css';
import Header from './components/Header'
import Tab from "./components/Tab";


configureWeb3Modal();
function App() {
    return (
    <>
    <Header />
    <Tab />
    </>
  );
}

export default App
