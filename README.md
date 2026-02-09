# Vantage MVP

Governance layer for digital product passports (NFTs): exit tax (royalty) via Stripe, then permit-gated on-chain transfer. **Build modules independently, combine later.**

## Docs

| Doc | Description |
|-----|--------------|
| [Modules overview](docs/vantage-modules-overview.md) | How A, B, and C fit together |
| [Module A — Identity & Wallet](docs/vantage-module-a-identity-wallet.md) | Auth (Magic), Alchemy AA, NFT list & transfer history |
| [Module B — Settlement](docs/vantage-module-b-settlement.md) | Quote API, Stripe, permit generation (stateless) |
| [Module C — Chain](docs/vantage-module-c-chain.md) | VantageAssetRegistry (ERC-721, EIP-712, Foundry, Polygon) |

## Quick flow

1. Reseller pays exit tax via **B** (Stripe).
2. **B** marks transfer `PAID` and issues a permit (EIP-712 signature).
3. Frontend **A** claims the permit and calls `settle()` on **C** (gasless via Alchemy AA).
4. **C** verifies the signature and transfers the NFT.
