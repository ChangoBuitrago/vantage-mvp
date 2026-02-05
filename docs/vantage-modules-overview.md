# Vantage Modules Overview

**Read this first.** This document explains the three modules that make up Vantage and how to navigate to their detailed specs.

---

## What is Vantage?

Vantage is a **governance layer** for digital product passports (NFTs). When a reseller sells an asset, they pay an **exit tax** (royalty) via Stripe; only then can the NFT transfer to the new owner. The physical sale happens elsewhere (eBay, private sale, etc.); Vantage only governs the **digital twin** and enforces brand rules (royalties, transfer locks).

---

## Three Modules

The system is split into three parts you can build and test **separately**, then **combine**.

### [Module A — Identity & Wallet](./vantage-module-a-identity-wallet.md)

**"The Client"**

* **What it does:** Logs users in, displays their Vault, and **executes the transfer**. It acts as the "steering wheel" for the user.
* **Key Responsibility:** Takes the permit from Module C and submits the transaction to Module B.
* **Tech:** Magic (Auth), Alchemy AA (Gasless Execution), React/Next.js.

### [Module B — Chain / Governance](./vantage-module-b-chain.md)

**"The Road"**

* **What it does:** The on-chain NFT contract. It blocks all standard transfers and only allows movement via the `settle()` function if a valid permit is provided.
* **Key Responsibility:** Security and final settlement. It trusts no one except the cryptographic signature from Module C.
* **Tech:** Solidity, OpenZeppelin (ERC-721), Hardhat (Polygon).

### [Module C — Settlement Orchestration](./vantage-module-c-settlement.md)

**"The Permit Vending Machine"**

* **What it does:** Calculates the royalty, accepts Fiat payment (Stripe), and issues a cryptographic **Permit**. It is **stateless**—it does not execute blockchain transactions itself.
* **Key Responsibility:** Verifying payment and signing the permit key.
* **Tech:** Node.js (Lambda), DynamoDB, Stripe API.

---

## How They Work Together

```mermaid
graph LR
    subgraph User_Layer [User]
        U[Reseller]
    end

    subgraph Modules [The Stack]
        A["A. Frontend (App)"]
        C["C. Backend (API)"]
        B["B. Contract (Chain)"]
    end

    U -->|1. Clicks Pay| A
    A -->|2. Stripe Payment| C
    C -->|3. Returns Permit| A
    A -->|4. Executes settle| B
```

**The Critical Flow:**

1. **Reseller pays** via Module C (Stripe).
2. Module C marks the transfer as `PAID` and **generates a Permit** (signature).
3. Module A (Frontend) **claims the Permit** and submits the `settle()` transaction to Module B.
4. Module B verifies the signature and moves the NFT.

---

## Developer Roles & Build Order

To move fast, we split development into two parallel tracks:

### Track 1: The Product Lead (Dev 1)

* **Owns:** **Module A** (Frontend) + **Client-Side Integration**.
* **Tasks:**
1. Build Login & Vault UI.
2. Build the "Sell" form.
3. **Crucial:** Write the logic that calls `GET /permit` and sends the UserOp to Alchemy.



### Track 2: The Protocol Lead (Dev 2)

* **Owns:** **Module B** (Chain) + **Module C** (Backend).
* **Tasks:**
1. **First Priority:** Write & Deploy Module B (Contract) to Testnet. (Dev 1 needs the Address & ABI).
2. Build the Stripe Integration.
3. Implement the "Permit Signing" logic (Crypto).



---

## Next Steps

1. **Dev 2** starts **Module B**: Deploy the contract to Polygon Amoy.
2. **Dev 1** starts **Module A**: Create the Next.js repo and integrate Magic.link.
3. **Converge**: Once the contract is deployed, Dev 1 connects the "My Vault" UI to the real contract address.
