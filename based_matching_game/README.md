# Based Matching Game - Farcaster Mini App

A memory matching game where you can collect images and mint them as NFTs on Base chain.

## How to Deploy as Farcaster Mini App

### Step 1: Deploy to Web Hosting

Choose one of these free hosting services:

#### Option A: Vercel (Recommended)
1. Go to https://vercel.com
2. Sign up with GitHub
3. Click "New Project"
4. Upload this folder
5. Click "Deploy"
6. Copy your website URL (e.g., `https://your-game.vercel.app`)

#### Option B: Netlify
1. Go to https://netlify.com
2. Sign up
3. Drag and drop this folder
4. Copy your website URL (e.g., `https://your-game.netlify.app`)

### Step 2: Update Farcaster Config

1. Open `.well-known/farcaster.json`
2. Replace `https://your-domain.com` with your actual website URL
3. Save the file

### Step 3: Redeploy

Upload the updated files to your hosting service again.

### Step 4: Test in Farcaster

1. Open Warpcast (Farcaster client)
2. Share your website URL
3. Click the link to open the mini app

## NFT Contract Setup

Before minting NFTs, you need to:
1. Deploy an ERC-721 contract to Base chain
2. Update `NFT_CONTRACT_ADDRESS` in `index.html` with your contract address

## Files Structure

```
based_matching_game/
├── index.html          # Main game file
├── images/             # Game images and sounds
│   ├── base_00.jpg    # Card back
│   ├── base_top.JPG   # Start screen
│   ├── base01-15.jpg  # Collectible images
│   ├── flip.mp3       # Card flip sound
│   └── match.mp3       # Match sound
└── .well-known/
    └── farcaster.json  # Farcaster configuration
```

