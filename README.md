# Vantage MVP

Governance layer for digital product passports (NFTs): exit tax (royalty) via Stripe, then permit-gated on-chain transfer.

## Docs

| Doc | Description |
|-----|--------------|
| [Modules overview](docs/vantage-modules-overview.md) | How A, B, and C fit together |
| [Module A — Identity & Wallet](docs/vantage-module-a-identity-wallet.md) | Auth (Magic), Alchemy AA, NFT list & transfer history |
| [Module B — Settlement](docs/vantage-module-b-settlement.md) | Quote API, Stripe, permit generation (stateless) |
| [Module C — Chain](docs/vantage-module-c-chain.md) | VantageAssetRegistry (ERC-721, EIP-712, Foundry, Polygon) |
