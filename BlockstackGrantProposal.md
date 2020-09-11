# Background

> What problems do you aim to solve? How does it serve the mission of a user owned internet?

Auctions for non-fungible assets, or NFTs, have been a killer app in the Ethereum ecosystem but have also, with the success of CryptoKitties, way back in 2017, displayed its Achilles heel.

Our experience of this pain has been - and continues to be - first hand. Our own Digital Collectibles app [Loopbomb](loopbomb.com), originally developed as a Blockstack app that now relies on Ethereum for minting, currently costs one buck to mint a loop and ~ 4000% on top to pay the gas fees. The situation is so bad that it has brought trading to an abrupt stop for all the awesome art projects currently trading on OpenSea.

These NFT projects need a new ecosystem to grow and the combination of Gaia, Clarity and the Stacks 2.0 blockchain is for us the only way to go. Bitcoin level security plus genuine user-owned data via Gaia!

Our own background, building [bidlogix](https://bidlogix.net/), in white labeled online auctions and asset management on Web 2.0 means we bring real world experience and relationships from the online auction space to the world of blockchain. Clients such as [GE Warehouse](https://www.gewarehouse.com/auction-030/home), [Hilco Industrial](https://www.hilcoind.com/en/) and [John Pye](https://www.johnpye.co.uk/auctions/type/general/) are currently running multi-million dollar event-based auctions and auctioneers in arts and collectibles like [Gorringes](https://www.gorringes.co.uk/) and [Thorntons](https://www.thorntons.net.nz/online-bidding#!/) use the bidding platform to run live webcast auctions in real time against bidders present in the auction house.

Combining these experiences, leads us to propose an ambitious plan to build bidding software on Stacks 2.0 that starts with the small, but rapidly growing, marketplace of Digital Collectibles and reaches beyond this to the multi-billion dollar markets in auctions of real world physical assets.

Our vision and conviction is that this will attract a plethora of other projects to the Stacks blockchain to compete, and create genuine innovation and end user choice in the user owned Internet.

The following proposal is in support of this vision and enables us to accelerate into the next stage of our journey towards its realisation and the further development of a user owned Internet by using blockchain to solve the real world problems from lack of data privacy to illicit practices and to add real value to all players from the auctioneers to the buyers and sellers.

**Please see our full [Project Plan](https://risidio.com/Risidio_rBid_Proposal_0-1.pdf)**

## Project Overview

> What solution are you providing? Who will it serve?

In our view, OpenSea is a fantastic project. However, our intimate involvement with the platform - via our experience to date with Loopbomb – has convinced us that we can improve their general architecture in several key ways and informs our overall understanding of the project requirements as outlined below.

Firstly, the OpenSea marketplace depends on a token counter in the ERC contract to uniquely identify an asset, as opposed to a hash of the artwork file. The second is that the design requires a centralised API which maps the counter to metadata in order to locate the NFT. These design issues lead to some serious security problems. For example, a hacker gaining access to the central API database can scramble NFT ownership - there is no hard association between the minted NFT and the actual asset.

OpenSea also has a tendency to mix asset types within the same marketplace – e.g. rare digital art often gets swamped out by dozens of plain images of [crypto domain names](https://opensea.io/assets).

Thinking beyond digital assets to the physical realm, helps to make it clear that segmentation by asset type is vital for scaling auction software on Stacks 2.0. A user is unlikely to buy a Stradivarius violin from a site that also sells second-hand cars or CNC lathes. We believe getting these partitions right in the Clarity layer is also a key indicator to success in this field.

In our view, the right design of a fully featured decentralised marketplace as an umbrella for DC projects on Stacks 2.0 using Clarity contracts, Gaia, and a stateless (Lucene / Radiks) search index, will pave the way for real world physical auctioneers currently on Web 2.0 to begin to take advantage of the high value blockchain propositions, incorporating:

- On chain assetregistration
- Data privacy
- Self-sovereign identity
- Transparent fraud proof auction functionality

We have already proven many of the principles of this design with earlier projects in app mining; dbid and [radicle.art](https://radicle.art) as well as with [loopbomb.com](https://loopbomb.com).

## Scope

> What are the components or technical specs of the project? What will the final deliverable look like? How will you measure success?

Building something comparable to [Bidlogix](https://bidlogix.net) or [OpenSea](https://opensea.io) on Stacks 2.0 is, understandably, well beyond the scope of our current grant submission, despite the significant amount of work we’ve already completed towards this goal.

However, we would like to present here what we believe is a credible next step towards realising either one of these projects and refer the reader to other documents for an outline of our [wider ambitions](https://risidio.com/Risidio_rBid_Proposal_0-1.pdf).

The plan here - referred to as Phase One or “pilot” - is to take our Loopbomb project and convert it to a full Stacks 2.0 ready project. There are four major (product development) elements to this plan, as follows:

- Payment and Minting
- DC (Client) Project Admin and Setup
- Discovery - finding / filtering / browsing assets
- Provenance - transfer of assets between accounts

The devil is, as always, in the detail and we imagine this work will require innovation and collaboration within the Stacks 2.0 community to solve problems such as wrapping the core NFT methods, nft-mint, nft-get-owner nft-transfer, in common interfaces / traits to provide standards for Clarity NFT projects that are comparable to the ERC standards on Ethereum, which play a fundamental role in the OpenSea platform.

As with OpenSea, each individual DC project is both standalone and also a feeder for the aggregating platform. In this sense, we’re treating Loopbomb as a reference implementation - a convenient project that we can use to validate the concepts involved.

In reality, Loopbomb is way more than this as it is being actively promoted within the Ethereum / OpenSea communities. This puts the app in a really interesting position - a bridge from IPFS to Gaia and from Solidity to Clarity - a very interesting proposition for the marketing campaign we envisage!

**How are we different from OpenSea?**

- OpenSea works on ERC contracts while Loopbomb will use Clarity contracts to mint art
- OpenSea does not have a feature to create art, it is just a marketplace for DC
- Loopbomb will provide an option between ETH and STX

**How do we measure the success of Phase 1?**

Phase 1 would be deemed successful if we manage to produce the following.

- User can buy Loopbomb credits using STX, this is a change to the current credit-purchasing system using meta mask
- A bridge for the users to choose between ERC or Clarity to mint their Loops
- Presenting Loopbomb at a larger marketplace as a gallery to display minted Loops/NFTs
- Educational Platform for Loopbomb, and Clarity Smart Contracts in the long run
- Marketing materials like Twitter mentions, Discord and Forum presence, introducing Loopbomb to a new audience

**Why Blockstack should be interested?**

Blockstack is still in its testnet for Stacks V2.0. It currently has features like STX mining, Building Apps and writing contracts. Not many people use Clarity and are unaware of its usability and Stacks' added security.

Blockstack is missing a marketplace for NFTs/Digital goods. Instead of being a partner to OpenSea, Blockstack can act as an alternative to OpenSea and ETH. This can act as a trigger to bring crowd over from ETH to Blockstack space and bringing new business not just in commissions but also introducing a new audience to Stacking and Mining on Stacks 2.0.

## Budget and Milestones

> What grant amount are you seeking? How long will the project take in hours? If more than 20, please break down the project into milestones, with a clear output (e.g., low-fi mockup, MVP with two features) and include the estimated work hours for each milestone.

We are asking for the full $5,000. Our costing for this work is roughly $15,000 (see appendix 1) - so we propose investing $10,000 ourselves to deliver the project. We use Agile methodology. The project is delivered iteratively in 2 week cycles - so milestones are actually sprints and the features undertaken in each sprint are written as user stories, scoped and agreed with by the team. Unit tests are assumed part of feature development. Delivery will happen roughly as follows;

Milestone / Sprint 1 - 190 hours;

Completed work in the first sprint;

- UX design
- Wireframes
- Infrastructure established
  * search engine configured and deployed via docker container
  * nginx configured for rBid vhost
- Test plan - Cypress integration tests - begun
- Feature: STX Payment
  * As a user I want to buy credits for a loop with STX tokens in the same way that I buy them today for ETH or Lightning BTC
- Feature: Minting loops on Stacks 2.0
  * As a user I want to mint my loops on the Stacks 2.0
  * As a user I want to be able to independently check the existence of my loop - e.g. via a blockchain explorer
- Script for video explainer written

Milestone / Sprint 2

Completed work in the second sprint - 90 hours;

- Feature: Administration and registration of Digital Collectible projects,
  * As Loopbomb administrator I need to register the details (name, logo, description etc) of my project
  * As Loopbomb administrator I need to connect the address of my Clarity contract to my project
- Feature: Search / filter / browse collectibles
  * As a user I want to be able to find an asset by project
  * As a user I want to be able to find an asset by title / description
  * As a user I want to be able to find assets created in time window
  * As a user I want to be able to page through assets
- Feature: Buy / sell / transfer Loopbomb between two Blockstack accounts
  * As a user I want to be able to set a price for my loop and mark it for sale.
  * As a user I want to be able to buy a loop from another user (Note: transfer within the contract is easy but the asset also needs to transfer from the Gaia storage of the seller to the buyer. The contract maintains the state information needed to do this - much easier than the old pre Stacks way!)
- Video explainer made

Milestone / Sprint 3

Completed work in the third sprint - 20 hours;

- Market research undertaken to support continued development
- Marketing plan begun
- Marketing and community engagement
  * Reaching out for resources, collaboration etc
  * Talk to OpenSea about partnerships
  * Talk to other Digital Collectibles projects about Stacks 2.0 solutions

Budget for at least half a sprint here to complete the work that flows over from the previous two sprints.

Total = 300 hours

This puts the project at 5-6 weeks with work needed across the following skill sets;

- Project manager
- Full stack developer
- Clarity developer
- UX Designer
- Tester
- Devops
- Marketing

## Team

> Who is building this? What relevant experience do you bring to this project? Are there skills sets you are missing that you are seeking from the community?

Risidio’s team consists of a diverse range of people from all corners of the globe. Since the company’s inception in February 2020, there has been a steady growth in its human capital, with a total of 15 people currently contributing to the realisation of its mission and vision.  This team of people represent nine nationalities and speak over fifteen different languages, collectively. Some of the languages the team are fluent in include English, Russian, German, Mandarin, Italian, Spanish, Dutch and Japanese. Our multilingualism helps us bridge gaps between cultures and enables us to foster strong personal relationships on which great business relationships rely.

We are ready to and have most of the skills needed to get going but we are also actively looking for collaboration from within the community.

## Risks

> What dependencies or obstacles do you anticipate? What contingency plans do you have in place?

There are risks on several levels which include for example being early adopters of very new tech stacks to burn out through overwork. We discuss these and other risks openly and bring our combined experience to bear on mitigating and navigating them.

Stacks 2.0 has not yet reached mainnet and so any investment in building on top is high risk at this stage. Our belief in the soundness of the computer science behind Blockstack combined with support from the foundation helps to mitigate this risk.

Clarity is a very new smart contract language and support for it amongst the wider blockchain community is not yet certain. It is a LISP based language and therefore quite unfamiliar both to smart contract developers within the wider blockchain community but maybe more pertinently to the many C#, C++ and Java backend developers who might otherwise be tempted to learn smart contract programming. The partnership with Algorand, announced earlier this quarter, helps to mitigate this risk to some extent.

There are specific risks from other projects looking to support smart contracts on Bitcoin. The RSK project, although a federated solution, is allowing Ethereum projects to port their solidity ERC based contracts directly onto their Bitcoin sidechain - this represents risks to Blockstack from loss of market share and threatens ability to gain traction. Likewise Giacomo Zucco’s RGB project poses a similar distraction - drawing developers away from Stacks 2.0 in the hope of registering assets using the Lightning network.

## Community and Supporting Materials

> Do you have previous projects, code commits, or experiences that are relevant to this application? What community feedback or input have you received? How do you plan to share your plan to the community over time and as the final deliverable?

Our code base is under @radicleart on GitHub – it’s a mixture of open source public and private repositories.
In addition to building three Blockstack apps ([dBid.io](https://dbid.io), [RadicleArt](https://radicle.art) and [Loopbomb](https://loopbomb.com), we run Brighton Blockchain Meetup and have presented numerous talks on Bitcoin, Lightning and Blockstack to our local community and have been regular contributors to Blockstack Forum over the past few years.

We’ve also taken part in several Lightning and Blockstack hackathons since the Berlin Summit in March 2018 and the second Berlin Lightning Hackathon up to the recent Clarity and #HackStacks where we are developing rStack a delegated stacking application that makes it easier for smaller stacks holders to get involved.

We won best Lightning app for Loopbomb in [Can’t be Evil 3](https://devpost.com/software/loopbomb)!

Since starting Risidio at the start of lockdown, we have been educating and training new members of the team in the importance of Bitcoin Lightning and Blockstack technologies. We are very proud of the [video explainers](https://www.youtube.com/channel/UCrMDxxhMvpeyErw7m92IIXA/?guided_help_flow=5) we’ve managed to produce as these have been an amazing team effort.

### Conclusion

We are excited by the prospect of working with you to deliver outstanding results through a well-executed development project starting with digital collectibles and moving on into a full-blown auction site based on Blockstack’s evolving capabilities.

We believe we possess exactly the sort of experience and expertise to meet and exceed your expectations and to provide an innovative and effective solution to your current needs and which, once we’ve proven its effectiveness in digital collectibles, can be applied to other markets.

We look forward to continuing our journey in developing a long-term, sustainable and mutually successful relationship with Blockstack.

**Please see our full [Proposal](https://risidio.com/Risidio_rBid_Proposal_0-1.pdf)**
